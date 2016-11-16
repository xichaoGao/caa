//
//  PreView.h
//  caa
//
//  Created by xichao on 16/11/9.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreView : UIView
@property(nonatomic,strong)UIView * bgView;//背景
@property(nonatomic,strong)UIImageView *adImg;//广告图片
@property(nonatomic,strong)UIImageView *codeImg;//二维码图片
@property(nonatomic,strong)UILabel *contentLabel;//活动内容
@property(nonatomic,strong)UILabel *addressLabel;//地址
@property(nonatomic,strong)UILabel *tipLab;//推荐文字
@property(nonatomic,strong)UIButton *closeBtn;//关闭
@property(nonatomic,copy)NSString *contenStr;
@property(nonatomic,copy)NSString *addressStr;
@property(nonatomic,copy)NSString *tipStr;
@property(nonatomic,copy)void (^block)(void);//回调

@end
