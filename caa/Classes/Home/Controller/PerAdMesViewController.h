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

@property(nonatomic,strong)UILabel * actionTimeLab;
@property(nonatomic,strong)UILabel * beginTimeLab;
@property(nonatomic,strong)UILabel * andLab;
@property(nonatomic,strong)UILabel * endTimeLab;

@property(nonatomic,strong)UIView * contentView;
@property(nonatomic,strong)UIView *contentBgView;
@property(nonatomic,strong)UILabel *cotentLab;
@property(nonatomic,strong)UILabel * contentTextDeLab;
@property(nonatomic,strong)UILabel * defContentTextDeLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UITextField * addressTextField;

@property(nonatomic,strong)UILabel * typeLab;

@property(nonatomic,strong)UILabel * redBagCount;
@property(nonatomic,strong)UITextField *redBagTextField;
@property(nonatomic,strong)UILabel * redBagContent;
@property(nonatomic,strong)UITextField *redBagContentTextField;
@property(nonatomic,strong)UILabel * dateLab;
@property(nonatomic,strong)UITextField *dateTextField;


@property(nonatomic,strong)UILabel * useDirLab;
@property(nonatomic,strong)UIView *useDirBgView;
@property(nonatomic,strong)UILabel *useDirCotentLab;
@property(nonatomic,strong)UILabel * useDirContentTextDeLab;

@property(nonatomic,strong)UILabel * useCondLab;

@property(nonatomic,strong)UILabel * limitLab;







@property(nonatomic,strong)UIButton * previewBtn;
@property(nonatomic,strong)UIButton * nextBtn;


@end
