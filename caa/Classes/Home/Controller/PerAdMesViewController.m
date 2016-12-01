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
    int _btnSelectIndex;
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
@property(nonatomic,strong)NSMutableArray * btnImgArray;
@property(nonatomic,strong)NSMutableArray  *btnPhotoArray;
@property(nonatomic,strong)NSMutableArray  *btnAssetsArray;
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
    [user setObject:@"" forKey:@"title"];
    [user setObject:@"" forKey:@"tip"];
    [user setObject:@"" forKey:@"content"];
    [user setObject:nil forKey:@"btnPhotoArray"];
    [user setObject:@"" forKey:@"shopName"];
    [user setObject:@"" forKey:@"address"];
    [user setObject:@"" forKey:@"promotion_count"];
    [user setObject:@"" forKey:@"redContent"];
    [user setObject:@"" forKey:@"dateLimit"];
    [user setObject:@"" forKey:@"beginTime"];
    [user setObject:@"" forKey:@"endTime"];
    [user setObject:@"" forKey:@"useDirText"];
    [user setObject:@"0" forKey:@"limit"];
    _selectTag = 0;
    _btnImgArray = [NSMutableArray arrayWithCapacity:1];
    _btnPhotoArray = [NSMutableArray arrayWithCapacity:1];
    _btnAssetsArray= [NSMutableArray arrayWithCapacity:1];
    _photoArray = [NSMutableArray arrayWithCapacity:1];
    _assetsArray = [NSMutableArray array];
    _imgArray = [NSMutableArray array];
    //    vouchersArr = [NSArray arrayWithObjects:@"红包代金券",@"实物券", nil];
    //    useTypeArr = [NSArray arrayWithObjects:@"立即使用",@"隔日使用", nil];
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
    _effectView = [[UIView alloc]initWithFrame:CGRectMake(12, 10*WidthRate, kScreenWidth-24, 160*WidthRate)];
    _effectView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _effectView.layer.masksToBounds = YES;
    _effectView.layer.borderWidth = 1;
    _effectView.backgroundColor = [UIColor whiteColor];
    _effectView.layer.cornerRadius = 5;
    [_bgScrollView addSubview:_effectView];
    _effectImg = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, _effectView.width, _effectView.height)];
            _effectImg.userInteractionEnabled = YES;
            _effectImg.layer.masksToBounds = YES;
            [_effectImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"defImg"]];
    [_effectView addSubview:_effectImg];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
        [_effectImg addGestureRecognizer:tapGes];
    
