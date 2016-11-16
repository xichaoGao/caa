//
//  ScreenDetailViewController.h
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface ScreenDetailViewController : BaseViewController
@property(nonatomic,strong)NSString * device_id;//设备id
@property(nonatomic,strong)UIImageView * screenImg;//屏图片
@property(nonatomic,strong)UIImageView * faceImg;//笑脸
@property(nonatomic,strong)UILabel * faceLab;//笑脸文字
@property(nonatomic,strong)UIView * bgView;//背景
@property(nonatomic,strong)UILabel * titleLab;//屏标题
@property(nonatomic,strong)UILabel * hotLab;//热评
@property(nonatomic,strong)UIImageView * heartImg;//心图片
@property(nonatomic,strong)UILabel * listLab;//播放广告
@property(nonatomic,strong)UITableView * listTableView;//广告标题列表
@end
