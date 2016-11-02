//
//  PerAdMesViewController.m
//  caa
//
//  Created by xichao on 16/10/31.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "PerAdMesViewController.h"

@interface PerAdMesViewController ()

@end

@implementation PerAdMesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"完善广告信息";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12, 10*WidthRate, kScreenWidth-24, 160*WidthRate)];
    _bgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    [self.view addSubview:_bgView];
    
    _defaultLab = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 145*WidthRate)/2, (_bgView.height - 60*WidthRate)/2, 150*WidthRate, 60*WidthRate)];
    _defaultLab.text = @"添加商品照片";
    _defaultLab.textColor  = RGB(0.84, 0.84, 0.84);
    _defaultLab.font = [UIFont systemFontOfSize:20];
    [_bgView addSubview:_defaultLab];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _addBtn.frame = CGRectMake(_bgView.right-45, _bgView.bottom - 45, 25, 25);
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"home_addphotos"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addPhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_addBtn];
    
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _bgView.bottom + 20*WidthRate, 50, 50)];
    _textLab.text = @"标题:";
    _textLab.textColor = RGB(0.41, 0.41, 0.41);
    _textLab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_textLab];
    
    _titleText = [[UITextField alloc]initWithFrame:CGRectMake(_textLab.right + 10, _textLab.origin.y, kScreenWidth-_textLab.right-22, 45)];
    _titleText.placeholder = @"";
    _titleText.textColor = RGB(0.41, 0.41, 0.41);
    _titleText.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_titleText];
    
    _titleLine = [[UIView alloc]initWithFrame:CGRectMake(_titleText.left, _titleText.bottom+4, _titleText.width, 1)];
    _titleLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [self.view addSubview:_titleLine];
}

-(void)addPhotoClick{
    
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
