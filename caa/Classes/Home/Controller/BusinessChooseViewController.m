//
//  BusinessChooseViewController.m
//  caa
//
//  Created by xichao on 16/11/2.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BusinessChooseViewController.h"

@interface BusinessChooseViewController ()

@end

@implementation BusinessChooseViewController

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
    self.navigationItem.title = @"商圈选择";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    
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
