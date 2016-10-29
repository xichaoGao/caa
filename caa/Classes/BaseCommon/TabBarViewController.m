//
//  TabBarViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
@interface TabBarViewController ()
{
    
    int selectTab;
}



@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.backgroundColor = [UIColor blackColor];
    self.tabBar.tintColor = UIColorFromHex(0Xff5971);
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@""];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,0.5)];
    lineView.backgroundColor = RGB(170, 170, 170);
    [self.tabBar addSubview:lineView];
    
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_select_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    //我的
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tabbar_mine_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_mine_select_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[homeNav,mineNav];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
    
    
    





@end
