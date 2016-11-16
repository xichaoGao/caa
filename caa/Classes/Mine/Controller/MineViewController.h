//
//  MineViewController.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController
@property(nonatomic,strong)UIView *headBgView;//头像背景
@property(nonatomic,strong)UIImageView * headImg;//头像图片
@property(nonatomic,strong)UILabel * useNameLab;//昵称
@property(nonatomic,strong)UIButton * mineReleaseBtn;//我的发布按钮
@property(nonatomic,strong)UIView * bgView;//下面的背景
@end