//    _effectLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _titleLab.bottom + 15*WidthRate, 80, 30)];
//    _effectLab.font = [UIFont systemFontOfSize:15];
//    _effectLab.textColor = RGB(0.41, 0.41, 0.41);
//    _effectLab.text = @"动画效果:";
//    [_bgScrollView addSubview:_effectLab];
//    
//    for (int i=0 ; i<1 ; i++){
//        _effectImg = [[UIImageView alloc]initWithFrame:CGRectMake(_effectLab.right +(60*WidthRate +5)*i , _effectLab.origin.y+10, 60*WidthRate, 60*WidthRate)];
//        _effectImg.userInteractionEnabled = YES;
//        _effectImg.tag = i+1000;
//        _effectImg.layer.cornerRadius = 3;
//        _effectImg.layer.masksToBounds = YES;
//        [_effectImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"defImg"]];
//        _effectNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_effectImg.left, _effectImg.bottom + 8, _effectImg.width, 20)];
//        _effectNumLab.userInteractionEnabled = YES;
//        _effectNumLab.textColor = RGB(0.41, 0.41, 0.41);
//        _effectNumLab.tag = 10000+i;
//        _effectNumLab.textAlignment = NSTextAlignmentCenter;
//        _effectNumLab.text = [@"" stringByAppendingFormat:@"%@%d",@"效果",i+1];
//        _effectNumLab.font  = [UIFont systemFontOfSize:10];
//        [_bgScrollView addSubview:_effectImg];
//        [_bgScrollView addSubview: _effectNumLab];
//        UIButton *selectBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//        selectBtn.frame = CGRectMake(0, 0, _effectNumLab.width, _effectNumLab.height);
//        [selectBtn setImage:nil forState:UIControlStateNormal];
//        [selectBtn setImage:[UIImage imageNamed:@"home_all_tick"] forState:UIControlStateSelected];
//        selectBtn.tag = 20000+i;
//        [selectBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_effectNumLab addSubview:selectBtn];
//        
//        
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
//        [_effectImg addGestureRecognizer:tapGes];
//        
//    }
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _effectView.bottom + 15*WidthRate, 50, 30)];
    _titleLab.text = @"标题:";
    _titleLab.textColor = RGB(0.41, 0.41, 0.41);
    _titleLab.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:_titleLab];
    
    _titleText = [[UITextField alloc]initWithFrame:CGRectMake(_titleLab.right, _effectView.bottom + 15*WidthRate, kScreenWidth-_titleLab.right-12, 30)];
    _titleText.placeholder = @"请输入您的标题";
    _titleText.delegate = self;
    _titleText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _titleText.textColor = RGB(0.41, 0.41, 0.41);
    _titleText.font = [UIFont systemFontOfSize:13];
    [_bgScrollView addSubview:_titleText];
    
    _titleLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleText.height-5, _titleText.width, 1)];
    _titleLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_titleText addSubview:_titleLine];
    
    _contentLab = [[UILabel alloc]initWithFrame:CGRectMake(12,_titleLab.bottom+ 10*WidthRate, 100, 30)];
    _contentLab.font = [UIFont systemFontOfSize:15];
    _contentLab.textColor = RGB(0.41, 0.41, 0.41);
    _contentLab.text = @"活动内容(A):";
    [_bgScrollView addSubview:_contentLab];
    
    _contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(_contentLab.right , _titleLab.bottom+ 10*WidthRate, kScreenWidth-_contentLab.right-12, 30)];
    _contentTextField.placeholder = @"请输入活动内容";
    _contentTextField.delegate = self;
    _contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _contentTextField.textColor = RGB(0.41, 0.41, 0.41);
    _contentTextField.font = [UIFont systemFontOfSize:13];
    [_bgScrollView addSubview:_contentTextField];
    
    UIView *contentLine = [[UIView alloc]initWithFrame:CGRectMake(0, _contentTextField.height-1, _contentTextField.width, 1)];
    contentLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_contentTextField addSubview:contentLine];
    
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12,_contentLab.bottom+ 10*WidthRate, kScreenWidth-24, 160*WidthRate)];
    _bgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    [_bgScrollView addSubview:_bgView];
    _defaultLab = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 155*WidthRate)/2, (_bgView.height - 60*WidthRate)/2, 170*WidthRate, 60*WidthRate)];
    _defaultLab.text = @"添加广告照片(B)";
    _defaultLab.textAlignment = NSTextAlignmentCenter;
    _defaultLab.textColor  = RGB(0.84, 0.84, 0.84);
    _defaultLab.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:_defaultLab];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _addBtn.frame = CGRectMake(_bgView.right-55,_bgView.height-45, 35, 35);
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"home_addphotos"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addPhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_addBtn];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, _bgView.bottom+10*WidthRate, kScreenWidth, 205*WidthRate)];
    [_bgScrollView addSubview:_contentView];
   
    
    _shopLab= [[UILabel alloc]initWithFrame:CGRectMake(12,5*WidthRate, 100, 30)];
    _shopLab.text = @"商品图片(C):";
    _shopLab.textColor = RGB(0.41, 0.41, 0.41);
    _shopLab.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:_shopLab];
    
    _shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shopBtn.frame = CGRectMake(_shopLab.right,5*WidthRate , 60*WidthRate, 60*WidthRate);
    _shopBtn.layer.masksToBounds = YES;
    _shopBtn.tag = 60000000;
    _shopBtn.layer.cornerRadius = 3*WidthRate;
    _shopBtn.layer.borderWidth = 0.5;
    _shopBtn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    [_shopBtn setBackgroundColor:[UIColor whiteColor]];
    [_shopBtn setImage:[UIImage imageNamed:@"home_addphotos"] forState:UIControlStateNormal];
    [_shopBtn addTarget:self action:@selector(addPhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_shopBtn];
    
    _tipLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _shopBtn.bottom + 10*WidthRate, 100, 30)];
    _tipLab.font = [UIFont systemFontOfSize:15];
    _tipLab.textColor = RGB(0.41, 0.41, 0.41);
    _tipLab.text = @"推荐文字(D):";
    [_contentView addSubview:_tipLab];
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    
    _tipTextField = [[UITextField alloc]initWithFrame:CGRectMake(_tipLab.right , _shopBtn.bottom + 15*WidthRate, kScreenWidth-_tipLab.right-12, 30)];
    _tipTextField.placeholder = @"请输入推荐文字";
    _tipTextField.delegate = self;
    _tipTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tipTextField.textColor = RGB(0.41, 0.41, 0.41);
    _tipTextField.font = [UIFont systemFontOfSize:13];
    [_contentView addSubview:_tipTextField];
    
    UIView *tipLine = [[UIView alloc]initWithFrame:CGRectMake(0, _tipTextField.height-1, _tipTextField.width, 1)];
    tipLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_tipTextField addSubview:tipLine];
    
    _shopNameLab= [[UILabel alloc]initWithFrame:CGRectMake(12, _tipLab.bottom + 15*WidthRate, 80, 30)];
    _shopNameLab.text = @"商铺名称:";
    _shopNameLab.textColor = RGB(0.41, 0.41, 0.41);
    _shopNameLab.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:_shopNameLab];
    
    _shopNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(_shopNameLab.right , _tipLab.bottom + 15*WidthRate, kScreenWidth-_shopNameLab.right-12, 30)];
    _shopNameTextField.placeholder = @"请输入商铺名称";
    _shopNameTextField.delegate = self;
    _shopNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _shopNameTextField.textColor = RGB(0.41, 0.41, 0.41);
    _shopNameTextField.font = [UIFont systemFontOfSize:13];
    [_contentView addSubview:_shopNameTextField];
    
    UIView *shopNameLine = [[UIView alloc]initWithFrame:CGRectMake(0, _shopNameTextField.height-1, _shopNameTextField.width, 1)];
    shopNameLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_shopNameTextField addSubview:shopNameLine];
    
    _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _shopNameTextField.bottom + 15*WidthRate, 80, 30)];
    _addressLab.text = @"商铺地址:";
    _addressLab.textColor = RGB(0.41, 0.41, 0.41);
    _addressLab.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:_addressLab];
    
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(_addressLab.right , _shopNameTextField.bottom + 15*WidthRate, kScreenWidth-_addressLab.right-12, 30)];
    _addressTextField.placeholder = @"请输入商铺地址";
    _addressTextField.delegate = self;
    _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressTextField.textColor = RGB(0.41, 0.41, 0.41);
    _addressTextField.font = [UIFont systemFontOfSize:13];
    [_contentView addSubview:_addressTextField];
    
    UIView *addressLine = [[UIView alloc]initWithFrame:CGRectMake(0, _addressTextField.height-1, _addressTextField.width, 1)];
    addressLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_addressTextField addSubview:addressLine];
    
    UIView *Line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _contentView.bottom + 15*WidthRate, kScreenWidth, 1)];
    Line1.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_bgScrollView addSubview:Line1];
    UIView *Line2 = [[UIView alloc]initWithFrame:CGRectMake(0, Line1.bottom + 5*WidthRate, kScreenWidth, 1)];
    Line2.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_bgScrollView addSubview:Line2];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, Line2.bottom + 15*WidthRate, 100, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"营销活动";
    title.textColor = RGB(0.41, 0.41, 0.41);
    title.font = [UIFont systemFontOfSize:20];
    [_bgScrollView addSubview:title];
    
    //    _typeLab = [[UILabel alloc]initWithFrame:CGRectMake(12, title.bottom + 25*WidthRate, 80, 30)];
    //    _typeLab.text = @"营销类型:";
    //    _typeLab.textColor = RGB(0.41, 0.41, 0.41);
    //    _typeLab.font = [UIFont systemFontOfSize:15];
    //    [_bgScrollView addSubview:_typeLab];
    //
    //    _vouchersView  = [self createWithX:_typeLab.right Y:title.bottom+25*WidthRate Button:vouchersArr tag:100000];
    //    [_bgScrollView addSubview:_vouchersView];
    
    
    _redBgView = [[UIView alloc]initWithFrame:CGRectMake(0, title.bottom + 20*WidthRate, kScreenWidth, 170)];
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
    
    _redBagContent = [[UILabel alloc]initWithFrame:CGRectMake(12, _redBagCount.bottom+15*WidthRate, 80, 30)];
    _redBagContent.text = @"红包内容:";
    _redBagContent.textColor = RGB(0.41, 0.41, 0.41);
    _redBagContent.font = [UIFont systemFontOfSize:15];
    [_redBgView addSubview:_redBagContent];
    
    _redBagContentTextField = [[UITextField alloc]initWithFrame:CGRectMake(_redBagContent.right, _redBagCount.bottom+ 15*WidthRate, kScreenWidth-_redBagContent.right-12, 30)];
    _redBagContentTextField.layer.borderWidth = 1;
    _redBagContentTextField.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _redBagContentTextField.delegate = self;
    _redBagContentTextField.placeholder = @"请输入红包内容";
    _redBagContentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _redBagContentTextField.textColor = RGB(0.41, 0.41, 0.41);
    [_redBgView addSubview:_redBagContentTextField];
    
    
    _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _redBagContent.bottom+15*WidthRate, 80, 30)];
    _dateLab.text = @"有效期(日):";
    _dateLab.textColor = RGB(0.41, 0.41, 0.41);
    _dateLab.font = [UIFont systemFontOfSize:15];
    [_redBgView addSubview:_dateLab];
    
    _dateTextField = [[UITextField alloc]initWithFrame:CGRectMake(_dateLab.right, _redBagContent.bottom+ 15*WidthRate, kScreenWidth-_redBagContent.right-12, 30)];
    _dateTextField.layer.borderWidth = 1;
    _dateTextField.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _dateTextField.delegate = self;
    _dateTextField.placeholder = @"请输入有效期限";
    _dateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _dateTextField.keyboardType = UIKeyboardTypeNumberPad;
    _dateTextField.textColor = RGB(0.41, 0.41, 0.41);
    [_redBgView addSubview:_dateTextField];
    
    _actionTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _dateLab.bottom+15*WidthRate, 80, 30)];
    _actionTimeLab.font = [UIFont systemFontOfSize:15];
    _actionTimeLab.textColor = RGB(0.41, 0.41, 0.41);
    _actionTimeLab.text = @"活动时间:";
    [_redBgView addSubview:_actionTimeLab];
    
    _beginTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_actionTimeLab.right, _dateLab.bottom + 15*WidthRate, (kScreenWidth - _actionTimeLab.right - 42)/2, 30)];
    _beginTimeLab.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _beginTimeLab.layer.borderWidth = 1;
    _beginTimeLab.userInteractionEnabled = YES;
    _beginTimeLab.tag = 301;
    _beginTimeLab.textColor = RGB(0.41, 0.41, 0.41);
    _beginTimeLab.textAlignment = NSTextAlignmentCenter;
    [_redBgView addSubview:_beginTimeLab];
    UITapGestureRecognizer *tapGesBeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTimeTap:)];
    [_beginTimeLab addGestureRecognizer:tapGesBeg];
    _andLab = [[UILabel alloc]initWithFrame:CGRectMake(_beginTimeLab.right, _dateLab.bottom + 15*WidthRate, 30, 30)];
    _andLab.text = @"至";
    _andLab.textAlignment = NSTextAlignmentCenter;
    _andLab.font = [UIFont systemFontOfSize:15];
    _andLab.textColor = RGB(0.41, 0.41, 0.41);
    [_redBgView addSubview:_andLab];
    
    _endTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_andLab.right, _dateLab.bottom + 15*WidthRate, (kScreenWidth - _actionTimeLab.right - 42)/2, 30)];
    _endTimeLab.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _endTimeLab.layer.borderWidth = 1;
    _endTimeLab.tag = 302;
    _endTimeLab.userInteractionEnabled = YES;
    _endTimeLab.textColor = RGB(0.41, 0.41, 0.41);
    _endTimeLab.textAlignment = NSTextAlignmentCenter;
    [_redBgView addSubview:_endTimeLab];
    UITapGestureRecognizer *tapGesEnd = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTimeTap:)];
    [_endTimeLab addGestureRecognizer:tapGesEnd];
    
    
    
    _setLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _redBgView.bottom+15*WidthRate, 120, 30)];
    _setLab.text = @"使用条件设置:";
    _setLab.textColor = RGB(0.41, 0.41, 0.41);
    _setLab.font = [UIFont systemFontOfSize:17];
    [_bgScrollView addSubview:_setLab];
    
    
    _useDirLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _setLab.bottom+15*WidthRate, 80, 30)];
    _useDirLab.font = [UIFont systemFontOfSize:15];
    _useDirLab.textColor = RGB(0.41, 0.41, 0.41);
    _useDirLab.text = @"使用说明:";
    [_bgScrollView addSubview:_useDirLab];
    
    _useDirBgView = [[UIView alloc]initWithFrame:CGRectMake(_useDirLab.right, _setLab.bottom+15*WidthRate, kScreenWidth - _useDirLab.right-12, 40*WidthRate)];
    _useDirBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _useDirBgView.layer.borderWidth = 1;
    _useDirBgView.userInteractionEnabled = YES;
    [_bgScrollView addSubview:_useDirBgView];
    
    
    UITapGestureRecognizer *tapGe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addUseContentTextTap)];
    [_useDirBgView addGestureRecognizer:tapGe];
    
    
    _useDirCotentLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _useDirBgView.width-5, 30 )];
    _useDirCotentLab.font = [UIFont systemFontOfSize:12];
    _useDirCotentLab.numberOfLines = 0;
    _useDirCotentLab.text = [use objectForKey:@"useDirText"]?[use objectForKey:@"useDirText"]:@"";
    _useDirCotentLab.textColor = RGB(0.41, 0.41, 0.41);
    [_useDirBgView addSubview:_useDirCotentLab];
    
    
    _useDirContentTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _useDirBgView.width, 30 )];
    _useDirContentTextDeLab.numberOfLines = 0;
    _useDirContentTextDeLab.text = @"这里填写简短的优惠券使用说明";
    _useDirContentTextDeLab.font = [UIFont systemFontOfSize:14];
    _useDirContentTextDeLab.textColor = RGB(0.78, 0.78, 0.80);
    [_useDirBgView addSubview:_useDirContentTextDeLab];
    
    
    
    //    _useCondLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _useDirBgView.bottom + 10*WidthRate, 80, 30)];
    //    _useCondLab.text = @"使用条件:";
    //    _useCondLab.textColor = RGB(0.41, 0.41, 0.41);
    //    _useCondLab.font = [UIFont systemFontOfSize:15];
    //    [_bgScrollView addSubview:_useCondLab];
    //    UIView * useCondView = [self createWithX:_useCondLab.right Y:_useDirBgView.bottom + 10*WidthRate Button:useTypeArr tag:200000];
    //    [_bgScrollView addSubview:useCondView];
    
    
    _limitLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _useDirBgView.bottom +15*WidthRate, 80, 30)];
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
                        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
                        [use setObject:[NSString stringWithFormat:@"%d",i] forKey:@"vouchers"];
                        [use synchronize];
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
                        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
                        [use setObject:[NSString stringWithFormat:@"%d",i] forKey:@"useCond"];
                        [use synchronize];
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
                        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
                        [use setObject:[NSString stringWithFormat:@"%d",i] forKey:@"limit"];
                        [use synchronize];
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
    [_dateTextField resignFirstResponder];
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
                            NSString * time = [NSString stringWithFormat:@"%.f",interval.doubleValue/1000.0];
                            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                            [user setObject:time forKey:@"beginTime"];
                            [user synchronize];
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
                            NSString * time = [NSString stringWithFormat:@"%.f",interval.doubleValue/1000.0];
                            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                            [user setObject:time forKey:@"endTime"];
                            [user synchronize];
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
-(void)addPhotoClick:(UIButton *)sender{
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 0;//最小选取照片数
    if (sender.tag == 60000000){
        _btnSelectIndex = 1;
        imagePickerController.selectedAssetArray =self.btnAssetsArray;//已经选择了的照片
        imagePickerController.maximumNumberOfSelection = 1;//最大选取照片数
  
    }else{
        imagePickerController.selectedAssetArray =self.assetsArray;//已经选择了的照片
    imagePickerController.maximumNumberOfSelection = 9;//最大选取照片数
    }
    UINavigationController*navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    if (_btnSelectIndex == 1){
        self.btnAssetsArray = [assets mutableCopy];
        [_btnImgArray removeAllObjects];
        
        [imagePicker dismissViewControllerAnimated:YES completion:^{
            UIButton * btn = [self.view viewWithTag:60000000];
            [btn setImage:_btnImgArray[0] forState:UIControlStateNormal];
        }];
        for (JKAssets *asset in assets) {
            [_btnPhotoArray removeAllObjects];
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                    [_btnImgArray addObject:image];
                    
                    NSData *imageData =  UIImageJPEGRepresentation([self rotateImage:image], 0.05);
                    [_btnPhotoArray addObject:imageData];
                    
                }
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:_btnPhotoArray forKey:@"btnPhotoArray"];
                [user synchronize];
            } failureBlock:^(NSError *error) {
                
            }];
        }
    }
    else{
    self.assetsArray=[assets mutableCopy];
    [_imgArray removeAllObjects];
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
                _photoImg.layer.cornerRadius = 3;
                _photoImg.layer.masksToBounds = YES;
                [_photoImg sd_setImageWithURL:nil placeholderImage:_imgArray[i]];
                [_bgView addSubview:_photoImg];
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
                [_photoImg addGestureRecognizer:tapGes];
            }
        }
    }];
    for (JKAssets *asset in assets) {
        [_photoArray removeAllObjects];
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
                _selectTag = i;
                
            }
            else{
                _selectTag = -1;
            }
        }else {
            
            UIButton * btn = (UIButton *)[self.view viewWithTag:20000+i];
            if (btn.selected == YES){
                _selectTag = i;
                btn.selected = !btn.selected;
            }
            
        }
    }
}
//使用说明
-(void)addUseContentTextTap{
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    self.leftBtn.hidden = YES;
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"useDirText"]?[use objectForKey:@"useDirText"]:@"";
    view.placeHolderLabel.text = @"这里填写简短的优惠券使用说明";
    view.residueLabel.hidden = YES;
    if ([[use objectForKey:@"useDirText"] length]>0){
        view.placeHolderLabel.hidden = YES;
    }else
        view.placeHolderLabel.hidden = NO;
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    view.block=^(NSString * str, int index){
        self.leftBtn.hidden = NO;
        if (index == 0){
            if ([str isEqualToString:[use objectForKey:@"useDirText"]]&& [ str isEqualToString:@""]){
                _defContentTextDeLab.hidden = NO;
                _contentTextDeLab.hidden = YES;
                _defContentTextDeLab.text = @"请输入说明文字";
                
            }
            else if (![str isEqualToString:[use objectForKey:@"useDirText"]]){
                _defContentTextDeLab.hidden = NO;
                _contentTextDeLab.hidden = YES;
                _defContentTextDeLab.text = @"请输入说明文字";
            }
            else{
                _contentTextDeLab.hidden = NO;
                _defContentTextDeLab.hidden = YES;
                _contentTextDeLab.text = str;
            }
        }else{
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
        }
    };
}
//添加推荐内容
-(void)addTextTap{
    self.leftBtn.hidden = YES;
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"text"]?[use objectForKey:@"text"]:@"";
    view.placeHolderLabel.text = @"请输入你的描述文字最多10字";
    if ([[use objectForKey:@"text"] length]>0){
        view.placeHolderLabel.hidden = YES;
    }else
        view.placeHolderLabel.hidden = NO;
    
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    
    view.block=^(NSString * str,int index){
        self.leftBtn.hidden = NO;
        if (index == 0){
            if ([str isEqualToString:[use objectForKey:@"text"]]&& [ str isEqualToString:@""]){
                _defContentTextDeLab.hidden = NO;
                _contentTextDeLab.hidden = YES;
                _defContentTextDeLab.text = @"请输入文字描述";
                
            }
            else if (![str isEqualToString:[use objectForKey:@"text"]]){
                _defContentTextDeLab.hidden = NO;
                _contentTextDeLab.hidden = YES;
                _defContentTextDeLab.text = @"请输入文字描述";
            }
            else{
                _contentTextDeLab.hidden = NO;
                _defContentTextDeLab.hidden = YES;
                _contentTextDeLab.text = str;
            }
        }else{
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
    if ([[use objectForKey:@"contentText"] length]>0){
        view.placeHolderLabel.hidden = YES;
    }else
        view.placeHolderLabel.hidden = NO;
    
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    view.block=^(NSString * str , int index){
        self.leftBtn.hidden = NO;
        if (index == 0){
            if ([str isEqualToString:[use objectForKey:@"contentText"]]&& [ str isEqualToString:@""]){
                _defContentTextDeLab.hidden = NO;
                _contentTextDeLab.hidden = YES;
                _defContentTextDeLab.text = @"请输入活动内容";
                
            }
            else if (![str isEqualToString:[use objectForKey:@"contentText"]]){
                _defContentTextDeLab.hidden = NO;
                _contentTextDeLab.hidden = YES;
                _defContentTextDeLab.text = @"请输入活动内容";
            }
            else{
                _contentTextDeLab.hidden = NO;
                _defContentTextDeLab.hidden = YES;
                _contentTextDeLab.text = str;
            }
        }else{
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
        }
    };
    
    
}
//预览效果事件
-(void)previewClick:(UIButton *)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:_tipTextField.text forKey:@"tip"];
    [user setObject:_contentTextField.text forKey:@"content"];
    [user setObject:_shopNameTextField.text forKey:@"shopName"];
    [user setObject:_addressTextField.text forKey:@"address"];
     if ([[user objectForKey:@"content"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"活动内容不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
     else if (![[user objectForKey:@"photoArray"] isKindOfClass:[NSArray class]]){
         HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"广告图片不能为空" buttonTitles:@"确定", nil];
         [alert showInView:self.view completion:nil];
     }
    else if (_selectTag == -1){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"未选择预览效果图" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if(![[user objectForKey:@"btnPhotoArray"] isKindOfClass:[NSArray class]]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"优惠商品图片不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
        
    }
    else if ([[user objectForKey:@"tip"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"推荐文字不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    
    else if ([[user objectForKey:@"shopName"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"商铺名称不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if ([[user objectForKey:@"address"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"商铺地址不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    
    else{
        btn.selected =!btn.selected;
        switch (_selectTag) {
            case 0:
                if (btn.selected == YES){
                    self.leftBtn.hidden = YES;
                    
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
}
//下一步 事件
-(void)nextClick:(UIButton *)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:_titleText.text forKey:@"title"];
    [user setObject:_tipTextField.text forKey:@"tip"];
    [user setObject:_contentTextField.text forKey:@"content"];
    [user setObject:_shopNameTextField.text forKey:@"shopName"];
    [user setObject:_addressTextField.text forKey:@"address"];
    [user setObject:_redBagContentTextField.text forKey:@"redContent"];
    [user setObject:_redBagTextField.text forKey:@"promotion_count"];
    [user setObject:_dateTextField.text forKey:@"dateLimit"];
    
    if ([[user objectForKey:@"title"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"标题不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
        
    }
    else if ([[user objectForKey:@"content"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"活动内容不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (_selectTag == -1){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"效果图未选择" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if (![[user objectForKey:@"photoArray"] isKindOfClass:[NSArray class]]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"广告图片不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if(![[user objectForKey:@"btnPhotoArray"] isKindOfClass:[NSArray class]]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"优惠商品图片不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
        
    }

    else if ([[user objectForKey:@"tip"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"推荐文字不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    
    
   
    else if ([[user objectForKey:@"shopName"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"商铺名称不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if ([[user objectForKey:@"address"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"活动地址不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if ([[user objectForKey:@"promotion_count"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"优惠券数量不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if ([[user objectForKey:@"redContent"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"优惠内容不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
        
    }
    else if ([[user objectForKey:@"dateLimit"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"有效期限不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
        
    }else if ([[user objectForKey:@"beginTime"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"活动开始时间不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    
    else if ([[user objectForKey:@"endTime"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"活动结束时间不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    } else if ([[user objectForKey:@"endTime"] intValue] < [[user objectForKey:@"beginTime"] intValue]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"活动结束时间不符合" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    else if ([[user objectForKey:@"useDirText"] isEqualToString:@""]){
        HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"优惠券或红包的使用说明不能为空" buttonTitles:@"确定", nil];
        [alert showInView:self.view completion:nil];
    }
    
    else{
        btn.selected =!btn.selected;
        if (btn.selected == YES){
            btn.selected = !btn.selected;
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
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleText resignFirstResponder];
    [_tipTextField resignFirstResponder];
    [_contentTextField resignFirstResponder];
    [_shopNameTextField resignFirstResponder];
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
