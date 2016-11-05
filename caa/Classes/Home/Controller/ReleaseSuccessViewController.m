//
//  ReleaseSuccessViewController.m
//  caa
//
//  Created by xichao on 16/11/4.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ReleaseSuccessViewController.h"
#import "MineReleaseViewController.h"

@interface ReleaseSuccessViewController ()

@end

@implementation ReleaseSuccessViewController
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
    self.navigationItem.title = @"发布成功";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _successLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 150)/2, 100*WidthRate, 150, 50)];
    _successLab.text = @"发布成功!";
    _successLab.textAlignment= NSTextAlignmentCenter;
    _successLab.textColor = RGB(0.95, 0.39, 0.21);
    _successLab.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_successLab];
    
    _mineReleaseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _mineReleaseBtn.frame = CGRectMake(_successLab.left, _successLab.bottom + 90*WidthRate, 150, 40);
    [_mineReleaseBtn setTitle:@"我的发布" forState: UIControlStateNormal];
    [_mineReleaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mineReleaseBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _mineReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _mineReleaseBtn.layer.cornerRadius = 20;
    [_mineReleaseBtn addTarget:self action:@selector(mineReleaseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mineReleaseBtn];

    _tipLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, _mineReleaseBtn.bottom + 40, 200, 30)];
    _tipLab.textColor = RGB(0.41, 0.41, 0.41);
    _tipLab.textAlignment = NSTextAlignmentCenter;
    _tipLab.text=  @"正在提交，预计12：30审核通过";
    _tipLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_tipLab];
}
-(void)mineReleaseClick{
    MineReleaseViewController * mrVC = [[MineReleaseViewController alloc]init];
    mrVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mrVC animated:YES];
}
-(void)doBackWithBaseVC:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
