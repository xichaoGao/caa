//
//  BusinessChooseViewController.m
//  caa
//
//  Created by xichao on 16/11/2.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BusinessChooseViewController.h"
#import "LoginViewController.h"
#import "CityModel.h"
#import "UrbanModel.h"
#import "BusinessCircleModel.h"
#import "DateAndEqViewController.h"
@interface BusinessChooseViewController ()

{
    UIView * _chooseCityView;
    UIView * _hotCityView;
    UIView * _hotUrbanView;
    UIView * _businessCircleView;
    NSString * _city;
    NSString * _urban;
    NSMutableArray * _titleArr;
    NSMutableArray * _chooseCity;
    NSMutableArray * _hotCity;
    NSMutableArray * _hotUrban;
    NSMutableArray * _businessCircle;
    NSMutableArray * _businessCireleID;
}
@property (strong,nonatomic)UIButton * tmpBtn;
@property(nonatomic,strong)NSDictionary *pramerDic;

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
    _titleArr = [NSMutableArray arrayWithArray: @[@"最近选择城市",@"热门城市",@"热门城区",@"商圈"]];
    _chooseCity =[NSMutableArray arrayWithArray:@[@"北京"]];
    _hotCity = [NSMutableArray arrayWithCapacity:1];
    _hotUrban = [NSMutableArray arrayWithCapacity:1];
    _businessCircle = [NSMutableArray arrayWithCapacity:1];
    _businessCireleID = [NSMutableArray arrayWithCapacity:1];
    [self getCityDatas];
    
    // Do any additional setup after loading the view.
}
//创建界面
-(void)createUI{
    _chooseCityView = [self createViewWithY:30*WidthRate Title:_titleArr contentArray:_chooseCity part:0];
    [self.view addSubview:_chooseCityView];
    _hotCityView = [self createViewWithY:_chooseCityView.bottom+10 Title:_titleArr contentArray:_hotCity part:1];
    [self.view addSubview:_hotCityView];
    
    
}
-(UIView *)createViewWithY:(CGFloat) y Title:(NSMutableArray *)title contentArray:(NSMutableArray *)array part :(NSInteger)tag{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, (((array.count-1)/3 +1) *50*WidthRate)+40*WidthRate)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 150, 30)];
    titleLab.text = title[tag];
    titleLab.textColor = RGB(0.30, 0.30, 0.30);
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    for (int i = 0 ; i< array.count ; i++ ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%3)*((view.width-48)/3+12) + 12, titleLab.bottom + 15*WidthRate + (i/3)*(40*WidthRate +10), (view.width-48)/3, 40*WidthRate);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 1000*(tag+1) + i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(0.44, 0.44, 0.44) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
    }
    return view;
}
//获取热门城市数据
-(void)getCityDatas{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"]};
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetCity RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        NSLog(@"loginResult==%@",result);
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            if([[result objectForKey:@"data"] count] > 0){
                NSArray * dataArr = [result objectForKey:@"data"];
                [_hotCity removeAllObjects];
                
                for (int i = 0 ; i<dataArr.count ; i++){
                    CityModel * cityModel  = [CityModel mj_objectWithKeyValues:[dataArr objectAtIndex:i]];
                    NSLog(@"%@",cityModel.city);
                    [_hotCity addObject:cityModel.city];
                    
                }
                [self createUI];
                
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
    }];
}
//所有按钮点击事件的集合
-(void)touchClick:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    sender.selected = !sender.selected;
    switch (sender.tag/1000) {
        case 1:
            for (int i = 0 ; i <_chooseCity.count;i++){
                if (sender.tag == 1000+i){
                    if (sender.selected == YES){
                        NSLog(@"&&&&&&%ld",(long)sender.tag);
                        sender.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                        
                        
                    }
                    else{
                        NSLog(@"$$$$$$$$$%ld",(long)sender.tag);
                        sender.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }else {
                    
                    UIButton * btn = (UIButton *)[self.view viewWithTag:1000+i];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                    else{
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }
            }
            break;
            
        case 2:
            for (int i = 0 ; i <_hotCity.count;i++){
                if (sender.tag == 2000+i){
                    if (sender.selected == YES){
                        [_businessCircleView removeFromSuperview];
                        [_hotUrbanView removeFromSuperview];
                        NSLog(@"&&&&&&%ld",(long)sender.tag);
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        _pramerDic = [NSDictionary dictionary];
                        
                        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
                        _pramerDic = @{@"token":[use objectForKey:@"token"],@"city":[_hotCity[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
                        NSLog(@"%@",[_hotCity[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
                        [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetUrban RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
                            hud.hidden = YES;
                            NSLog(@"loginResult==%@ ",result);
                            int status = [[result objectForKey:@"status"] intValue];;
                            if (status == 1) {
                                _city = _hotCity[i];
                                if([[result objectForKey:@"data"] count] > 0){
                                    NSArray * dataArr = [result objectForKey:@"data"];
                                    [_hotUrban removeAllObjects];
                                    for (int i = 0 ; i<dataArr.count ; i++){
                                        UrbanModel * urbanModel  = [UrbanModel mj_objectWithKeyValues:[dataArr objectAtIndex:i]];
                                        NSLog(@"%@",urbanModel.district);
                                        [_hotUrban addObject:urbanModel.district];
                                        
                                    }
                                    _hotUrbanView = [self createViewWithY:_hotCityView.bottom+10 Title:_titleArr contentArray:_hotUrban part:2];
                                    [self.view addSubview:_hotUrbanView];
                                    
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
                        }];
                        
                        sender.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                    }
                    else{
                        NSLog(@"$$$$$$$$$%ld",(long)sender.tag);
                        
                        sender.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }else {
                    
                    UIButton * btn = (UIButton *)[self.view viewWithTag:2000+i];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                    else{
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }
            }
            break;
        case 3:
            for (int i = 0 ; i <_hotUrban.count;i++){
                if (sender.tag == 3000+i){
                    if (sender.selected == YES){
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        _pramerDic = [NSDictionary dictionary];
                        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
                        _pramerDic = @{@"token":[use objectForKey:@"token"],@"city": [_city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ,@"district":[_hotUrban[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
                        NSLog(@"%@",_hotCity[i]);
                        [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetArea RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
                            hud.hidden = YES;
                            NSLog(@"loginResult==%@",result);
                            int status = [[result objectForKey:@"status"] intValue];;
                            if (status == 1) {
                                if([[result objectForKey:@"data"] count] > 0){
                                    NSArray * dataArr = [result objectForKey:@"data"];
                                    [_businessCircle removeAllObjects];
                                    for (int i = 0 ; i<dataArr.count ; i++){
                                        BusinessCircleModel * businessCircleModel  = [BusinessCircleModel mj_objectWithKeyValues:[dataArr objectAtIndex:i]];
                                        NSLog(@"%@",businessCircleModel.name);
                                        [_businessCircle addObject:businessCircleModel.name];
                                        [_businessCireleID addObject:businessCircleModel.area_id];
                                    }
                                    _businessCircleView  = [self createViewWithY:_hotUrbanView.bottom+10 Title:_titleArr contentArray:_businessCircle part:3];
                                    [self.view addSubview:_businessCircleView];
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
                                [_businessCircleView removeFromSuperview];
                            }
                        }];
                        sender.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                    }
                    else{
                        sender.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }else {
                    
                    UIButton * btn = (UIButton *)[self.view viewWithTag:3000+i];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                    else{
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }
            }
            break;
        case 4:
            for (int i = 0 ; i <_businessCircle.count;i++){
                if (sender.tag == 4000+i){
                    if (sender.selected == YES){
                        DateAndEqViewController * daeVC = [[DateAndEqViewController alloc]init];
                        daeVC.hidesBottomBarWhenPushed  = YES;
                        daeVC.area_id = _businessCireleID[i];
                        [self.navigationController pushViewController:daeVC animated:YES];
                        sender.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                    }
                    else{
                        sender.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }else {
                    
                    UIButton * btn = (UIButton *)[self.view viewWithTag:4000+i];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                    else{
                        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
                    }
                }
            }
            break;
        default:
            break;
    }
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
