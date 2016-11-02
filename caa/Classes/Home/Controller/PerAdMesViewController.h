//
//  PerAdMesViewController.h
//  caa
//
//  Created by xichao on 16/10/31.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface PerAdMesViewController : BaseViewController
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UILabel * defaultLab;
@property(nonatomic,strong)UIButton * addBtn;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UITextField *titleText;
@property(nonatomic,strong)UIView * titleLine;
@property(nonatomic,strong)UILabel * effectLab;
@property(nonatomic,strong)UIImageView * effectImg;
@property(nonatomic,strong)UILabel * effectNumLab;
@property(nonatomic,strong)UILabel * textLab;
@property(nonatomic,strong)UILabel * textDeLab;


@property(nonatomic,strong)UIButton * previewBtn;
@property(nonatomic,strong)UIButton * nextBtn;
@end
