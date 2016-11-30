//
//  MineReleaseViewController.m
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "MineReleaseViewController.h"
#import "ProgressModel.h"
#import "HistoryModel.h"
#import "LoginViewController.h"
#import "ReleaseDetailViewController.h"
#import "WxUserListViewController.h"
#import "HistoryReleaseViewController.h"
@interface MineReleaseViewController ()
{
    UILabel * nowLab;
    UIView *_dateView;
    NSMutableArray *_dateArr;
    ProgressModel * _model;
    BOOL isRefresh;
}
@property(nonatomic,strong)NSDictionary *pramerDic;
@property(nonatomic,strong)UIScrollView * bgScrollView;
@property(nonatomic,assign)int pageID;
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
    _pageID = 0;
    self.navigationItem.title  = @"我的发布";
    _dateArr = [NSMutableArray arrayWithCapacity:1];
    [self createUI];
    [self getDataSoure];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshHomeData) name:@"Refresh" object:nil];
    // Do any additional setup after loading the view.
}
-(void)getDataSoure{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"],@"from":[NSString stringWithFormat:@"%d",_pageID]};
    
    
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetMineRelease RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            
            if (isRefresh){
                [_bgScrollView.mj_header endRefreshing];
                [_dateArr removeAllObjects];
            }else{
                [_bgScrollView.mj_footer endRefreshing];
            }
            NSDictionary * dic = [result objectForKey:@"data"];
            _model = [ProgressModel mj_objectWithKeyValues:dic[@"in_progress"]];
            if ([_model.status isEqualToString:@"1"]){
                nowLab.text = @"正在发布:";
                _showView.hidden = NO;
                _relLabNum.text = [NSString stringWithFormat:@"%ld 屏",_model.device_count];
                _playLabNum.text = [NSString stringWithFormat:@"%@ 次",_model.play_count];
                _receLabNum.text = [NSString stringWithFormat:@"%@ 人",_model.get_count];
                _useLabNum.text = [NSString stringWithFormat:@"%@ 人",_model.use_count];
                if ([_model.get_count isEqualToString:@"0"]){
                    _receBtn.enabled = NO;
                }else{
                    _receBtn.enabled = YES;
                    
                }
                if ([_model.use_count isEqualToString:@"0"]){
                    _useBtn.enabled = NO;
                }else{
                    _useBtn.enabled = YES;
                    
                }
            }
            else if ([_model.status isEqualToString:@"0"]){
                nowLab.text = @"正在审核:";
                _bgView.hidden = NO;
            }
            else{
                nowLab.hidden = YES;
                _showView.hidden = YES;
                _bgView.hidden =  YES;
            }
            
            if ([dic[@"history"] isKindOfClass:[NSArray class]]){
                NSArray *arr = dic[@"history"];
                [_dateView removeFromSuperview];
                [_dateArr removeAllObjects];
                if (arr.count >0){
                    for (int i = 0;i<arr.count ;i++){
                        HistoryModel * mol = [HistoryModel mj_objectWithKeyValues:arr[i]];
                        [_dateArr addObject:mol];
                    }
                    if (_showView.hidden == NO){
                        _dateView = [self createViewWithY:_showView.bottom + 20*WidthRate Title:@"历史发布:" contentArray:_dateArr part:1];
                        [_bgScrollView addSubview:_dateView];
                    }
                    else if (_bgView.hidden == NO){
                        _dateView = [self createViewWithY:_bgView.bottom + 20*WidthRate Title:@"历史发布:" contentArray:_dateArr part:1];
                        [_bgScrollView addSubview:_dateView];
                    }
                    else{
                        _dateView = [self createViewWithY: 20*WidthRate Title:@"历史发布:" contentArray:_dateArr part:1];
                        [_bgScrollView addSubview:_dateView];
                    }
                }
                else if (arr.count >20){
                    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, 1.3*kScreenHeight);
                }
                else if (![_model.status isEqualToString:@"1"]&&![_model.status isEqualToString:@"0"]){
                    HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"无广告数据" buttonTitles:@"确定", nil];
                    [alert showInView:self.view completion:^(HYAlertView *alertView, NSInteger selectIndex) {
                        if (selectIndex == 0) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
                
            }
        }

     

     else if (status == -1){
         HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"登录超时" buttonTitles:@"确定", nil];
         [alert showInView:self.view completion:^(HYAlertView *alertView, NSInteger selectIndex) {
             LoginViewController * logVC = [[LoginViewController alloc]init];
             [self.navigationController pushViewController:logVC animated:YES];
         }];
     }
     else{
         NSString *mess = [result objectForKey:@"message"];
         [self errorMessages:mess];
     }
     }];
}
-(void)createUI{
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgScrollView.userInteractionEnabled = YES;
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    _bgScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgScrollView];
    _bgScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(releaseDetailTableViewHeaderRefresh)];
    _bgScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(releaseDetailTableViewFooterRefresh)];
    
    nowLab  = [[UILabel alloc]initWithFrame:CGRectMake(12, 20*WidthRate, 100, 30)];
    nowLab.textAlignment = NSTextAlignmentLeft;
    nowLab.font = [UIFont systemFontOfSize:18];
    nowLab.textColor = RGB(0.47, 0.47, 0.47);
    [_bgScrollView addSubview:nowLab];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12, nowLab.bottom + 10 * WidthRate, kScreenWidth-24, 65*WidthRate)];
    _bgView.hidden = YES;
    [_bgScrollView addSubview:_bgView];
    
    UILabel * review = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 60)/2, 15*WidthRate, 60, 20)];
    review.text = @"审核中";
    review.textColor =RGB(0.47, 0.47, 0.47);
    review.textAlignment = NSTextAlignmentCenter;
    review.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:review];
    
    UILabel * tipLab = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 280)/2, review.bottom + 15*WidthRate, 280, 20)];
    tipLab.text = @"正在审核，预计俩小时后审核通过";
    tipLab.textColor =RGB(0.47, 0.47, 0.47);
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:tipLab];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(12, nowLab.bottom + 10 * WidthRate, kScreenWidth-24, 135*WidthRate)];
    _showView.hidden = YES;
    [_bgScrollView addSubview:_showView];
    _relLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75*WidthRate, 35*WidthRate)];
    _relLab.text = @"正在发布:";
    _relLab.textColor = RGB(0.47, 0.47, 0.47);
    _relLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_relLab];
    _relLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_relLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _relLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_relLabNum];
    
    _playLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 160*WidthRate, 0, 85*WidthRate, 35*WidthRate)];
    _playLab.text = @"播放次数:";
    _playLab.textColor = RGB(0.47, 0.47, 0.47);
    _playLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_playLab];
    
    _playLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_playLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _playLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_playLabNum];
    
    
    _receLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _relLab.bottom + 15*WidthRate, 75*WidthRate, 35*WidthRate)];
    _receLab.text = @"领取人数:";
    _receLab.textColor = RGB(0.47, 0.47, 0.47);
    _receLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_receLab];
    _receLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_receLab.right + 3, _relLab.bottom + 15*WidthRate, 60*WidthRate, 35*WidthRate)];
    _receLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_receLabNum];
    _receBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _receBtn.frame = CGRectMake(_receLab.left, _receLabNum.origin.y+5*WidthRate, _receLab.width+_receLabNum.width+15, 25*WidthRate);
    [_receBtn setImage:[UIImage imageNamed:@"home_public_more"] forState:UIControlStateNormal];
    _receBtn.tag = 1000;
    _receBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -_receBtn.width+5);
    
    _receBtn.backgroundColor = [UIColor clearColor];
    [_receBtn addTarget:self action:@selector(WxListClick:) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_receBtn];
    _useLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 160*WidthRate, _relLab.bottom + 15*WidthRate, 75*WidthRate, 35*WidthRate)];
    _useLab.text = @"使用人数:";
    _useLab.textColor = RGB(0.47, 0.47, 0.47);
    _useLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_useLab];
    
    _useLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_useLab.right + 3, _relLab.bottom + 15*WidthRate, 70*WidthRate, 35*WidthRate)];
    _useLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_useLabNum];
    _useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _useBtn.frame = CGRectMake(_useLab.left, _useLabNum.origin.y+5*WidthRate, _useLab.width+_useLabNum.width+15, 25*WidthRate);
    [_useBtn setImage:[UIImage imageNamed:@"home_public_more"] forState:UIControlStateNormal];
    _useBtn.backgroundColor = [UIColor clearColor];
    _useBtn.tag = 2000;
    _useBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -_useBtn.width+5);
    [_useBtn addTarget:self action:@selector(WxListClick:) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_useBtn];
    
    _detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _detailBtn.frame = CGRectMake(40*WidthRate, _useLabNum.bottom + 10*WidthRate, (_showView.width-120*WidthRate)/2, 40*WidthRate);
    _detailBtn.layer.cornerRadius = 20*WidthRate;
    _detailBtn.layer.masksToBounds = YES;
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_detailBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_detailBtn];
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancleBtn.frame = CGRectMake(_showView.right-(_showView.width-120*WidthRate)/2-40*WidthRate, _useLabNum.bottom + 10*WidthRate, (_showView.width-120*WidthRate)/2, 40*WidthRate);
    _cancleBtn.layer.cornerRadius = 20*WidthRate;
    _cancleBtn.layer.masksToBounds = YES;
    [_cancleBtn setTitle:@"取消发布" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancleBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_cancleBtn];
    
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
    if (array.count >0){
        for (int i = 0 ; i< array.count ; i++ ){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((i%2)*((view.width-44)/2+20) + 12, titleLab.bottom + 15*WidthRate + (i/2)*(40*WidthRate +10), (view.width-44)/2, 40*WidthRate);
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5;
            btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            btn.layer.borderWidth = 0.5;
            btn.tag = 100*tag + i;
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
            HistoryModel * mol = array[i];
            if ([mol.type isEqualToString:@"0"]){
                [btn setTitle:[NSString stringWithFormat:@"%@ 中午 ",mol.time] forState:UIControlStateNormal];
            }else{
                [btn setTitle:[NSString stringWithFormat:@"%@ 晚上",mol.time] forState:UIControlStateNormal];
            }
            
            [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateSelected];
            [btn setTitleColor:RGB(0.44, 0.44, 0.44) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(touchDateClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            
        }
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
                hrVC.Model = _dateArr[i];
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
    rdVC.ads_id = _model.ads_id;
    [self.navigationController pushViewController:rdVC animated:YES];
}
-(void)cancleClick{
    HYAlertView *alert = [[HYAlertView alloc]initWithTitle:@"温馨提示" message:@"您确定要取消发布" buttonTitles:@"取消", @"确定",nil];
    [alert showWithCompletion:^(HYAlertView *alertView,NSInteger selectIndex){
        if (selectIndex == 1) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _pramerDic = [NSDictionary dictionary];
            NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
            _pramerDic = @{@"token":[use objectForKey:@"token"],@"ads_id":_model.ads_id};
            
            
            [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"POST" SubUrlString:KCancelAd RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
                hud.hidden = YES;
                int status = [[result objectForKey:@"status"] intValue];;
                if (status == 1) {
                    nowLab.hidden = YES;
                    _showView.hidden = YES;
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
                }
                else if (status == -1){
                    HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"登录超时" buttonTitles:@"确定", nil];
                    [alert showInView:self.view completion:^(HYAlertView *alertView, NSInteger selectIndex) {
                        LoginViewController * logVC = [[LoginViewController alloc]init];
                        [self.navigationController pushViewController:logVC animated:YES];            }];
                }
                else{
                    NSString *mess = [result objectForKey:@"message"];
                    [self errorMessages:mess];
                }
            }];
        }
    }];
}
-(void)WxListClick:(UIButton *)sender{
    WxUserListViewController * wulVC  = [[WxUserListViewController alloc]init];
    wulVC.hidesBottomBarWhenPushed = YES;
    wulVC.index = sender.tag/1000;
    wulVC.ads_id = _model.ads_id;
    [self.navigationController pushViewController:wulVC animated:YES];
}
-(void)releaseDetailTableViewHeaderRefresh{
    _pageID = 0;
    isRefresh = YES;
    
    [self getDataSoure];
}
-(void)releaseDetailTableViewFooterRefresh{
    _pageID =+10;
    isRefresh = NO;
    
    [self getDataSoure];
}
//刷新界面
- (void)RefreshHomeData{
    [self getDataSoure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
