//
//  RegisterViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSDictionary *pramerDic;
@property(nonatomic,assign)BOOL isTure;


@end

@implementation RegisterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI{
    //手机号
    _phoneView = [[UIView alloc]initWithFrame:CGRectMake(40, 90*WidthRate, kScreenWidth - 2*40, 40)];
    [self.view addSubview:_phoneView];
    
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_phoneView.width , _phoneView.height-1)];
    _phoneText.placeholder = @"手机号码";
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
    
    _verificationText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_verificationView.width-140 , self.verificationView.height-1)];
    _verificationText.placeholder = @"短信验证码";
    _verificationText.delegate = self;
    _verificationText.clearButtonMode = UITextFieldViewModeWhileEditing;

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
    
    //密码
    _passWordView = [[UIView alloc]initWithFrame:CGRectMake(40, _verificationView.bottom + 40 , kScreenWidth - 2*40, 40)];
    [self.view addSubview:_passWordView];
    
    _passWordText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_passWordView.width , _passWordView.height-1)];
    _passWordText.placeholder = @"登录密码";
    _passWordText.secureTextEntry = YES;
    _passWordText.delegate = self;
    _passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;

    _passWordText.textColor = UIColorFromHex(0x333333);
    [self.passWordView addSubview:_passWordText];
    
    _passWordLine = [[UIView alloc]initWithFrame:CGRectMake(0, _passWordText.bottom,_passWordView.width,1 )];
    _passWordLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [self.passWordView addSubview:_passWordLine];
    
    
    //确认密码
    _againPassWordView = [[UIView alloc]initWithFrame:CGRectMake(40, _passWordView.bottom + 40 , kScreenWidth - 2*40, 40)];
    [self.view addSubview:_againPassWordView];
    
    _againPassWordText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_againPassWordView.width , _againPassWordView.height-1)];
    _againPassWordText.placeholder = @"再次输入登录密码";
    _againPassWordText.secureTextEntry = YES;
    _againPassWordText.delegate = self;
    _againPassWordText.clearButtonMode = UITextFieldViewModeWhileEditing;

    _againPassWordText.textColor = UIColorFromHex(0x333333);
    [_againPassWordView addSubview:_againPassWordText];
    
    _againPassWordLine = [[UIView alloc]initWithFrame:CGRectMake(0, _againPassWordText.bottom,_againPassWordView.width,1 )];
    _againPassWordLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [_againPassWordView addSubview:_againPassWordLine];
    
    
    
    //注册
    _registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _registerBtn.frame = CGRectMake(40, _againPassWordView.bottom + 90*WidthRate, kScreenWidth - 80, 60*WidthRate);
    [_registerBtn setTitle:@"注册" forState: UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _registerBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _registerBtn.layer.cornerRadius = 30*WidthRate;
    [_registerBtn addTarget:self action:@selector(RegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
}

-(void)GetVerificationClick{
    [self resign];
    if ([_phoneText.text isEqualToString:@""]) {
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"手机号不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (_phoneText.text.length <11){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的不是手机号" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }else{
        [self againCrateBtn];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                self.pramerDic = [NSDictionary dictionary];
                _pramerDic = @{@"phone":_phoneText.text,@"authPhone":@"1"};
                [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:kSendVefification RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
                    hud.hidden = YES;
                    int  status = [[result objectForKey:@"status"] intValue];;
                    if (status == 1) {
                        [self againCrateBtn];
                        [self controlTheTime];
        
                    }else{
                        NSString *mess = [result objectForKey:@"message"];
                       
                        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:mess buttonTitles:@"确定", nil];
                        [alert showInView:self.view completion:nil];
                        [alert showInView:self.view completion:^(HYAlertView *alertView, NSInteger selectIndex) {
                            LoginViewController * logVC = [[LoginViewController alloc]init];
                            [self.navigationController pushViewController:logVC animated:YES];
                        }];
                       
                    }
                }];
    }
}
-(void)RegisterClick{
    [self resign];
    if ([_phoneText.text isEqualToString:@""]) {
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"手机号不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (_phoneText.text.length !=11){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的不是手机号" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }else if ([_verificationText.text isEqualToString:@""]){
        
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"验证码不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    
    else if ([_passWordText.text isEqualToString:@""]){
        
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if ([_againPassWordText.text isEqualToString:@""]){
        
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (![_againPassWordText.text isEqualToString:_passWordText.text]){
        
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不一致" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }

    else{
        
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _pramerDic = [NSDictionary dictionary];
        _pramerDic = @{@"phone":_phoneText.text,@"password":_passWordText.text,@"code":  [self md5:_verificationText.text]};
                       [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:kRegister RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
                    hud.hidden = YES;
                    [self resign];
                    NSLog(@"loginResult==%@",result);
                    int status = [[result objectForKey:@"status"] intValue];;
                    if ( status == 1) {
                        LoginViewController * logVC = [[LoginViewController alloc]init];
                        [self.navigationController pushViewController:logVC animated:YES];

                    }
                    else{
                        NSString *mess = [result objectForKey:@"message"];
                        [self errorMessages:mess];
                    }
                }];
    }
    
    
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
    [_passWordText resignFirstResponder];
    [_againPassWordText resignFirstResponder];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneText resignFirstResponder];
    [_verificationText resignFirstResponder];
    [_passWordText resignFirstResponder];
    [_againPassWordText resignFirstResponder];
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
