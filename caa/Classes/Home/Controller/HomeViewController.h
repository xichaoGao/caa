//
//  HomeViewController.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController
@property(nonatomic,strong)UIView * leadView;
@property(nonatomic,strong)UIImageView * leadImg;
@property(nonatomic,strong)UIImageView * faceImg;
@property(nonatomic,strong)UILabel * faceLab;
@property(nonatomic,strong)UIView * adView;
@property(nonatomic,strong)UIImageView * relImg;
@property(nonatomic,strong)UILabel * relAdLab;
@property(nonatomic,strong)UIView * showView;
@property(nonatomic,strong)UILabel * relLab;
@property(nonatomic,strong)UILabel * relLabNum;
@property(nonatomic,strong)UILabel * playLab;
@property(nonatomic,strong)UILabel * playLabNum;
@property(nonatomic,strong)UILabel * receLab;
@property(nonatomic,strong)UILabel * receLabNum;
@property(nonatomic,strong)UILabel * useLab;
@property(nonatomic,strong)UILabel * useLabNum;
@property(nonatomic,strong)UIButton * detailBtn;
@end
