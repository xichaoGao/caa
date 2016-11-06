//
//  HistoryReleaseViewController.m
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "HistoryReleaseViewController.h"
#import "ReleaseDetailViewController.h"

@interface HistoryReleaseViewController ()

@end

@implementation HistoryReleaseViewController
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
    self.navigationItem.title  = @"历史发布";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    UILabel * nowLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, 20*WidthRate, 200, 30)];
    nowLab.text = @"正在发布:";
    nowLab.textAlignment = NSTextAlignmentCenter;
    nowLab.font = [UIFont systemFontOfSize:18];
    nowLab.textColor = RGB(0.47, 0.47, 0.47);
    [self.view addSubview:nowLab];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(12, nowLab.bottom + 10 * WidthRate, kScreenWidth-24, 135*WidthRate)];
    [self.view addSubview:_showView];
    _relLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*WidthRate, 35*WidthRate)];
    _relLab.text = @"正在发布:";
    _relLab.textColor = RGB(0.47, 0.47, 0.47);
    _relLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_relLab];
    _relLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_relLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _relLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_relLabNum];
    
    _playLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 140*WidthRate, 0, 80*WidthRate, 35*WidthRate)];
    _playLab.text = @"播放次数:";
    _playLab.textColor = RGB(0.47, 0.47, 0.47);
    _playLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_playLab];
    
    _playLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_playLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _playLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_playLabNum];
    
    
    _receLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _relLab.bottom + 15*WidthRate, 80*WidthRate, 35*WidthRate)];
    _receLab.text = @"领取人数:";
    _receLab.textColor = RGB(0.47, 0.47, 0.47);
    _receLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_receLab];
    _receLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_receLab.right + 3, _relLab.bottom + 15*WidthRate, 60*WidthRate, 35*WidthRate)];
    _receLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_receLabNum];
    
    _useLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 140*WidthRate, _relLab.bottom + 15*WidthRate, 80*WidthRate, 35*WidthRate)];
    _useLab.text = @"使用人数:";
    _useLab.textColor = RGB(0.47, 0.47, 0.47);
    _useLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_useLab];
    
    _useLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_useLab.right + 3, _relLab.bottom + 15*WidthRate, 60*WidthRate, 35*WidthRate)];
    _useLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_useLabNum];
    
    _detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _detailBtn.frame = CGRectMake(40*WidthRate-12, nowLab.bottom+85 + 10*WidthRate, kScreenWidth-80*WidthRate, 40*WidthRate);
    _detailBtn.layer.cornerRadius = 20*WidthRate;
    _detailBtn.layer.masksToBounds = YES;
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_detailBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_detailBtn];
    
}
//详情事件
-(void)detailClick{
    ReleaseDetailViewController * rdVC = [[ReleaseDetailViewController alloc]init];
    rdVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rdVC animated:YES];
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
