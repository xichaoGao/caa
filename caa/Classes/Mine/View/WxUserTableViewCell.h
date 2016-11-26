//
//  WxUserTableViewCell.h
//  caa
//
//  Created by xichao on 16/11/26.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxUserTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * WxImg;//屏图片
@property(nonatomic,strong)UILabel * nickNameLab;//屏标题
@property(nonatomic,strong)UILabel * receLab;//领取时间
@property(nonatomic,strong)UILabel * receTimeLab;//
@property(nonatomic,strong)UILabel * useLab;//使用时间
@property(nonatomic,strong)UILabel * useTimeLab;//
@property(nonatomic,strong)UIView * lineView;
@end
