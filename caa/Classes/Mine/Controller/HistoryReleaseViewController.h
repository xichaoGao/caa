//
//  HistoryReleaseViewController.h
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"
#import "HistoryModel.h"
@interface HistoryReleaseViewController : BaseViewController
@property(nonatomic,strong)UIView * showView;
@property(nonatomic,strong)UILabel * relLab;
@property(nonatomic,strong)UILabel * relLabNum;
@property(nonatomic,strong)UILabel * playLab;
@property(nonatomic,strong)UILabel * playLabNum;
@property(nonatomic,strong)UILabel * receLab;
@property(nonatomic,strong)UILabel * receLabNum;
@property(nonatomic,strong)UILabel * useLab;
@property(nonatomic,strong)UILabel * useLabNum;
@property(nonatomic,strong)UIButton * receBtn;
@property(nonatomic,strong)UIButton * useBtn;
@property(nonatomic,strong)UIButton * detailBtn;
@property(nonatomic,strong)HistoryModel * Model;
@end
