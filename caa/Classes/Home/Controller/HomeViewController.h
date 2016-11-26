//
//  HomeViewController.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"



@interface HomeViewController : BaseViewController
@property(nonatomic,strong)UIView * leadView;//引导图背景
@property(nonatomic,strong)UIImageView * leadImg;//引导图片
@property(nonatomic,strong)UIImageView * faceImg;//笑脸图片
@property(nonatomic,strong)UILabel * faceLab;//笑脸下文字
@property(nonatomic,strong)UIView * adView;//发布广告背景
@property(nonatomic,strong)UIImageView * relImg;//发布图片
@property(nonatomic,strong)UILabel * relAdLab;//发布广告
@property(nonatomic,strong)UIView * showView;//显示背景
@property(nonatomic,strong)UILabel * relLab;//正在发布
@property(nonatomic,strong)UILabel * relLabNum;//发布屏数
@property(nonatomic,strong)UILabel * playLab;//播放
@property(nonatomic,strong)UILabel * playLabNum;//播放次数
@property(nonatomic,strong)UILabel * receLab;//领取
@property(nonatomic,strong)UILabel * receLabNum;//领取人数
@property(nonatomic,strong)UILabel * useLab;//使用
@property(nonatomic,strong)UILabel * useLabNum;//使用人数
@property(nonatomic,strong)UIButton * detailBtn;//详情
@property(nonatomic,strong)UIButton * receBtn;
@property(nonatomic,strong)UIButton * useBtn;
@end
