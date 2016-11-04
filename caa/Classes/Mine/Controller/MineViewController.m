//
//  MineViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()
{
    NSArray *titleArr;
}
@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 40)];
    //设置
    statusBarView.backgroundColor = RGB(0.95, 0.39, 0.21);
    // 添加到 view 上
    [self.view addSubview:statusBarView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    titleArr = @[@"消息中心",@"意见反馈",@"帮助",@"软件升级"];
    [self createUI];
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _headBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210*WidthRate)];
    [self.view addSubview:_headBgView];
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 60*WidthRate)/2, 50 * WidthRate, 60*WidthRate, 60*WidthRate)];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 30*WidthRate;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImg"]] placeholderImage:[UIImage imageNamed:@"wo_upload_headphoto"]];
    [_headBgView addSubview:_headImg];
    _useNameLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, _headImg.bottom + 10*WidthRate, 200, 30)];
    _useNameLab.textAlignment = NSTextAlignmentCenter;
    _useNameLab.textColor = RGB(0.41, 0.41, 0.41);
    _useNameLab.text = [user objectForKey:@"nickname"];
    [_headBgView addSubview:_useNameLab];
    
    _mineReleaseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _mineReleaseBtn.frame = CGRectMake((kScreenWidth - 150)/2, _useNameLab.bottom + 10*WidthRate, 150, 40);
    [_mineReleaseBtn setTitle:@"我的发布" forState: UIControlStateNormal];
    [_mineReleaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mineReleaseBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _mineReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _mineReleaseBtn.layer.cornerRadius = 20;
    [_mineReleaseBtn addTarget:self action:@selector(mineReleaseClick) forControlEvents:UIControlEventTouchUpInside];
    [_headBgView addSubview:_mineReleaseBtn];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headBgView.bottom-0.5, kScreenWidth,0.5)];
    lineView.backgroundColor = RGB(0.84, 0.84, 0.84);
    [_headBgView addSubview:lineView];
    UIView * bgView =  [[UIView alloc]initWithFrame:CGRectMake(0, _headBgView.bottom, kScreenWidth, kScreenHeight-_headBgView.bottom-49)];
    bgView.backgroundColor = RGB(0.97, 0.97, 0.97);
    [self.view addSubview:bgView];

    
    _bgView  = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 40*titleArr.count)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:_bgView];
    
    
    for (int i = 0; i< titleArr.count;i++){
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, i*40, kScreenWidth,0.5)];
        lineView1.backgroundColor = RGB(0.84, 0.84, 0.84);
        [_bgView addSubview:lineView1];
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, lineView1.bottom, 80, 40)];
        titleLab.text = titleArr[i];
        titleLab.textColor = RGB(0.41, 0.41, 0.41);
        titleLab.font = [UIFont systemFontOfSize:18];
        [_bgView addSubview:titleLab];
        
        UIButton * _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(kScreenWidth - 15, 40*i+(40-14)/2, 6, 14);
        [_detailBtn setImage:[UIImage imageNamed:@"wo_more"] forState:UIControlStateNormal];
        [_bgView addSubview:_detailBtn];
        if (i == titleArr.count-1){
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, titleLab.bottom-0.5, kScreenWidth,0.5)];
        lineView2.backgroundColor = RGB(0.84, 0.84, 0.84);
        [_bgView addSubview:lineView2];
        }
    }
   UIView * View  = [[UIView alloc]initWithFrame:CGRectMake(0, _bgView.bottom+40, kScreenWidth, 40)];
    View.userInteractionEnabled = YES;
    View.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:View];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,0.5)];
    lineView1.backgroundColor = RGB(0.84, 0.84, 0.84);
    [View addSubview:lineView1];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, lineView1.bottom, kScreenWidth-24, 40)];
    titleLab.text = @"退出登录";
    titleLab.textColor = RGB(0.41, 0.41, 0.41);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:18];
    [View addSubview:titleLab];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, titleLab.bottom-0.5, kScreenWidth,0.5)];
    lineView2.backgroundColor = RGB(0.84, 0.84, 0.84);
    [View addSubview:lineView2];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutClick)];
    [View addGestureRecognizer:tapGes];
    
    

}
-(void)logoutClick{
    NSLog(@"dsflsld");
}
-(void)mineReleaseClick{
    
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
