//
//  HomeViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "HomeViewController.h"
#import "GraphicLeadViewController.h"
#import "PerAdMesViewController.h"
#import "AdDetailViewController.h"
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
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _leadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220*WidthRate)];
    _leadView.userInteractionEnabled = YES;
    [self.view addSubview:_leadView];
    _leadImg = [[UIImageView alloc]initWithFrame:_leadView.frame];
    [_leadImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"13@2x"]];
    _leadImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leadDetailTap)];
    [_leadImg addGestureRecognizer:tapGes];
    [_leadView addSubview:_leadImg];
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
    
    _relLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*WidthRate, 35*WidthRate)];
    _relLab.text = @"正在发布:";
    _relLab.textColor = RGB(0.47, 0.47, 0.47);
    _relLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_relLab];
    _relLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_relLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _relLabNum.text = @"100屏";
    _relLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_relLabNum];
    
    _playLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 140*WidthRate, 0, 80*WidthRate, 35*WidthRate)];
    _playLab.text = @"播放次数:";
    _playLab.textColor = RGB(0.47, 0.47, 0.47);
    _playLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_playLab];
    
    _playLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_playLab.right + 3, 0, 60*WidthRate, 35*WidthRate)];
    _playLabNum.text = @"100次";
    _playLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_playLabNum];
    
    
    _receLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _relLab.bottom + 15*WidthRate, 80*WidthRate, 35*WidthRate)];
    _receLab.text = @"领取人数:";
    _receLab.textColor = RGB(0.47, 0.47, 0.47);
    _receLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_receLab];
    _receLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_receLab.right + 3, _relLab.bottom + 15*WidthRate, 60*WidthRate, 35*WidthRate)];
    _receLabNum.text = @"100人";
    _receLabNum.textColor = RGB(0.96, 0.60, 0.51);
    [_showView addSubview:_receLabNum];
    
    _useLab = [[UILabel alloc]initWithFrame:CGRectMake(_showView.width - 140*WidthRate, _relLab.bottom + 15*WidthRate, 80*WidthRate, 35*WidthRate)];
    _useLab.text = @"使用人数:";
    _useLab.textColor = RGB(0.47, 0.47, 0.47);
    _useLab.font = [UIFont boldSystemFontOfSize:14];
    [_showView addSubview:_useLab];
    
    _useLabNum = [[UILabel alloc]initWithFrame:CGRectMake(_useLab.right + 3, _relLab.bottom + 15*WidthRate, 60*WidthRate, 35*WidthRate)];
    _useLabNum.text = @"100人";
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
-(void)leadDetailTap{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    
//    _pramerDic = [NSDictionary dictionary];
//    _pramerDic = @{@"cmd":@"skdlflk",@"msg":@"dslfjslkdjflksd",@"alias":[user valueForKey:@"userID"]};
//    [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:@"Test/testPush" RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
//        NSLog(@"loginResult==%@",result);
//        
//    }];
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
    AdDetailViewController * adVC = [[AdDetailViewController alloc]init];
    adVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adVC animated:YES];
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
