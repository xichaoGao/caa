//
//  BusinessChooseViewController.m
//  caa
//
//  Created by xichao on 16/11/2.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BusinessChooseViewController.h"
@interface BusinessChooseViewController ()

{
    NSMutableArray * _titleArr;
    NSMutableArray * _chooseCity;
    NSMutableArray * _hotCity;
    NSMutableArray * _hotUrban;
    NSMutableArray * _businessCircle;
}
@property (strong,nonatomic)UIButton * tmpBtn;

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
    _hotCity = [NSMutableArray arrayWithArray:@[@"北京",@"上海",@"广州"]];
    _hotUrban = [NSMutableArray arrayWithArray:@[@"朝阳区",@"海淀区",@"西城区"]];
    _businessCircle = [NSMutableArray arrayWithArray:@[@"望京SOHO",@"爱琴海",@"朝阳公园",@"银座"]];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    UIView * chooseCityView = [self createViewWithY:30*WidthRate Title:_titleArr contentArray:_chooseCity part:0];
    [self.view addSubview:chooseCityView];
    UIView * hotCityView = [self createViewWithY:chooseCityView.bottom+10 Title:_titleArr contentArray:_hotCity part:1];
    [self.view addSubview:hotCityView];
    UIView * hotUrbanView = [self createViewWithY:hotCityView.bottom+10 Title:_titleArr contentArray:_hotUrban part:2];
    
    [self.view addSubview:hotUrbanView];
    UIView * businessCircleView  = [self createViewWithY:hotUrbanView.bottom+10 Title:_titleArr contentArray:_businessCircle part:3];
    [self.view addSubview:businessCircleView];
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
                        NSLog(@"&&&&&&%ld",(long)sender.tag);

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
