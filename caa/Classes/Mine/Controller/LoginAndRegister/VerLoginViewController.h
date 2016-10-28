//
//  VerLoginViewController.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface VerLoginViewController : BaseViewController
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UIView *phoneLine;
@property(nonatomic,strong)UIView *verificationView;
@property(nonatomic,strong)UITextField *verificationText;
@property(nonatomic,strong)UIView *verificationLine;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *verificationBtn;
/**
 *  倒计时按钮
 */
#pragma mark - 重新发送验证码;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) NSInteger showTime;

- (void)controlTheTime;

@end
