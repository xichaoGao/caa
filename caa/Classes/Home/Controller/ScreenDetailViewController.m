//
//  ScreenDetailViewController.m
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ScreenDetailViewController.h"

@interface ScreenDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ScreenDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"屏幕详情";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _screenImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth - 24, 160*WidthRate)];
    _screenImg.layer.masksToBounds = YES;
    _screenImg.layer.cornerRadius = 5;
    _screenImg.layer.borderColor = RGB(0.81, 0.81, 0.81).CGColor;
    _screenImg.layer.borderWidth = 1;
    [self.view addSubview:_screenImg];
    _faceImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_pic"]];
    _faceImg.frame = CGRectMake((_screenImg.width - 80*WidthRate)/2, (_screenImg.height - 80*WidthRate)/2-20*WidthRate, 80*WidthRate, 80*WidthRate);
    [_screenImg addSubview:_faceImg];
    
    _faceLab = [[UILabel alloc]initWithFrame:CGRectMake((_screenImg.width - 150*WidthRate)/2, _faceImg.bottom + 5, 150*WidthRate, 30*WidthRate)];
    _faceLab.text = @"正在努力加载中...";
    _faceLab.textColor = RGB(0.84, 0.84, 0.84);
    _faceLab.textAlignment = UITextAlignmentCenter;
    _faceLab.font = [UIFont systemFontOfSize:16];
    [_screenImg addSubview:_faceLab];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _screenImg.bottom + 5, kScreenWidth, 25*WidthRate)];
    [self.view addSubview:_bgView];
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 150, 25*WidthRate)];
    _titleLab.textColor = RGB(0.96, 0.55, 0.40);
    _titleLab.font = [UIFont systemFontOfSize:20];
    _titleLab.text = @"外婆家一屏";
    [_bgView addSubview:_titleLab];
    _hotLab = [[UILabel alloc]initWithFrame:CGRectMake(_bgView.width - 120, 5, 40, 25*WidthRate)];
    _hotLab.text = @"热度:";
    _hotLab.textColor = RGB(0.41, 0.41, 0.41);
    _hotLab.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_hotLab];
    for (int i=0 ; i<3;i++){
        _heartImg = [[UIImageView alloc]initWithFrame:CGRectMake(_hotLab.right+5 + i*20, 10, 15, 15)];
        [_heartImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_detail_heat"]];
        [_bgView addSubview:_heartImg];
    }
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"人气最高",@"小资",@"口味最佳",@"环境最佳",@"服务员最佳"]];
    UIView * tagView = [self createViewWithY:_bgView.bottom+10 Title:@"餐厅标签" contentArray:arr];
    [self.view addSubview:tagView];
    _listLab = [[UILabel alloc]initWithFrame:CGRectMake(12, tagView.bottom + 10*WidthRate, 150, 25*WidthRate)];
    _listLab.textColor = RGB(0.41, 0.41, 0.41);
    _listLab.text = @"正在播放广告列表";
    _listLab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_listLab];
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(-6*WidthRate, _listLab.bottom + 10, kScreenWidth -24, 150)];
    _listTableView.delegate = self;
    _listTableView.rowHeight = 30;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _listTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_listTableView];
}
-(UIView *)createViewWithY:(CGFloat) y Title:(NSString *)title contentArray:(NSMutableArray *)array{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, (((array.count-1)/4 +1) *50*WidthRate)+40*WidthRate)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 150, 30)];
    titleLab.text = title;
    titleLab.textColor = RGB(0.41, 0.41, 0.41);
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    for (int i = 0 ; i< array.count ; i++ ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%4)*((view.width-60)/4+12) + 12, titleLab.bottom + 15*WidthRate + (i/4)*(40*WidthRate +10), (view.width-60)/4, 40*WidthRate);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 1000 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateNormal];
        [view addSubview:btn];
        
    }
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellID";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    cell.textLabel.text = @"流口水的姐夫来喀什绝地反击";
    cell.textLabel.textColor = RGB(0.41, 0.41, 0.41);
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
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
