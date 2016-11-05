//
//  HomeViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "GraphicLeadViewController.h"
#import "PerAdMesViewController.h"
#import "ReleaseDetailViewController.h"
#import "AdMsgModel.h"
@interface HomeViewController ()
@property(nonatomic,strong)NSDictionary *pramerDic;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:@"361770b96f9793d550ee6e62c1210e9f" forKey:@"token"];
    [self createUI];
    [self getHomeDatas];
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _leadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220*WidthRate)];
    _leadView.userInteractionEnabled = YES;
    [self.view addSubview:_leadView];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _leadView.bottom-0.5, _leadView.width, 0.5)];
    lineView.backgroundColor = RGB(0.84, 0.84, 0.84);
    [_leadView addSubview:lineView];
    _leadImg = [[UIImageView alloc]initWithFrame:_leadView.frame];
    _leadImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leadDetailTap)];
    [_leadImg addGestureRecognizer:tapGes];
    [_leadView addSubview:_leadImg];
    _faceImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_pic"]];
    _faceImg.frame = CGRectMake((_leadImg.width - 80*WidthRate)/2, (_leadImg.height - 80*WidthRate)/2-20*WidthRate, 80*WidthRate, 80*WidthRate);
    [_leadImg addSubview:_faceImg];
    
    _faceLab = [[UILabel alloc]initWithFrame:CGRectMake((_leadImg.width - 150*WidthRate)/2, _faceImg.bottom + 5, 150*WidthRate, 30*WidthRate)];
    _faceLab.text = @"加载中...";
    _faceLab.textColor = RGB(0.84, 0.84, 0.84);
    _faceLab.textAlignment = NSTextAlignmentCenter;
    _faceLab.font = [UIFont systemFontOfSize:20];
    [_leadImg addSubview:_faceLab];

    _adView = [[UIView alloc]initWithFrame:CGRectMake(12,_leadView.bottom+10 * WidthRate, kScreenWidth - 24, 160 * WidthRate)];
    _adView.layer.masksToBounds = YES;
    _adView.layer.cornerRadius = 10;
    _adView.layer.borderWidth = 1;
    _adView.layer.borderColor = RGB(0.95, 0.39, 0.21).CGColor;
    [self.view addSubview:_adView];
    UITapGestureRecognizer *tapGess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(relAdTap)];
    [_adView addGestureRecognizer:tapGess];
    
    _relImg = [[UIImageView alloc]initWithFrame:CGRectMake((_adView.width - 180*WidthRate)/2,( _adView.height - 40*WidthRate)/2, 35*WidthRate, 35*WidthRate)];
    _relImg.image = [UIImage imageNamed:@"home_advertising"];
    [_adView addSubview:_relImg];
    _relAdLab = [[UILabel alloc]initWithFrame:CGRectMake(_relImg.right + 15*WidthRate, ( _adView.height - 57*WidthRate)/2, 150*WidthRate, 50*WidthRate)];
    _relAdLab.text = @"发布广告";
    _relAdLab.textColor = RGB(0.95, 0.39, 0.21);
    _relAdLab.font = [UIFont boldSystemFontOfSize:30];
    [_adView addSubview:_relAdLab];
    
    _showView = [[UIView alloc]initWithFrame:CGRectMake(20, _adView.bottom + 30 * WidthRate, kScreenWidth-40*WidthRate, 85*WidthRate)];
    [self.view addSubview:_showView];
    _showView.hidden = YES;
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
    _detailBtn.frame = CGRectMake(40*WidthRate, kScreenHeight-49-80*WidthRate, kScreenWidth-80*WidthRate, 50*WidthRate);
    _detailBtn.layer.cornerRadius = 20*WidthRate;
    _detailBtn.layer.masksToBounds = YES;
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_detailBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_detailBtn];

    
}
-(void)getHomeDatas{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"]};
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
-(void)leadDetailTap{

    GraphicLeadViewController * logVC = [[GraphicLeadViewController alloc]init];
    logVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:logVC animated:YES];
}
-(void)relAdTap{
    PerAdMesViewController * paVC = [[PerAdMesViewController alloc]init];
    paVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:paVC animated:YES];
}
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
