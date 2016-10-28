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
//#import "LoginViewController.h"
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
    selectTab = 0;
    
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_select_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    //我的
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tabbar_mine_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_mine_select_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[homeNav,mineNav];
    
    [self addLoginBtn];
}

-(void)addLoginBtn{
   
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(kScreenWidth/5*4, 0, 320/5, 49);
    [self.loginBtn addTarget:self action:@selector(isLogin:) forControlEvents:UIControlEventTouchUpInside];
//    if ([kpassPortMemberStatusMemberIDStr isEqualToString:@""] || kpassPortMemberStatusMemberIDStr == nil) {
//        self.loginBtn.hidden = NO;
//    }else{
//        self.loginBtn.hidden = YES;
//    }
    [self.tabBar addSubview:self.loginBtn];
    
    
    self.instuBtns = [UIButton buttonWithType:UIButtonTypeCustom];
    self.instuBtns.frame = CGRectMake(kScreenWidth/5*3, 0, 320/5, 49);
    [self.instuBtns addTarget:self action:@selector(isLogin:) forControlEvents:UIControlEventTouchUpInside];
//    if ([kpassPortMemberStatusMemberIDStr isEqualToString:@""] || kpassPortMemberStatusMemberIDStr == nil) {
//        self.instuBtns.hidden = NO;
//    }else{
//        self.instuBtns.hidden = YES;
//    }
    [self.tabBar addSubview:self.instuBtns];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)isLogin:(UIButton *)sender{
//    if ([kpassPortMemberStatusMemberIDStr isEqualToString:@""] || kpassPortMemberStatusMemberIDStr == nil) {
//        LoginViewController *loginVc = [[LoginViewController alloc]init];
//        loginVc.delegate = self;
//        UINavigationController *loginNc = [[UINavigationController alloc]initWithRootViewController:loginVc];
//        [self presentViewController:loginNc animated:YES completion:nil];
//        if ([sender isEqual:self.instuBtns]) {
//            selectTab = 3;
//        }else{
//            selectTab = 4;
//        }
//    }else{
//        
//        
//        
//        
//        self.loginBtn.hidden = YES;
//        self.instuBtns.hidden = YES;
//    }
//    
    
    
    
    
}

//- (void)loginSuccessActionInfo
//{
//    self.loginBtn.hidden = YES;
//    self.instuBtns.hidden = YES;
//    self.selectedIndex = selectTab;
//}


@end
