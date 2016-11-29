//
//  HistoryReleaseViewController.m
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "HistoryReleaseViewController.h"
#import "ReleaseDetailViewController.h"
#import "AdMsgModel.h"
#import "LoginViewController.h"
#import "WxUserListViewController.h"

@interface HistoryReleaseViewController ()
@property(nonatomic,strong)NSDictionary *pramerDic;

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
    [self getDataSoure];
    // Do any additional setup after loading the view.
}
-(void)getDataSoure{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"],@"ads_id":_Model.ads_id};
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KAdsMsg RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        NSLog(@"loginResult==%@",result);
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            if([[result objectForKey:@"data"] count] > 0){
                _showView.hidden = NO;
            }
            AdMsgModel *adMsgModel = [AdMsgModel  mj_objectWithKeyValues:[result  objectForKey:@"data"]];
            _relLabNum.text = [NSString stringWithFormat:@"%@ 屏",adMsgModel.device_count];
            _playLabNum.text = [NSString stringWithFormat:@"%@ 次",adMsgModel.play_count];
            _receLabNum.text = [NSString stringWithFormat:@"%@ 人",adMsgModel.get_count];
            _useLabNum.text = [NSString stringWithFormat:@"%@ 人",adMsgModel.use_count];
            if ([adMsgModel.get_count isEqualToString:@"0"]){
                _receBtn.enabled = NO;
            }else{
                _receBtn.enabled = YES;
                
            }
            if ([adMsgModel.use_count isEqualToString:@"0"]){
                _useBtn.enabled = NO;
            }else{
                _useBtn.enabled = YES;
                
            }
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
    }];}
-(void)createUI{
    UILabel * nowLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 300)/2, 20*WidthRate, 300, 30)];
    nowLab.textAlignment = NSTextAlignmentCenter;
    nowLab.font = [UIFont systemFontOfSize:18];
    nowLab.textColor = RGB(0.47, 0.47, 0.47);
    [self.view addSubview:nowLab];
    if ([_Model.status isEqualToString:@"2"]){
        if ([_Model.type isEqualToString:@"0"]){
            nowLab.text = [NSString stringWithFormat:@"%@ 中午(已结束)",_Model.time];
        }else
            nowLab.text = [NSString stringWithFormat:@"%@ 晚上(已结束)",_Model.time];
        nowLab.textColor = RGB(0.96, 0.60, 0.51);
    }
    else if([_Model.status isEqualToString:@"3"]){
                _detailBtn.enabled = NO;
        if ([_Model.type isEqualToString:@"0"]){
            nowLab.text = [NSString stringWithFormat:@"%@ 中午(已拒绝)",_Model.time];
        }else
            nowLab.text = [NSString stringWithFormat:@"%@ 晚上(已拒绝)",_Model.time];
        nowLab.textColor = [UIColor redColor];
        
        
    }
    else{
        if ([_Model.type isEqualToString:@"0"]){
            nowLab.text = [NSString stringWithFormat:@"%@ 中午(已取消)",_Model.time];
        }else
            nowLab.text = [NSString stringWithFormat:@"%@ 晚上(已取消)",_Model.time];
        nowLab.textColor = [UIColor grayColor];
        
    }
    _showView = [[UIView alloc]initWithFrame:CGRectMake(12, nowLab.bottom + 10 * WidthRate, kScreenWidth-24, 190*WidthRate)];
    _showView.userInteractionEnabled = YES;
    [self.view addSubview:_showView];
    _relLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75*WidthRate, 35*WidthRate)];
    _relLab.text = @"正在发布:";
    _relLab.textColor = RGB(0.47, 0.47, 0.47);
    _relLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_relLab];
    _relLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_relLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _relLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_relLabNum];
    
    _playLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 160*WidthRate, 0, 75*WidthRate, 35*WidthRate)];
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
    
    _useLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_useLab.right + 3, _relLab.bottom + 15*WidthRate, 60*WidthRate, 35*WidthRate)];
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
    
    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _detailBtn.frame = CGRectMake(40*WidthRate-12, nowLab.bottom+85 + 10*WidthRate, kScreenWidth-80*WidthRate, 40*WidthRate);
    _detailBtn.layer.cornerRadius = 20*WidthRate;
    _detailBtn.layer.masksToBounds = YES;
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_detailBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    [_detailBtn addTarget:self action:@selector(DetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [_showView addSubview:_detailBtn];
    
}
-(void)WxListClick:(UIButton *)sender{
    WxUserListViewController * wulVC  = [[WxUserListViewController alloc]init];
    wulVC.hidesBottomBarWhenPushed = YES;
    wulVC.index = sender.tag/1000;
    wulVC.ads_id = _Model.ads_id;
    [self.navigationController pushViewController:wulVC animated:YES];
}
//详情事件
-(void)DetailClick:(UIButton * )sender{
    ReleaseDetailViewController * rdVC = [[ReleaseDetailViewController alloc]init];
    rdVC.hidesBottomBarWhenPushed = YES;
    rdVC.ads_id = _Model.ads_id;
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
