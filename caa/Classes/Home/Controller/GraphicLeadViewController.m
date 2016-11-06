//
//  GraphicLeadViewController.m
//  caa
//
//  Created by xichao on 16/11/1.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "GraphicLeadViewController.h"

@interface GraphicLeadViewController ()<UIWebViewDelegate>

@end

@implementation GraphicLeadViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图文操作指引";
    // Do any additional setup after loading the view.
}
#pragma mark - initWebView
-(void)createWebView{
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    webView.backgroundColor = kBackgroundColor;
    [self.view addSubview:webView];
    webView.delegate = self;
    NSURL* url;
    url = [NSURL URLWithString:@""];//创建URL
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [webView loadRequest:request];//加载
    
    [self showMBProgressView];
}
#pragma mark - UIwebView delegare
-(void)webViewDidStartLoad:(UIWebView*)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [self hiddenMBProgressView];
}
-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    [self hiddenMBProgressView];
    HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"加载失败" buttonTitles:@"确定", nil];
    [alert showInView:self.view completion:nil];
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
