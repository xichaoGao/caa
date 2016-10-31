//
//  LoginViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "LoginViewController.h"
#import "VerLoginViewController.h"
#import "RegisterViewController.h"
#import "GetBackPassWordViewController.h"
#import "TabBarViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSDictionary *pramerDic;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    //设置
    statusBarView.backgroundColor = RGB(0.95, 0.39, 0.21);
    // 添加到 view 上
    [self.view addSubview:statusBarView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    //头像
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 100 * WidthRate, 100, 100)];
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 10;
    _headImage.backgroundColor = RGB(0.95, 0.39, 0.21);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user objectForKey:@"headImg"]);
     [_headImage sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImg"]] placeholderImage:[UIImage imageNamed:@"13@2x"]];
    [self.view addSubview:_headImage];
    
    //手机号
    _phoneView = [[UIView alloc]initWithFrame:CGRectMake(40, _headImage.bottom + 90* WidthRate, kScreenWidth - 2*40, 40)];
    [self.view addSubview:_phoneView];
    
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_phoneView.width , _phoneView.height-1)];
    _phoneText.placeholder = @"手机号码";
    _phoneText.delegate = self;
    _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.textColor = UIColorFromHex(0x333333);
    [self.phoneView addSubview:_phoneText];
    _phoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, _phoneText.bottom, _phoneView.width,1 )];
    _phoneLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [self.phoneView addSubview:_phoneLine];
    //密码
    _passWordView = [[UIView alloc]initWithFrame:CGRectMake(40, _phoneView.bottom + 40 , kScreenWidth - 2*40, 40)];
    [self.view addSubview:_passWordView];
    
    _passWordText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_passWordView.width , _passWordView.height-1)];
    _passWordText.placeholder = @"密码";
    _passWordText.secureTextEntry = YES;
    _passWordText.delegate = self;
    _passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;

    _passWordText.textColor = UIColorFromHex(0x333333);
    [self.passWordView addSubview:_passWordText];
    
    _passWordLine = [[UIView alloc]initWithFrame:CGRectMake(0, _passWordText.bottom,_passWordView.width,1 )];
    _passWordLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [_passWordView addSubview:_passWordLine];
    //忘记密码
    _forgetPassWordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _forgetPassWordBtn.frame = CGRectMake(35, _passWordView.bottom + 15*WidthRate, 70, 30);
    [_forgetPassWordBtn setTitle:@"忘记密码" forState: UIControlStateNormal];
    [_forgetPassWordBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    _forgetPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_forgetPassWordBtn addTarget:self action:@selector(ForgetPassWordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPassWordBtn];
    
    //验证码登录
    _verificationLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _verificationLoginBtn.frame = CGRectMake(kScreenWidth - 110, _passWordView.bottom + 15*WidthRate, 80, 30);
    [_verificationLoginBtn setTitle:@"验证码登录" forState: UIControlStateNormal];
    [_verificationLoginBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    _verificationLoginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_verificationLoginBtn addTarget:self action:@selector(VerificationLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verificationLoginBtn];
    //登录
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginBtn.frame = CGRectMake(40, _passWordView.bottom + 90*WidthRate, kScreenWidth - 80, 40);
    [_loginBtn setTitle:@"登录" forState: UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _loginBtn.layer.cornerRadius = 20;
    [_loginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    //注册
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _registerBtn.frame = CGRectMake((kScreenWidth - 120)/2, _loginBtn.bottom + 15*WidthRate, 120, 30);
    [_registerBtn setTitle:@"没有账号？去注册" forState: UIControlStateNormal];
    [_registerBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_registerBtn addTarget:self action:@selector(RegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    
}

-(void)ForgetPassWordClick{
    [self resign];
    GetBackPassWordViewController * gbpwVC = [[GetBackPassWordViewController alloc]init];
    [self.navigationController pushViewController:gbpwVC animated:YES];
}
-(void)VerificationLoginClick{
    [self resign];
    VerLoginViewController *vlVC = [[VerLoginViewController alloc]init];
    [self.navigationController pushViewController:vlVC animated:YES];
}
-(void)LoginClick{
    [self resign];
    if ([_phoneText.text isEqualToString:@""]) {
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"手机号不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (_phoneText.text.length !=11){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的不是手机号" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }else if ([_passWordText.text isEqualToString:@""]){
        
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _pramerDic = [NSDictionary dictionary];
        _pramerDic = @{@"phone":_phoneText.text,@"password":[self md5:_passWordText.text],@"code":@""};
        [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:kLogin RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
            hud.hidden = YES;
            NSLog(@"loginResult==%@",result);
            int status = [[result objectForKey:@"status"] intValue];;
            if (status == 1) {
                
                NSString *userID = [[result objectForKey:@"data"]objectForKey:@"user_id"];
                NSString *nickName = [[result objectForKey:@"data"]objectForKey:@"nickname"];
                NSString *token = [[result objectForKey:@"data"]objectForKey:@"token"];
                NSString *headImg = [[result objectForKey:@"data"]objectForKey:@"headimg"];
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:headImg forKey:@"headImg"];
                
                //给名字加密
                NSMutableDictionary *paramer = [NSMutableDictionary dictionaryWithDictionary:@{@"userID":userID,@"token":token,@"nickName":nickName}];
                EncryptionData *encryptionData = [[EncryptionData alloc] init];
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramer options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonString = [jsonData base64EncodedStringWithOptions:0];
                NSString *passPortMemberStatusMemberIDStr = [encryptionData encodeString:jsonString key:messageStr];
                
                NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
                [defult setObject:passPortMemberStatusMemberIDStr forKey:@"passPortMemberStatusMemberIDStr"];
                
                [defult synchronize];
                
                TabBarViewController * tbVC = [[TabBarViewController alloc]init];
                [self.navigationController pushViewController:tbVC animated:YES];
            }
            else{
                NSString *mess = [result objectForKey:@"message"];
                [self errorMessages:mess];
            }
        }];
    }
    
    
}
-(void)RegisterClick{
    [self resign];
    RegisterViewController * rVC  = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rVC animated:YES];
}
-(void)resign{
    [_phoneText resignFirstResponder];
    [_passWordText resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneText resignFirstResponder];
    [_passWordText resignFirstResponder];
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
