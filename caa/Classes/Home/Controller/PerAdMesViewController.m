//
//  PerAdMesViewController.m
//  caa
//
//  Created by xichao on 16/10/31.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "PerAdMesViewController.h"
#import "BusinessChooseViewController.h"
#import "JKImagePickerController.h"
#import "XWScanImage.h"
#import "TextView.h"
#import "PreView.h"
#import "PreView1.h"
#import "LDCalendarView.h"
#import "NSDate+extend.h"
@interface PerAdMesViewController ()<UITextFieldDelegate,JKImagePickerControllerDelegate>
{
    UIView * _btnBgView;
    UIView * _vouchersView;
    UIView * _redBgView;
    UILabel * _setLab;
    UIView * _limitView;
    NSArray * vouchersArr;
    NSArray * useTypeArr;
    NSArray * limitTypeArr;
}
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期
@property (nonatomic, strong)LDCalendarView    *calendarView;//日历控件
@property (strong,nonatomic)NSMutableArray *assetsArray;
@property(nonatomic,strong)NSMutableArray * imgArray;
@property(nonatomic,strong)NSMutableArray  *photoArray;
@property(nonatomic,assign)int selectTag;
@property(nonatomic,strong)UIScrollView * bgScrollView;
@end

@implementation PerAdMesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [_previewBtn setBackgroundColor:[UIColor whiteColor]];
    [_nextBtn setBackgroundColor:[UIColor whiteColor]];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:nil forKey:@"photoArray"];
    [user setObject:@"" forKey:@"text"];
    [user setObject:@"" forKey:@"contentText"];
    [user setObject:@"" forKey:@"useDirText"];
    _photoArray = [NSMutableArray arrayWithCapacity:1];
    _assetsArray = [NSMutableArray array];
    _imgArray = [NSMutableArray array];
    vouchersArr = [NSArray arrayWithObjects:@"红包代金券",@"实物券", nil];
    useTypeArr = [NSArray arrayWithObjects:@"立即使用",@"隔日使用", nil];
    limitTypeArr = [NSArray arrayWithObjects:@"活动内限领一次",@"使用后再次领取", nil];
    self.navigationItem.title = @"完善广告信息";
    [self createUI];
    // Do any additional setup after loading the view.
}
//创建界面
-(void)createUI{
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgScrollView.userInteractionEnabled = YES;
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, 2*kScreenHeight);
    _bgScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgScrollView];
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12, 10*WidthRate, kScreenWidth-24, 160*WidthRate)];
    _bgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    [_bgScrollView addSubview:_bgView];
    _defaultLab = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 145*WidthRate)/2, (_bgView.height - 60*WidthRate)/2, 150*WidthRate, 60*WidthRate)];
    _defaultLab.text = @"添加商品照片";
    _defaultLab.textAlignment = NSTextAlignmentCenter;
    _defaultLab.textColor  = RGB(0.84, 0.84, 0.84);
    _defaultLab.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:_defaultLab];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _addBtn.frame = CGRectMake(_bgView.right-55, _bgView.bottom - 55, 35, 35);
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"home_addphotos"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addPhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_addBtn];
    
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _bgView.bottom + 10*WidthRate, 50, 30)];
    _textLab.text = @"标题:";
    _textLab.textColor = RGB(0.41, 0.41, 0.41);
    _textLab.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:_textLab];
    
    _titleText = [[UITextField alloc]initWithFrame:CGRectMake(_textLab.right, _bgView.bottom + 10*WidthRate, kScreenWidth-_textLab.right-12, 30)];
    _titleText.placeholder = @"请输入您的标题";
    _titleText.delegate = self;
    _titleText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _titleText.textColor = RGB(0.41, 0.41, 0.41);
    _titleText.font = [UIFont systemFontOfSize:13];
    [_bgScrollView addSubview:_titleText];
    
    _titleLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleText.height-5, _titleText.width, 1)];
    _titleLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_titleText addSubview:_titleLine];
    
    _effectLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _textLab.bottom + 10*WidthRate, 80, 30)];
    _effectLab.font = [UIFont systemFontOfSize:15];
    _effectLab.textColor = RGB(0.41, 0.41, 0.41);
    _effectLab.text = @"动画效果:";
    [_bgScrollView addSubview:_effectLab];
    
    for (int i=0 ; i<1 ; i++){
        _effectImg = [[UIImageView alloc]initWithFrame:CGRectMake(_effectLab.right +(60*WidthRate +5)*i , _effectLab.origin.y+10, 50*WidthRate, 50*WidthRate)];
        _effectImg.userInteractionEnabled = YES;
        _effectImg.tag = i+1000;
        [_effectImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_addmotion"]];
        _effectNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_effectImg.left, _effectImg.bottom + 8, _effectImg.width, 20)];
        _effectNumLab.userInteractionEnabled = YES;
        _effectNumLab.textColor = RGB(0.41, 0.41, 0.41);
        _effectNumLab.tag = 10000+i;
        _effectNumLab.textAlignment = NSTextAlignmentCenter;
        _effectNumLab.text = [@"" stringByAppendingFormat:@"%@%d",@"效果",i+1];
        _effectNumLab.font  = [UIFont systemFontOfSize:10];
        [_bgScrollView addSubview:_effectImg];
        [_bgScrollView addSubview: _effectNumLab];
        UIButton *selectBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(0, 0, _effectNumLab.width, _effectNumLab.height);
        [selectBtn setImage:nil forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"home_all_tick"] forState:UIControlStateSelected];
        selectBtn.tag = 20000+i;
        [selectBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [_effectNumLab addSubview:selectBtn];
        
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
        [_effectImg addGestureRecognizer:tapGes];
        
    }
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _effectNumLab.bottom + 10*WidthRate, 80, 30)];
    _textLab.font = [UIFont systemFontOfSize:15];
    _textLab.textColor = RGB(0.41, 0.41, 0.41);
    _textLab.text = @"推荐文字:";
    [_bgScrollView addSubview:_textLab];
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    
    _textBgView = [[UIView alloc]initWithFrame:CGRectMake(_textLab.right, _textLab.origin.y, kScreenWidth - _textLab.right-12, 30)];
    _textBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _textBgView.layer.borderWidth = 1;
    _textBgView.userInteractionEnabled = YES;
    [_bgScrollView addSubview:_textBgView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTextTap)];
    [_textBgView addGestureRecognizer:tapGes];
    _textDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, _textBgView.width-10, _textBgView.height)];
    _textDeLab.font = [UIFont systemFontOfSize:12];
    _textDeLab.numberOfLines = 4;
    _textDeLab.text = [use objectForKey:@"text"]?[use objectForKey:@"text"]:@"";
    _textDeLab.textColor = RGB(0.41, 0.41, 0.41);
    [_textBgView addSubview:_textDeLab];
    
    
    _defTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, _textBgView.width-10, _textBgView.height)];
    _defTextDeLab.numberOfLines = 0;
    _defTextDeLab.text = @"请输入推荐文字描述";
    _defTextDeLab.font = [UIFont systemFontOfSize:14];
    _defTextDeLab.textColor = RGB(0.78, 0.78, 0.80);
    [_textBgView addSubview:_defTextDeLab];
    
    _actionTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _textBgView.bottom+10*WidthRate, 80, 30)];
    _actionTimeLab.font = [UIFont systemFontOfSize:15];
    _actionTimeLab.textColor = RGB(0.41, 0.41, 0.41);
    _actionTimeLab.text = @"活动时间:";
    [_bgScrollView addSubview:_actionTimeLab];
    
    _beginTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_actionTimeLab.right, _textBgView.bottom + 10*WidthRate, (kScreenWidth - _actionTimeLab.right - 42)/2, 30)];
    _beginTimeLab.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _beginTimeLab.layer.borderWidth = 1;
    _beginTimeLab.userInteractionEnabled = YES;
    _beginTimeLab.tag = 301;
    _beginTimeLab.textColor = RGB(0.41, 0.41, 0.41);
    _beginTimeLab.textAlignment = NSTextAlignmentCenter;
    [_bgScrollView addSubview:_beginTimeLab];
    UITapGestureRecognizer *tapGesBeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTimeTap:)];
    [_beginTimeLab addGestureRecognizer:tapGesBeg];
    _andLab = [[UILabel alloc]initWithFrame:CGRectMake(_beginTimeLab.right, _textBgView.bottom + 10*WidthRate, 30, 30)];
    _andLab.text = @"至";
    _andLab.textAlignment = NSTextAlignmentCenter;
    _andLab.font = [UIFont systemFontOfSize:15];
    _andLab.textColor = RGB(0.41, 0.41, 0.41);
    [_bgScrollView addSubview:_andLab];
    
    _endTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_andLab.right, _textBgView.bottom + 10*WidthRate, (kScreenWidth - _actionTimeLab.right - 42)/2, 30)];
    _endTimeLab.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _endTimeLab.layer.borderWidth = 1;
    _endTimeLab.tag = 302;
    _endTimeLab.userInteractionEnabled = YES;
    _endTimeLab.textAlignment = NSTextAlignmentCenter;
    [_bgScrollView addSubview:_endTimeLab];
    UITapGestureRecognizer *tapGesEnd = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTimeTap:)];
    [_endTimeLab addGestureRecognizer:tapGesEnd];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, _actionTimeLab.bottom+5, kScreenWidth, 100*WidthRate)];
    [_bgScrollView addSubview:_contentView];
    _cotentLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 5*WidthRate, 80, 30)];
    _cotentLab.font = [UIFont systemFontOfSize:15];
    _cotentLab.textColor = RGB(0.41, 0.41, 0.41);
    _cotentLab.text = @"活动内容:";
    [_contentView addSubview:_cotentLab];
    
    _contentBgView = [[UIView alloc]initWithFrame:CGRectMake(_cotentLab.right, _cotentLab.origin.y, kScreenWidth - _cotentLab.right-12, 60*WidthRate)];
    _contentBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _contentBgView.layer.borderWidth = 1;
    _contentBgView.userInteractionEnabled = YES;
    [_contentView addSubview:_contentBgView];
    
    
    UITapGestureRecognizer *tapGess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addContentTextTap)];
    [_contentBgView addGestureRecognizer:tapGess];
    
    
    _contentTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _contentBgView.width-10, _contentBgView.height -5)];
    _contentTextDeLab.font = [UIFont systemFontOfSize:12];
    _contentTextDeLab.numberOfLines = 4;
    _contentTextDeLab.text = [use objectForKey:@"contentText"]?[use objectForKey:@"contentText"]:@"";
    _contentTextDeLab.textColor = RGB(0.41, 0.41, 0.41);
    [_contentBgView addSubview:_contentTextDeLab];
    
    
    _defContentTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _contentBgView.width-10, _contentBgView.height -5)];
    _defContentTextDeLab.numberOfLines = 0;
    _defContentTextDeLab.text = @"请输入活动内容";
    _defContentTextDeLab.font = [UIFont systemFontOfSize:14];
    _defContentTextDeLab.textColor = RGB(0.78, 0.78, 0.80);
    [_contentBgView addSubview:_defContentTextDeLab];
    
    
    _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _contentBgView.bottom + 10*WidthRate, 80, 30)];
    _addressLab.text = @"活动地址:";
    _addressLab.textColor = RGB(0.41, 0.41, 0.41);
    _addressLab.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:_addressLab];
    
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(_addressLab.right , _contentBgView.bottom + 10*WidthRate, kScreenWidth-_addressLab.right-12, 30)];
    _addressTextField.placeholder = @"请输入活动地址";
    _addressTextField.delegate = self;
    _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressTextField.textColor = RGB(0.41, 0.41, 0.41);
    _addressTextField.font = [UIFont systemFontOfSize:13];
    [_contentView addSubview:_addressTextField];
    
    UIView *addressLine = [[UIView alloc]initWithFrame:CGRectMake(0, _addressTextField.height-1, _addressTextField.width, 1)];
    addressLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_addressTextField addSubview:addressLine];
    
    UIView *Line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _contentView.bottom + 20*WidthRate, kScreenWidth, 1)];
    Line1.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_bgScrollView addSubview:Line1];
    UIView *Line2 = [[UIView alloc]initWithFrame:CGRectMake(0, Line1.bottom + 5*WidthRate, kScreenWidth, 1)];
    Line2.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_bgScrollView addSubview:Line2];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, Line2.bottom + 10*WidthRate, 100, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"营销活动";
    title.textColor = RGB(0.41, 0.41, 0.41);
    title.font = [UIFont systemFontOfSize:20];
    [_bgScrollView addSubview:title];
    
    _typeLab = [[UILabel alloc]initWithFrame:CGRectMake(12, title.bottom + 25*WidthRate, 80, 30)];
    _typeLab.text = @"营销类型:";
    _typeLab.textColor = RGB(0.41, 0.41, 0.41);
    _typeLab.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:_typeLab];
    
   _vouchersView  = [self createWithX:_typeLab.right Y:title.bottom+25*WidthRate Button:vouchersArr tag:100000];
    [_bgScrollView addSubview:_vouchersView];
    
    
    _redBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _typeLab.bottom + 10*WidthRate, kScreenWidth, 110)];
    [_bgScrollView addSubview:_redBgView];
    
    _redBagCount = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 80, 30)];
    _redBagCount.text = @"红包个数:";
    _redBagCount.textColor = RGB(0.41, 0.41, 0.41);
    _redBagCount.font = [UIFont systemFontOfSize:15];
    [_redBgView addSubview:_redBagCount];
    
    _redBagTextField = [[UITextField alloc]initWithFrame:CGRectMake(_redBagCount.right, _redBagCount.origin.y, kScreenWidth-_redBagCount.right-12, 30)];
    _redBagTextField.delegate = self;
    _redBagTextField.layer.borderWidth = 1;
    _redBagTextField.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _redBagTextField.placeholder = @"请输入红包个数";
    _redBagTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _redBagTextField.keyboardType = UIKeyboardTypeNumberPad;
    _redBagTextField.textColor = RGB(0.41, 0.41, 0.41);
    [_redBgView addSubview:_redBagTextField];
    
    _redBagContent = [[UILabel alloc]initWithFrame:CGRectMake(12, _redBagCount.bottom+10*WidthRate, 80, 30)];
    _redBagContent.text = @"红包内容:";
    _redBagContent.textColor = RGB(0.41, 0.41, 0.41);
    _redBagContent.font = [UIFont systemFontOfSize:15];
    [_redBgView addSubview:_redBagContent];
    
    _redBagContentTextField = [[UITextField alloc]initWithFrame:CGRectMake(_redBagContent.right, _redBagCount.bottom+ 10*WidthRate, kScreenWidth-_redBagContent.right-12, 30)];
    _redBagContentTextField.layer.borderWidth = 1;
    _redBagContentTextField.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _redBagContentTextField.delegate = self;
    _redBagContentTextField.placeholder = @"请输入红包内容";
    _redBagContentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _redBagTextField.textColor = RGB(0.41, 0.41, 0.41);
    [_redBgView addSubview:_redBagContentTextField];
    
    
    _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _redBagContent.bottom+10*WidthRate, 80, 30)];
    _dateLab.text = @"有效期(日):";
    _dateLab.textColor = RGB(0.41, 0.41, 0.41);
    _dateLab.font = [UIFont systemFontOfSize:15];
    [_redBgView addSubview:_dateLab];
    
    _dateTextField = [[UITextField alloc]initWithFrame:CGRectMake(_dateLab.right, _redBagContent.bottom+ 10*WidthRate, kScreenWidth-_redBagContent.right-12, 30)];
    _dateTextField.layer.borderWidth = 1;
    _dateTextField.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _dateTextField.delegate = self;
    _dateTextField.placeholder = @"请输入有效期限";
    _dateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _redBagTextField.keyboardType = UIKeyboardTypeNumberPad;
    _dateTextField.textColor = RGB(0.41, 0.41, 0.41);
    [_redBgView addSubview:_dateTextField];
    
    _setLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _redBgView.bottom+30*WidthRate, 120, 30)];
    _setLab.text = @"使用条件设置:";
    _setLab.textColor = RGB(0.41, 0.41, 0.41);
    _setLab.font = [UIFont systemFontOfSize:17];
    [_bgScrollView addSubview:_setLab];

    
    _useDirLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _setLab.bottom+35*WidthRate, 80, 30)];
    _useDirLab.font = [UIFont systemFontOfSize:15];
    _useDirLab.textColor = RGB(0.41, 0.41, 0.41);
    _useDirLab.text = @"使用说明:";
    [_bgScrollView addSubview:_useDirLab];
    
    _useDirBgView = [[UIView alloc]initWithFrame:CGRectMake(_useDirLab.right, _setLab.bottom+35*WidthRate, kScreenWidth - _useDirLab.right-12, 40*WidthRate)];
    _useDirBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _useDirBgView.layer.borderWidth = 1;
    _useDirBgView.userInteractionEnabled = YES;
    [_bgScrollView addSubview:_useDirBgView];
    
    
    UITapGestureRecognizer *tapGe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addUseContentTextTap)];
    [_useDirBgView addGestureRecognizer:tapGe];
    
    
    _useDirCotentLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, _useDirBgView.width-5, 30 )];
    _useDirCotentLab.font = [UIFont systemFontOfSize:12];
    _useDirCotentLab.numberOfLines = 4;
    _useDirCotentLab.text = [use objectForKey:@"useDirText"]?[use objectForKey:@"useDirText"]:@"";
    _useDirCotentLab.textColor = RGB(0.41, 0.41, 0.41);
    [_useDirBgView addSubview:_useDirCotentLab];
    
    
    _useDirContentTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, _useDirBgView.width, 30 )];
    _useDirContentTextDeLab.numberOfLines = 0;
    _useDirContentTextDeLab.text = @"这里填写简短的优惠券使用说明";
    _useDirContentTextDeLab.font = [UIFont systemFontOfSize:14];
    _useDirContentTextDeLab.textColor = RGB(0.78, 0.78, 0.80);
    [_useDirBgView addSubview:_useDirContentTextDeLab];
    
    

    _useCondLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _useDirBgView.bottom + 10*WidthRate, 80, 30)];
    _useCondLab.text = @"使用条件:";
    _useCondLab.textColor = RGB(0.41, 0.41, 0.41);
    _useCondLab.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:_useCondLab];
    UIView * useCondView = [self createWithX:_useCondLab.right Y:_useDirBgView.bottom + 10*WidthRate Button:useTypeArr tag:200000];
    [_bgScrollView addSubview:useCondView];


    _limitLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _useCondLab.bottom +10*WidthRate, 80, 30)];
    _limitLab.text = @"领取限制:";
    _limitLab.textColor = RGB(0.41, 0.41, 0.41);
    _limitLab.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:_limitLab];
    _limitView = [self createWithX:_limitLab.right Y:_limitLab.origin.y Button:limitTypeArr tag:300000];
    [_bgScrollView addSubview:_limitView];

    
    
    
    
    
    
    
    
    
    
    _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewBtn.frame = CGRectMake(20,2*kScreenHeight-120*WidthRate , 120*WidthRate, 30*WidthRate);
    _previewBtn.layer.masksToBounds = YES;
    _previewBtn.layer.cornerRadius = 15*WidthRate;
    _previewBtn.layer.borderWidth = 1;
    _previewBtn.tag = 100;
    _previewBtn.enabled = NO;
    _previewBtn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    [_previewBtn setBackgroundColor:[UIColor whiteColor]];
    [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    _previewBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45 ) forState:UIControlStateNormal];
    [_previewBtn setTitleColor:RGB(0.98, 0.88, 0.85) forState:UIControlStateSelected];
    [_bgScrollView addSubview:_previewBtn];
    [_previewBtn addTarget:self action:@selector(previewClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(kScreenWidth-120*WidthRate-20,2*kScreenHeight-120*WidthRate , 120*WidthRate, 30*WidthRate);
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 15*WidthRate;
    _nextBtn.layer.borderWidth = 1;
    _nextBtn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    [_nextBtn setBackgroundColor:[UIColor whiteColor]];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_nextBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
    [_nextBtn setTitleColor:RGB(0.98, 0.88, 0.85) forState:UIControlStateSelected];
    [_bgScrollView addSubview:_nextBtn];
    [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([_textDeLab.text isEqualToString:@""]){
        _defTextDeLab.hidden = NO;
    }else
        _defTextDeLab.hidden = YES;
    if ([_contentTextDeLab.text isEqualToString:@""]){
        _defContentTextDeLab.hidden = NO;
    }else
        _defContentTextDeLab.hidden = YES;
}
-(UIView *)createWithX:(float) x Y:(float)y Button:(NSArray *)btnArr tag:(NSInteger)tag{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, kScreenWidth - x-12, 30+btnArr.count * 30)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor clearColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, bgView.width, 30);
    [btn setImage:[UIImage imageNamed:@"home_public_more"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"home_public_more"] forState:UIControlStateSelected];
    [btn setTitle:btnArr[0] forState:UIControlStateNormal];
    [btn setTitle:btnArr[0] forState:UIControlStateSelected];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    [btn setTitleColor:RGB(0.41, 0.41, 0.41) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(btn.right+30));
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.tag = tag*10;
    [bgView addSubview:btn];
    [btn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *  btnBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, bgView.width, 30*btnArr.count)];
    btnBgView.hidden = YES;
    btnBgView.tag = tag/10000;
    btnBgView.userInteractionEnabled = YES;
    btnBgView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:btnBgView];
    
    for (int i = 0; i< btnArr.count ; i++){
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*31+1, bgView.width, 30);
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitle:btnArr[i] forState:UIControlStateSelected];
        btn.layer.borderColor =  RGB(0.84, 0.84, 0.84).CGColor;
        btn.layer.borderWidth = 1;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(0.41, 0.41, 0.41) forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i +tag;
        [btn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnBgView addSubview:btn];
        if (i == 0){
            btn.selected  = !btn.selected;
        }
       
    }
    
    return  bgView;
}
//下拉按钮
-(void)allBtnClick:(UIButton *)sender{
    switch (sender.tag/100000) {
        case 10:
        {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:sender.tag];
            _btnBgView = [self.view viewWithTag:10];
            btn.selected = !btn.selected;
            if (btn.selected == YES){
                [UIView animateWithDuration:0.05 animations:^{
                    CGPoint  p1 = _redBgView.center;
                    p1.y+=30*vouchersArr.count;
                    _redBgView.center = p1;
                    CGPoint p2 = _setLab.center;
                    p2.y +=20*vouchersArr.count;
                    _setLab.center = p2;
                }];
                _btnBgView.hidden = NO;
            }
            else{
                [UIView animateWithDuration:0.05 animations:^{
                    CGPoint  p1 = _redBgView.center;
                    p1.y-=30*vouchersArr.count;
                    _redBgView.center = p1;
                    CGPoint p2 = _setLab.center;
                    p2.y -=20*vouchersArr.count;
                    _setLab.center = p2;
                }];
                _btnBgView.hidden = YES;
            }
        }
            break;
        case 1:
        {
            for (int i= 0; i< vouchersArr.count ;i++){
            
                UIButton *btn = (UIButton *)[self.view viewWithTag:100000+i];
               _btnBgView = [self.view viewWithTag:10];
                if (btn.tag == sender.tag){
                     btn.selected = !btn.selected;
                    if (btn.selected == YES){
                        [UIView animateWithDuration:0.05 animations:^{
                            CGPoint  p1 = _redBgView.center;
                            p1.y-=30*vouchersArr.count;
                            _redBgView.center = p1;
                            CGPoint p2 = _setLab.center;
                            p2.y -=20*vouchersArr.count;
                            _setLab.center = p2;
                        }];
                        btn.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                        _btnBgView.hidden = YES;
                        UIButton *btn = (UIButton *)[self.view viewWithTag:1000000];
                        btn.selected = !btn.selected;
                        [btn setTitle:vouchersArr[i] forState:UIControlStateNormal];
                        [btn setTitle:vouchersArr[i] forState:UIControlStateSelected];

                    }
                    else{
                        
                        btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
                        UIButton *btn = (UIButton *)[self.view viewWithTag:1000000];
                        btn.selected = !btn.selected;
                        [btn setTitle:@"" forState:UIControlStateNormal];
                        [btn setTitle:@"" forState:UIControlStateSelected];

                        _btnBgView.hidden = NO;
                    }
                }
                else{
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;

                    }
                    else{

                    }
                }
            }
        }
            break;
            
        case 20:
        {
            UIButton *btn = (UIButton *)[self.view viewWithTag:sender.tag];
            btn.selected = !btn.selected;
            _btnBgView = [self.view viewWithTag:20];
            if (btn.selected == YES){
                [UIView animateWithDuration:0.05 animations:^{
                    CGPoint  p1 = _limitLab.center;
                    p1.y+=30*useTypeArr.count;
                    _limitLab.center = p1;
                    CGPoint p2 = _limitView.center;
                    p2.y +=30*useTypeArr.count;
                    _limitView.center = p2;
                }];
                _btnBgView.hidden = NO;
            }
            else{
                [UIView animateWithDuration:0.05 animations:^{
                    CGPoint  p1 = _limitLab.center;
                    p1.y-=30*useTypeArr.count;
                    _limitLab.center = p1;
                    CGPoint p2 = _limitView.center;
                    p2.y -=30*useTypeArr.count;
                    _limitView.center = p2;
                }];
                _btnBgView.hidden = YES;
            }
        }
            break;
        case 2:
        {
            for (int i= 0; i< useTypeArr.count ;i++){
                UIButton *btn = (UIButton *)[self.view viewWithTag:200000+i];
                _btnBgView = [self.view viewWithTag:20];
                if (btn.tag == sender.tag){
                    btn.selected = !btn.selected;
                    if (btn.selected == YES){
                        btn.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                        _btnBgView.hidden = YES;
                        UIButton *btn = (UIButton *)[self.view viewWithTag:2000000];
                        btn.selected = !btn.selected;
                        [btn setTitle:useTypeArr[i] forState:UIControlStateNormal];
                        [btn setTitle:useTypeArr[i] forState:UIControlStateSelected];
                        [UIView animateWithDuration:0.05 animations:^{
                            CGPoint  p1 = _limitLab.center;
                            p1.y-=30*useTypeArr.count;
                            _limitLab.center = p1;
                            CGPoint p2 = _limitView.center;
                            p2.y -=30*useTypeArr.count;
                            _limitView.center = p2;
                        }];

                    }
                    else{
                        btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;

                        _btnBgView.hidden = NO;
                    }
                }
                else{
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
                        
                    }
                    else{
                        
                    }
                }
            }
        }
            break;
            
        case 30:
        {
            UIButton *btn = (UIButton *)[self.view viewWithTag:sender.tag];
            btn.selected = !btn.selected;
            _btnBgView = [self.view viewWithTag:30];
            if (btn.selected == YES){
                _btnBgView.hidden = NO;
            }
            else{
                _btnBgView.hidden = YES;
            }
        }

            break;
        case 3:
        {
            for (int i= 0; i< limitTypeArr.count ;i++){
                UIButton *btn = (UIButton *)[self.view viewWithTag:300000+i];
                _btnBgView = [self.view viewWithTag:30];
                if (btn.tag == sender.tag){
                    btn.selected = !btn.selected;
                    if (btn.selected == YES){
                        btn.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                        _btnBgView.hidden = YES;
                        UIButton *btn = (UIButton *)[self.view viewWithTag:3000000];
                        btn.selected = !btn.selected;
                        [btn setTitle:limitTypeArr[i] forState:UIControlStateNormal];
                        [btn setTitle:limitTypeArr[i] forState:UIControlStateSelected];
                        
                    }
                    else{
                        btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;

                        _btnBgView.hidden = NO;
                    }
                }
                else{
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
                        
                    }
                    else{
                        
                    }
                }
            }
        }
            break;
            
            
            
        default:
            break;
    }
}
- (NSString *)showStr {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"已选择日期:\r\n"];
    //从小到大排序
    [self.seletedDays sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSNumber *interval in self.seletedDays) {
        NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"MM.dd"];
        [str appendFormat:@"%@ ",partStr];
    }
    return [str copy];
}
//添加日期
-(void)addTimeTap:(UITapGestureRecognizer*)tap{
    switch (tap.view.tag) {
        case 301:
        {
            if (!_calendarView) {
                _calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
                [self.view addSubview:_calendarView];
                [_seletedDays removeAllObjects];
                __weak typeof(self) weakSelf = self;
                _calendarView.complete = ^(NSArray *result) {
                    if (result) {
                        weakSelf.seletedDays = [result mutableCopy];
                        for (NSNumber *interval in weakSelf.seletedDays) {
                            NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"yyyy-MM-dd"];
                            weakSelf.beginTimeLab.text = partStr;
                            weakSelf.calendarView = nil;
//                            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                            [user setObject:interval.doubleValue/1000.0 forKey:@"beginTime"];
//                            [user synchronize];
                        }
                    }
                };
            }
            [self.calendarView show];
}
            break;
        case 302:
        {

            if (!_calendarView) {
                _calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
                [self.view addSubview:_calendarView];
                
                __weak typeof(self) weakSelf = self;
                [_seletedDays removeAllObjects];
                _calendarView.complete = ^(NSArray *result) {
                    if (result) {
                        weakSelf.seletedDays = [result mutableCopy];
                        for (NSNumber *interval in weakSelf.seletedDays) {
                            NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"yyyy-MM-dd"];
                            weakSelf.endTimeLab.text = partStr;
                            weakSelf.calendarView = nil;
                        }
                    }
                };
            }
            [self.calendarView show];
        }
            break;
        default:
            break;
    }
}
//添加图片点击事件
-(void)addPhotoClick{
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 0;//最小选取照片数
    imagePickerController.maximumNumberOfSelection = 9;//最大选取照片数
    imagePickerController.selectedAssetArray =self.assetsArray;//已经选择了的照片
    UINavigationController*navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    self.assetsArray=[assets mutableCopy];
    [_imgArray removeAllObjects];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:nil forKey:@"photoArray"];
    [user synchronize];
    NSLog(@"%ld",(unsigned long)self.assetsArray.count);
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        if (_assetsArray.count == 0){
            _defaultLab.hidden = NO;
        }else{
            _defaultLab.hidden = YES;
            [_bgView removeAllSubviews];
            [_bgView addSubview:_addBtn];
            
            for (int i = 0; i<_assetsArray.count;i++){
                _photoImg = [[UIImageView alloc]initWithFrame:CGRectMake((i%5)*((_bgView.width - 60*WidthRate)/5 +11)+11, (i/5)*((_bgView.width - 60*WidthRate)/5+11)+11, (_bgView.width - 66*WidthRate)/5, (_bgView.width - 66*WidthRate)/5)];
                _photoImg.userInteractionEnabled = YES;
                [_photoImg sd_setImageWithURL:nil placeholderImage:_imgArray[i]];
                [_bgView addSubview:_photoImg];
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
                [_photoImg addGestureRecognizer:tapGes];
            }
        }
    }];
    for (JKAssets *asset in assets) {
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                [_imgArray addObject:image];
                
                NSData *imageData =  UIImageJPEGRepresentation([self rotateImage:image], 0.05);
                [_photoArray addObject:imageData];
                
            }
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:_photoArray forKey:@"photoArray"];
            [user synchronize];
        } failureBlock:^(NSError *error) {
            
        }];
    }
}
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
    }];
}
//这个方法是使拍照的时候控制照片的自动旋转
- (UIImage*)rotateImage:(UIImage *)image
{
    int kMaxResolution = 960; // Or whatever
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
//图片放大手势
-(void)bigTap:(UITapGestureRecognizer *)tap{
    for (int i = 0;i<1;i++){
        UIButton * btn = (UIButton *)[self.view viewWithTag:20000+i];
        btn.selected = !btn.selected;
        if (btn.tag == (tap.view.tag%1000 + 20000)){
            if (!(btn.selected = YES)){
                _previewBtn.enabled = YES;
                _selectTag = i;
                btn.selected = !btn.selected;
            }
            else{
                _previewBtn.enabled = YES;
                _selectTag = i;
            }
            
        }else{
            if ((btn.selected = YES)){
                btn.selected = !btn.selected;
            }
            else{
            }
            
        }
    }
    [_titleText resignFirstResponder];
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

//效果点击对号
-(void)selectedClick:(UIButton *)sender{
    [_titleText resignFirstResponder];
    sender.selected = !sender.selected;
    for (int i = 0 ; i< 4;i++){
        if (sender.tag == 20000+i){
            if (sender.selected == YES){
                _previewBtn.enabled = YES;
                _selectTag = i;
                
            }
            else{
                _previewBtn.enabled = NO;
                _selectTag = -1;
            }
        }else {
            
            UIButton * btn = (UIButton *)[self.view viewWithTag:20000+i];
            if (btn.selected == YES){
                _previewBtn.enabled = YES;
                _selectTag = i;
                btn.selected = !btn.selected;
            }
            
        }
    }
}
-(void)addUseContentTextTap{
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    self.leftBtn.hidden = YES;
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"useDirText"]?[use objectForKey:@"useDirText"]:@"";
    view.placeHolderLabel.text = @"请输入说明文字";
    view.residueLabel.hidden = YES;
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    view.block=^(NSString * str){
        self.leftBtn.hidden = NO;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:str forKey:@"useDirText"];
        [user synchronize];
        if ([str isEqualToString:@""]){
            _useDirContentTextDeLab.hidden = NO;
            _useDirCotentLab.hidden = YES;
            _useDirContentTextDeLab.text = @"请输入说明文字";
        }else
        {
            _useDirCotentLab.hidden = NO;
            _useDirContentTextDeLab.hidden = YES;
            _useDirCotentLab.text = str;
            
        }
        
    };
}
//添加内容
-(void)addTextTap{
    self.leftBtn.hidden = YES;
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"text"]?[use objectForKey:@"text"]:@"";
    view.placeHolderLabel.text = @"请输入你的意见最多50字";
    
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    
    view.block=^(NSString * str){
        self.leftBtn.hidden = NO;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:str forKey:@"text"];
        [user synchronize];
        if ([str isEqualToString:@""]){
            _defTextDeLab.hidden = NO;
            _textDeLab.hidden = YES;
            _defTextDeLab.text = @"请输入文字描述";
        }else
        {
            _textDeLab.hidden = NO;
            _defTextDeLab.hidden = YES;
            _textDeLab.text = str;
            
        }
        
    };
    
    
    
}
//添加活动内容手势
-(void)addContentTextTap{
    self.leftBtn.hidden = YES;
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"contentText"]?[use objectForKey:@"contentText"]:@"";
    view.placeHolderLabel.text = @"请输入活动内容";
    view.residueLabel.hidden = YES;
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    view.block=^(NSString * str){
        self.leftBtn.hidden = NO;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:str forKey:@"contentText"];
        [user synchronize];
        if ([str isEqualToString:@""]){
            _defContentTextDeLab.hidden = NO;
            _contentTextDeLab.hidden = YES;
            _defContentTextDeLab.text = @"请输入活动内容";
        }else
        {
            _contentTextDeLab.hidden = NO;
            _defContentTextDeLab.hidden = YES;
            _contentTextDeLab.text = str;
            
        }
        
    };
    
}
//预览效果事件
-(void)previewClick:(UIButton *)btn{
    btn.selected =!btn.selected;
    switch (_selectTag) {
        case 0:
            if (btn.selected == YES){
                self.leftBtn.hidden = YES;
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:_addressTextField.text forKey:@"address"];
                [user setObject:_textDeLab.text forKey:@"text"];
                [user setObject:_contentTextDeLab.text forKey:@"contentText"];
                [_previewBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
                PreView * view = [[PreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [self.view addSubview:view];
                view.transform = CGAffineTransformMakeScale(0.01, 0.01);
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    
                }];
                view.block =^(){
                    self.leftBtn.hidden = NO;
                    UIButton *btn = [self.view viewWithTag:100];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                    }
                };
                
            }
            else{
                [_previewBtn setBackgroundColor:[UIColor whiteColor]];
                [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
            }
            break;
        case 1:
            if (btn.selected == YES){
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:_addressTextField.text forKey:@"address"];
                [user setObject:_textDeLab.text forKey:@"text"];
                [user setObject:_contentTextDeLab.text forKey:@"contentText"];
                [_previewBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
                PreView1 * view = [[PreView1 alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [self.view addSubview:view];
                view.transform = CGAffineTransformMakeScale(0.01, 0.01);
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    
                }];
                view.block =^(){
                    UIButton *btn = [self.view viewWithTag:100];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                    }
                };
                
            }
            else{
                [_previewBtn setBackgroundColor:[UIColor whiteColor]];
                [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
    
}
//下一步 事件
-(void)nextClick:(UIButton *)btn{
    btn.selected =!btn.selected;
    if (btn.selected == YES){
        btn.selected = !btn.selected;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:_titleText.text forKey:@"title"];
        [user setObject:_addressTextField.text forKey:@"address"];
        [_nextBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
        BusinessChooseViewController * bcVC = [[BusinessChooseViewController alloc]init];
        bcVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bcVC animated:YES];
    }
    else{
        [_nextBtn setBackgroundColor:[UIColor whiteColor]];
        [_nextBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleText resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_redBagTextField resignFirstResponder];
    [_redBagContentTextField resignFirstResponder];
    [_dateTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
