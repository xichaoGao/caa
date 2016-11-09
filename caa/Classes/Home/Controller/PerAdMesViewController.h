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
@property(nonatomic,strong)UIImageView * photoImg;
@property(nonatomic,strong)UILabel * defaultLab;
@property(nonatomic,strong)UIButton * addBtn;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UITextField *titleText;
@property(nonatomic,strong)UIView * titleLine;
@property(nonatomic,strong)UILabel * effectLab;
@property(nonatomic,strong)UIImageView * effectImg;
@property(nonatomic,strong)UILabel * effectNumLab;
@property(nonatomic,strong)UILabel * textLab;
@property(nonatomic,strong)UIView * textBgView;
@property(nonatomic,strong)UILabel * textDeLab;
@property(nonatomic,strong)UILabel * defTextDeLab;

@property(nonatomic,strong)UIView * contentView;
@property(nonatomic,strong)UIView *contentBgView;
@property(nonatomic,strong)UILabel *cotentLab;
@property(nonatomic,strong)UILabel * contentTextDeLab;
@property(nonatomic,strong)UILabel * defContentTextDeLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UITextField * addressTextField;

@property(nonatomic,strong)UIButton * previewBtn;
@property(nonatomic,strong)UIButton * nextBtn;


@end
