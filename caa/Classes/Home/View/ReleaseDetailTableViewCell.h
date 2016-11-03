//
//  ReleaseDetailTableViewCell.h
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * screenImg;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * playLab;
@property(nonatomic,strong)UILabel * playNumLab;
@property(nonatomic,strong)UILabel * receLab;
@property(nonatomic,strong)UILabel * receNumLab;
@property(nonatomic,strong)UILabel * toShopLab;
@property(nonatomic,strong)UILabel * toShopNumLab;
@property(nonatomic,strong)UIButton * detailBtn;
@property(nonatomic,strong)UIView * lineView;

@end
