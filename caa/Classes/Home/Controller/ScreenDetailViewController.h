//
//  ScreenDetailViewController.h
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface ScreenDetailViewController : BaseViewController
@property(nonatomic,strong)NSString * device_id;
@property(nonatomic,strong)UIImageView * screenImg;
@property(nonatomic,strong)UIImageView * faceImg;
@property(nonatomic,strong)UILabel * faceLab;
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * hotLab;
@property(nonatomic,strong)UIImageView * heartImg;
@property(nonatomic,strong)UILabel * listLab;
@property(nonatomic,strong)UITableView * listTableView;
@end
