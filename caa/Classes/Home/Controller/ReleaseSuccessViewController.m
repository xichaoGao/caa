//
//  ReleaseSuccessViewController.m
//  caa
//
//  Created by xichao on 16/11/4.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ReleaseSuccessViewController.h"

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
    // Do any additional setup after loading the view.
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
