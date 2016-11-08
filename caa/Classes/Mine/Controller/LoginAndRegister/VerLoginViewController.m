//
//  VerLoginViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "VerLoginViewController.h"
#import "TabBarViewController.h"
#import "JPUSHService.h"
@interface VerLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSDictionary *pramerDic;
@property(nonatomic,assign)BOOL isTure;
@end

@implementation VerLoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"phone"] length] == 11){
        _phoneText.text = [user objectForKey:@"phone"];
    }else
        _phoneText.placeholder = @"手机号码";
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"验证码登录";
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{
    //手机号
    _phoneView = [[UIView alloc]initWithFrame:CGRectMake(40, 120*WidthRate, kScreenWidth - 2*40, 40)];
    [self.view addSubview:_phoneView];
    
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_phoneView.width , _phoneView.height-1)];
    
    _phoneText.delegate = self;
    _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.textColor = UIColorFromHex(0x333333);
    [_phoneView addSubview:_phoneText];
    
    _phoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, _phoneText.bottom, _phoneView.width,1 )];
    _phoneLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [_phoneView addSubview:_phoneLine];
    //验证码
    _verificationView = [[UIView alloc]initWithFrame:CGRectMake(40, _phoneView.bottom + 40 , kScreenWidth - 2*40, 40)];
    [self.view addSubview:_verificationView];
    
    _verificationText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_verificationView.width -140, self.verificationView.height-1)];
    _verificationText.placeholder = @"短信验证码";
    _verificationText.delegate = self;
    _verificationText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificationText.keyboardType = UIKeyboardTypeNumberPad;

    _verificationText.textColor = UIColorFromHex(0x333333);
    [_verificationView addSubview:_verificationText];
    
    _verificationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _verificationBtn.frame = CGRectMake(kScreenWidth-180, 0, 110, _verificationText.height);
    [_verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verificationBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_verificationBtn  setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    [_verificationBtn addTarget:self action:@selector(GetVerificationClick) forControlEvents:UIControlEventTouchUpInside];
    [_verificationView addSubview:_verificationBtn];
    
    _verificationLine = [[UIView alloc]initWithFrame:CGRectMake(0, _verificationText.bottom, _verificationView.width,1 )];
    _verificationLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [_verificationView addSubview:_verificationLine];
    
    //登录
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginBtn.frame = CGRectMake(40,_verificationView.bottom + 110*WidthRate, kScreenWidth - 80, 60);
    [_loginBtn setTitle:@"登录" forState: UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _loginBtn.layer.cornerRadius = 30;
    [_loginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];

}
//获取验证码事件
-(void)GetVerificationClick{
    [self resign];
    if ([_phoneText.text isEqualToString:@""]) {
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"手机号不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (_phoneText.text.length != 11){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的不是手机号" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }else{
        [self againCrateBtn];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _pramerDic = [NSDictionary dictionary];
        _pramerDic = @{@"phone":_phoneText.text,@"authPhone":@"0"};
        [[GetDataHandle sharedGetDataHandle] analysisDataWithType:@"POST" SubUrlString:kSendVefification RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
            hud.hidden = YES;
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"获取验证码成功" delegate:self cancelButtonTitle: nil otherButtonTitles:nil, nil];
            alert.backgroundColor = UIColorFromHex(0xe8e8e8);
            [alert show];
            [self performSelector:@selector(dismiss:)withObject:alert afterDelay:0.1];            int  Status = [[result objectForKey:@"status"] intValue];
            NSLog(@"status ----%d",(int)[result objectForKey:@"status"]);
            
            if ( Status == 1 ) {
                [self controlTheTime];
                
            }
            else{
                NSString *mess = [result objectForKey:@"message"];
                [self errorMessages:mess];
                
            }
        }];
    }
}
-(void)dismiss:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

//验证码登录事件
-(void)LoginClick{
    [self resign];
    
    if ([_phoneText.text isEqualToString:@""]) {
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"手机号不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }else if ([_verificationText.text isEqualToString:@""]){
        
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"验证码不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }

    [self login];
}

-(void)login{

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.pramerDic = [NSDictionary dictionary];
        _pramerDic = @{@"phone":_phoneText.text,@"password":@"",@"code":_verificationText.text};
        [[GetDataHandle sharedGetDataHandle] analysisDataWithType:@"POST" SubUrlString:kLogin RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
            hud.hidden = YES;
            [self resign];
            int status = [[result objectForKey:@"status"] intValue];
            if (status == 1) {
                
               NSString *userID = [@"d" stringByAppendingFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"user_id"]];
                NSString *nickName = [[result objectForKey:@"data"]objectForKey:@"nickname"];
                NSString *token = [[result objectForKey:@"data"]objectForKey:@"token"];
                NSString *headImg = [[result objectForKey:@"data"]objectForKey:@"headimg"];
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:headImg forKey:@"headImg"];

                NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
                [defult setObject:userID forKey:@"userID"];
                [defult setObject:nickName forKey:@"nickName"];
                [defult setObject:token forKey:@"token"];
                [defult setObject:_phoneText.text forKey:@"phone"];
                [defult synchronize];
                
                [JPUSHService setTags:nil aliasInbackground:userID];
                TabBarViewController * tbVC = [[TabBarViewController alloc]init];
                [self.navigationController pushViewController:tbVC animated:YES];
                
            }else{
                NSString *mess = [result objectForKey:@"message"];
                [self errorMessages:mess];
            }
        }];

}
- (void)againCrateBtn
{
    _verificationBtn.userInteractionEnabled = NO;
    self.showTime = 60;
    NSString *time = [NSString stringWithFormat:@"%ld",(long)self.showTime];
    _verificationBtn.backgroundColor =  RGB(153, 153, 153);
    [_verificationBtn setTitle:[time stringByAppendingString:@"s后重发"] forState:UIControlStateNormal];
    [_verificationBtn setTitleColor:RGB(0.54, 0.54, 0.54) forState:UIControlStateNormal];
    [_verificationBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
}
#pragma mark-- 倒计时关联方法

- (void)controlTheTime
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(controlTheTimeFnid:) userInfo:nil repeats:YES];
}

- (void)controlTheTimeFnid:(NSTimer *)time
{
    self.showTime --;
    if (_showTime  == 0) {
        [_timer invalidate];
        [_verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verificationBtn.userInteractionEnabled = YES;
        [_verificationBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
        [_verificationBtn setBackgroundColor:[UIColor clearColor]];
        [_verificationBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
    if (_showTime > 0) {
        NSString *time = [NSString stringWithFormat:@"%ld",(long)_showTime];
        _verificationBtn.userInteractionEnabled = NO;
        [_verificationBtn setTitle:[time stringByAppendingString:@"s后重发"] forState:UIControlStateNormal];
        [_verificationBtn setTitleColor:RGB(0.54, 0.54, 0.54) forState:UIControlStateNormal];
        [_verificationBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
}
-(void)resign{
    [_phoneText resignFirstResponder];
    [_verificationText resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneText resignFirstResponder];
    [_verificationText resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
