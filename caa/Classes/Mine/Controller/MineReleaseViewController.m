//
//  MineReleaseViewController.m
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "MineReleaseViewController.h"
#import "DateModel.h"
#import "LoginViewController.h"
#import "ReleaseDetailViewController.h"
#import "HistoryReleaseViewController.h"
@interface MineReleaseViewController ()
{
    UIView *_dateView;
    NSMutableArray *_dateArr;
}
@property(nonatomic,strong)NSDictionary *pramerDic;

@end

@implementation MineReleaseViewController
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
    self.navigationItem.title  = @"我的发布";
    _dateArr = [NSMutableArray arrayWithArray:@[@"sdf",@"sdf",@"sd",@"sdf",@"adf",@"df"]];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    UILabel * nowLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 20*WidthRate, 100, 30)];
    nowLab.text = @"正在发布:";
    nowLab.textAlignment = NSTextAlignmentLeft;
    nowLab.font = [UIFont systemFontOfSize:18];
    nowLab.textColor = RGB(0.47, 0.47, 0.47);
    [self.view addSubview:nowLab];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12, nowLab.bottom + 10 * WidthRate, kScreenWidth-24, 65*WidthRate)];
    [self.view addSubview:_bgView];
    
    UILabel * review = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 60)/2, 15*WidthRate, 60, 20)];
    review.text = @"审核中";
    review.textColor =RGB(0.47, 0.47, 0.47);
    review.textAlignment = NSTextAlignmentCenter;
    review.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:review];
    
    UILabel * tipLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, review.bottom + 15*WidthRate, 200, 20)];
    tipLab.text = @"预计12：39分审核通过";
    tipLab.textColor =RGB(0.47, 0.47, 0.47);
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:tipLab];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(12, nowLab.bottom + 10 * WidthRate, kScreenWidth-24, 135*WidthRate)];
    _showView.hidden = YES;
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
    _detailBtn.frame = CGRectMake(40*WidthRate, nowLab.bottom+85 + 10*WidthRate, kScreenWidth-80*WidthRate, 40*WidthRate);
    _detailBtn.layer.cornerRadius = 20*WidthRate;
    _detailBtn.layer.masksToBounds = YES;
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_detailBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_detailBtn];
    
    _dateView = [self createViewWithY:_bgView.bottom + 20*WidthRate Title:@"历史发布:" contentArray:_dateArr part:1];
    [self.view addSubview:_dateView];
}
-(UIView *)createViewWithY:(CGFloat) y Title:(NSString *)title contentArray:(NSMutableArray *)array part :(NSInteger)tag{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, (((array.count-1)/2 +1) *50*WidthRate)+40*WidthRate)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 150, 30)];
    titleLab.text = title;
    titleLab.textColor = RGB(0.47, 0.47, 0.47);
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    for (int i = 0 ; i< array.count ; i++ ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%2)*((view.width-44)/2+20) + 12, titleLab.bottom + 15*WidthRate + (i/2)*(40*WidthRate +10), (view.width-44)/2, 40*WidthRate);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
        btn.layer.borderWidth = 0.5;
        btn.tag = 100*tag + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(0.44, 0.44, 0.44) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchDateClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
    }
    return view;
}
//点击事件事件
-(void)touchDateClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    for (int i = 0 ; i <_dateArr.count;i++){
        if (sender.tag == 100+i){
            if (sender.selected == YES){
                NSLog(@"&&&&&&%ld",(long)sender.tag);
                sender.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                HistoryReleaseViewController * hrVC = [[HistoryReleaseViewController alloc]init];
                hrVC.hidesBottomBarWhenPushed  = YES;
                [self.navigationController pushViewController:hrVC animated:YES];
            }
            else{
                NSLog(@"$$$$$$$$$%ld",(long)sender.tag);
                sender.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            }
        }else {
            
            UIButton * btn = (UIButton *)[self.view viewWithTag:100+i];
            if (btn.selected == YES){
                btn.selected = !btn.selected;
                btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            }
            else{
                btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            }
        }
    }
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
