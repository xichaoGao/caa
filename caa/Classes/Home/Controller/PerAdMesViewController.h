//
//  PerAdMesViewController.h
//  caa
//
//  Created by xichao on 16/10/31.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface PerAdMesViewController : BaseViewController
@property(nonatomic,strong)UIView * bgView; //背景
@property(nonatomic,strong)UIImageView * photoImg;//广告图片
@property(nonatomic,strong)UILabel * defaultLab;//默认字样
@property(nonatomic,strong)UIButton * addBtn;//添加图片按钮
@property(nonatomic,strong)UILabel * titleLab;//标题
@property(nonatomic,strong)UITextField *titleText;//标题输入框
@property(nonatomic,strong)UIView * titleLine;//下划线
@property(nonatomic,strong)UILabel * effectLab;//效果
@property(nonatomic,strong)UIImageView * effectImg;//效果图片
@property(nonatomic,strong)UILabel * effectNumLab;//效果标题
@property(nonatomic,strong)UILabel * tipLab;//推荐
@property(nonatomic,strong)UITextField * tipTextField;//输入活动

@property(nonatomic,strong)UIView * textBgView;//背景
@property(nonatomic,strong)UILabel * textDeLab;//显示推荐的文字
@property(nonatomic,strong)UILabel * defTextDeLab;//默认填写

@property(nonatomic,strong)UILabel * actionTimeLab;//活动时间
@property(nonatomic,strong)UILabel * beginTimeLab;//开始时间
@property(nonatomic,strong)UILabel * andLab;//连接
@property(nonatomic,strong)UILabel * endTimeLab;//结束时间

@property(nonatomic,strong)UIView * contentView;//活动背景
@property(nonatomic,strong)UIView *contentBgView;//活动内容背景
@property(nonatomic,strong)UILabel *contentLab;//活动
@property(nonatomic,strong)UITextField * contentTextField;//输入活动

@property(nonatomic,strong)UILabel * contentTextDeLab;//显示活动内容
@property(nonatomic,strong)UILabel * defContentTextDeLab;//默认活动内容填写

@property(nonatomic,strong)UILabel *shopLab;//商品
@property(nonatomic,strong)UIButton * shopBtn;//商品图片

@property(nonatomic,strong)UILabel *shopNameLab;//商铺名称
@property(nonatomic,strong)UITextField * shopNameTextField;//输入商铺名称
@property(nonatomic,strong)UILabel *addressLab;//地址
@property(nonatomic,strong)UITextField * addressTextField;//输入地址

@property(nonatomic,strong)UILabel * typeLab;  //营销类型

@property(nonatomic,strong)UILabel * redBagCount;//红包个数
@property(nonatomic,strong)UITextField *redBagTextField;//输入红包个数
@property(nonatomic,strong)UILabel * redBagContent;//红包内容
@property(nonatomic,strong)UITextField *redBagContentTextField;//输入红包内容
@property(nonatomic,strong)UILabel * dateLab;//有限期
@property(nonatomic,strong)UITextField *dateTextField;//输入有效期


@property(nonatomic,strong)UILabel * useDirLab;//使用说明
@property(nonatomic,strong)UIView *useDirBgView;//使用说明背景
@property(nonatomic,strong)UILabel *useDirCotentLab;//使用说明显示
@property(nonatomic,strong)UILabel * useDirContentTextDeLab;//默认使用说明

@property(nonatomic,strong)UILabel * useCondLab;//使用条件

@property(nonatomic,strong)UILabel * limitLab;//领取限制







@property(nonatomic,strong)UIButton * previewBtn;
@property(nonatomic,strong)UIButton * nextBtn;


@end
