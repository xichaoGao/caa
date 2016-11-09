//
//  PreView.h
//  caa
//
//  Created by xichao on 16/11/9.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreView : UIView
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UIImageView *adImg;
@property(nonatomic,strong)UIImageView *codeImg;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *tipLab;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,copy)NSString *contenStr;
@property(nonatomic,copy)NSString *addressStr;
@property(nonatomic,copy)NSString *tipStr;
@property(nonatomic,copy)void (^block)(void);

@end
