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

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
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
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 100, 100, 100)];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 10;
    self.headImage.backgroundColor = RGB(0.95, 0.39, 0.21);
    [self.view addSubview:self.headImage];
    
    //手机号
    self.phoneView = [[UIView alloc]initWithFrame:CGRectMake(40, self.headImage.bottom + 90, kScreenWidth - 2*40, 40)];
    [self.view addSubview:self.phoneView];
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,self.phoneView.width , self.phoneView.height-1)];
    self.phoneText.placeholder = @"请输入您的手机号码";
    self.phoneText.textColor = UIColorFromHex(0x333333);
    [self.phoneView addSubview:self.phoneText];
    
    self.phoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.phoneText.bottom, self.phoneView.width,1 )];
    self.phoneLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [self.phoneView addSubview:self.phoneLine];
    //密码
    self.passWordView = [[UIView alloc]initWithFrame:CGRectMake(40, self.phoneView.bottom + 40 , kScreenWidth - 2*40, 40)];
    [self.view addSubview:self.passWordView];
    
    self.passWordText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,self.passWordView.width , self.passWordView.height-1)];
    self.passWordText.placeholder = @"请输入您的密码";
    self.passWordText.secureTextEntry = YES;
    self.passWordText.textColor = UIColorFromHex(0x333333);
    [self.passWordView addSubview:self.passWordText];
    
    self.passWordLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.passWordText.bottom, self.passWordView.width,1 )];
    self.passWordLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [self.passWordView addSubview:self.passWordLine];
    //忘记密码
    self.forgetPassWordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.forgetPassWordBtn.frame = CGRectMake(35, self.passWordView.bottom + 10, 70, 30);
    [self.forgetPassWordBtn setTitle:@"忘记密码" forState: UIControlStateNormal];
    [self.forgetPassWordBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    self.forgetPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.forgetPassWordBtn addTarget:self action:@selector(ForgetPassWordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPassWordBtn];
    
    //验证码登录
    self.verificationLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                                 
    self.verificationLoginBtn.frame = CGRectMake(kScreenWidth - 110, self.passWordView.bottom + 10, 80, 30);
    [self.verificationLoginBtn setTitle:@"验证码登录" forState: UIControlStateNormal];
    [self.verificationLoginBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    self.verificationLoginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.verificationLoginBtn addTarget:self action:@selector(VerificationLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.verificationLoginBtn];
    //登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginBtn.frame = CGRectMake(40, self.passWordView.bottom + 90, kScreenWidth - 80, 40);
    [self.loginBtn setTitle:@"登录" forState: UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.loginBtn.layer.cornerRadius = 20;
    [self.loginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    //注册
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerBtn.frame = CGRectMake((kScreenWidth - 120)/2, self.loginBtn.bottom + 15, 120, 30);
    [self.registerBtn setTitle:@"没有账号？去注册" forState: UIControlStateNormal];
    [self.registerBtn setTitleColor:RGB(0.96, 0.60, 0.51) forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.registerBtn addTarget:self action:@selector(RegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];

    
}

-(void)ForgetPassWordClick{
    GetBackPassWordViewController * gbpwVC = [[GetBackPassWordViewController alloc]init];
    [self.navigationController pushViewController:gbpwVC animated:YES];
}
-(void)VerificationLoginClick{
    NSLog(@"dsfsd");
    VerLoginViewController *vlVC = [[VerLoginViewController alloc]init];
    [self.navigationController pushViewController:vlVC animated:YES];
}
-(void)LoginClick{
    TabBarViewController * tbVC = [[TabBarViewController alloc]init];
    [self.navigationController pushViewController:tbVC animated:YES];
}
-(void)RegisterClick{
    RegisterViewController * rVC  = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rVC animated:YES];
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
