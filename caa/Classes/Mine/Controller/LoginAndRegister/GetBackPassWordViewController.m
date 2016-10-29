//
//  GetBackPassWordViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "GetBackPassWordViewController.h"
#import "LoginViewController.h"
@interface GetBackPassWordViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSDictionary *pramerDic;


@end

@implementation GetBackPassWordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"忘记密码";
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
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneText.textColor = UIColorFromHex(0x333333);
    [_phoneView addSubview:_phoneText];
    
    _phoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, _phoneText.bottom, _phoneView.width,1 )];
    _phoneLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [_phoneView addSubview:_phoneLine];
    //验证码
    _verificationView = [[UIView alloc]initWithFrame:CGRectMake(40, _phoneView.bottom + 40 , kScreenWidth - 2*40, 40)];
    [self.view addSubview:_verificationView];
    
    _verificationText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,_verificationView.width , self.verificationView.height-1)];
    _verificationText.placeholder = @"短信验证码";
    _verificationText.delegate = self;
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
    _againPassWordText.textColor = UIColorFromHex(0x333333);
    [_againPassWordView addSubview:_againPassWordText];
    
    _againPassWordLine = [[UIView alloc]initWithFrame:CGRectMake(0, _againPassWordText.bottom,_againPassWordView.width,1 )];
    _againPassWordLine.backgroundColor = RGB(0.95, 0.39, 0.21);
    [_againPassWordView addSubview:_againPassWordLine];
    
    
    
    //确认
    _sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _sureBtn.frame = CGRectMake(40, _againPassWordView.bottom + 90*WidthRate, kScreenWidth - 80, 60*WidthRate);
    [_sureBtn setTitle:@"确认" forState: UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _sureBtn.layer.cornerRadius = 30*WidthRate;
    [_sureBtn addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
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
        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        self.pramerDic = [NSDictionary dictionary];
        //        _pramerDic = @{@"Mobile":self.phoneText.text,@"TypeID":@"2",@"MemberID":@""};
        //        [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:nil RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        //            hud.hidden = YES;
        //            NSString *status = [result objectForKey:@"status"];
        //            if ([status isEqualToString:@"success"]) {
        //                [self againCrateBtn];
        //                [self controlTheTime];
        //
        //            }else{
        //                NSString *mess = [result objectForKey:@"message"];
        //                //                    HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:mess buttonTitles:@"确定", nil];
        //                //                    [alert showInView:self.view completion:nil];
        //
        //
        //                [self errorMessages:mess];
        //
        //            }
        //        }];
    }
}
-(void)SureClick{
    [self resign];
    if ([_phoneText.text isEqualToString:@""]) {
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"手机号不能为空" buttonTitles:@"确定", nil];
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
    else{
        
        LoginViewController * logVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:logVC animated:YES];
        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        self.pramerDic = [NSDictionary dictionary];
        ////        _pramerDic = @{@"Mobile":self.phoneText.text,@"Password":_secreatText.text,@"LoginSourceID":@"2",@"PushToken":[[NotificationConfigure sharedNotificationConfigure] getDeviceToken]?[[NotificationConfigure sharedNotificationConfigure] getDeviceToken ]:@""};
        //        [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:nil RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        //            hud.hidden = YES;
        //            [self resign];
        //            NSLog(@"loginResult==%@",result);
        //            NSString *status = [result objectForKey:@"status"];
        //            if ([status isEqualToString:@"success"]) {
        //
        //                NSString *passPortId = [[result objectForKey:@"data"]objectForKey:@"Mobile"];
        //                NSString *memberStatusID = [[result objectForKey:@"data"]objectForKey:@"MemberStatusID"];
        //                NSString *memberID = [[result objectForKey:@"data"]objectForKey:@"MemberID"];
        //                //给名字加密
        //                NSMutableDictionary *paramer = [NSMutableDictionary dictionaryWithDictionary:@{@"passPortId":passPortId,@"memberStatusID":memberStatusID,@"memberID":memberID}];
        //                EncryptionData *encryptionData = [[EncryptionData alloc] init];
        //                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramer options:NSJSONWritingPrettyPrinted error:nil];
        //                NSString *jsonString = [jsonData base64EncodedStringWithOptions:0];
        ////                NSString *passPortMemberStatusMemberIDStr = [encryptionData encodeString:jsonString key:messageStr];
        //
        //                NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
        ////                [defult setObject:passPortMemberStatusMemberIDStr forKey:@"passPortMemberStatusMemberIDStr"];
        //
        //                [defult synchronize];
        //                TabBarViewController * tbVC = [[TabBarViewController alloc]init];
        //                [self.navigationController pushViewController:tbVC animated:YES];
        //
        ////                if ([self.delegate respondsToSelector:@selector(loginSuccessActionInfo)]) {
        ////                    [self.delegate loginSuccessActionInfo];
        ////                }
        //
        //            }else{
        //                NSString *mess = [result objectForKey:@"message"];
        //                //                    HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:mess buttonTitles:@"确定", nil];
        //                //                    [alert showInView:self.view completion:nil];
        //                [self errorMessages:mess];
        //            }
        //        }];
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
