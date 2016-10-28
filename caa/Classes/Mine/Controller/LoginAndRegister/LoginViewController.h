//
//  LoginViewController.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UIView *phoneLine;
@property(nonatomic,strong)UIView *passWordView;
@property(nonatomic,strong)UITextField *passWordText;
@property(nonatomic,strong)UIView *passWordLine;
@property(nonatomic,strong)UIButton *forgetPassWordBtn;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *verificationLoginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@end
