//
//  ReleaseDetailTableViewCell.h
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * screenImg;//屏图片
@property(nonatomic,strong)UILabel * titleLab;//屏标题
@property(nonatomic,strong)UILabel * playLab;//播放
@property(nonatomic,strong)UILabel * playNumLab;//次数
@property(nonatomic,strong)UILabel * receLab;//领取
@property(nonatomic,strong)UILabel * receNumLab;//次数
@property(nonatomic,strong)UILabel * toShopLab;//到店
@property(nonatomic,strong)UILabel * toShopNumLab;//人数
@property(nonatomic,strong)UIButton * detailBtn;//详情按钮
@property(nonatomic,strong)UIView * lineView;

@end
