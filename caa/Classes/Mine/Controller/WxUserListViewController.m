//
//  WxUserListViewController.m
//  caa
//
//  Created by xichao on 16/11/26.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "WxUserListViewController.h"
#import "LoginViewController.h"
#import "WxUserModel.h"
#import "WxUserTableViewCell.h"
#import "NSDate+extend.h"
static NSString * WxUserTableViewCellIdenfire = @"WxUserTableViewCell";

@interface WxUserListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataArr;//所有数据
    NSArray * sortReceTimeArr;//已领取排序的时间戳
    NSMutableArray * receTimeArr;//时间戳
    NSMutableArray * receTimeDataArr;//已过期的数据
    NSArray * sortTimeArr;//排序后的时间戳
    NSMutableArray * timeArr;//时间戳
    NSMutableArray * useDataArr;//已使用的数据
    NSArray * sortBeyTimeArr;//排序后的时间戳
    NSMutableArray * beyTimeArr;//时间戳
    NSMutableArray * beyTimeDataArr;//已过期的数据
    BOOL isRefresh;
    NSInteger _pageID;
    NSInteger _num;
}
@property(nonatomic,strong)NSDictionary *pramerDic;
@property(nonatomic,strong)UITableView * listTableView;//广告标题列表


@end

@implementation WxUserListViewController
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
    _pageID = 0;
    _num = 0;
    self.navigationItem.title = @"领取使用情况";
    dataArr = [NSMutableArray arrayWithCapacity:1];
    receTimeArr = [NSMutableArray arrayWithCapacity:1];
    sortReceTimeArr = [NSArray array];
    receTimeDataArr = [NSMutableArray arrayWithCapacity:1];
    
    timeArr = [NSMutableArray arrayWithCapacity:1];
    sortTimeArr = [NSArray array];
    useDataArr = [NSMutableArray arrayWithCapacity:1];
    
    beyTimeArr = [NSMutableArray arrayWithCapacity:1];
    sortBeyTimeArr = [NSArray array];
    beyTimeDataArr = [NSMutableArray arrayWithCapacity:1];
    [self createUI];
    [self getDataSource];
    
    // Do any additional setup after loading the view.
}
-(void)getDataSource{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"],@"ads_id":_ads_id,@"from":[NSString stringWithFormat:@"%ld",_pageID]};
    
    
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetWxUser RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            if (isRefresh){
                [_listTableView.mj_header endRefreshing];
                [dataArr removeAllObjects];
            }else
                [_listTableView.mj_footer endRefreshing];
            NSArray * arr = [result objectForKey:@"data"];
            for (int i= 0; i < arr.count;i++){
                WxUserModel * model = [WxUserModel mj_objectWithKeyValues:arr[i]];
                [dataArr addObject:model];
            }
            if(dataArr.count >0){
                [_listTableView reloadData];
            }
        }
        else if (status == -1){
            HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"登录超时" buttonTitles:@"确定", nil];
            [alert showInView:self.view completion:^(HYAlertView *alertView, NSInteger selectIndex) {
                LoginViewController * logVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:logVC animated:YES];            }];
        }
        else{
            [_listTableView.mj_header endRefreshing];
            [_listTableView.mj_footer endRefreshing];
            NSString *mess = [result objectForKey:@"message"];
            [self errorMessages:mess];
        }
    }];
}

-(void)createUI{
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.rowHeight = 80;
    _listTableView.tableHeaderView.height = 40*WidthRate;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _listTableView.backgroundColor = [UIColor clearColor];
    [_listTableView registerClass:[WxUserTableViewCell class] forCellReuseIdentifier:WxUserTableViewCellIdenfire];
    [self.view addSubview:_listTableView];
    _listTableView.tableHeaderView = [self createtableViewHead];
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(releaseDetailTableViewHeaderRefresh)];
    _listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(releaseDetailTableViewFooterRefresh)];
}
#pragma mark - 创建reatetableViewHead
- (UIView *)createtableViewHead{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*WidthRate)];
    NSArray * titleArr = [NSArray arrayWithObjects:@"已领取",@"已使用",@"已过期", nil];
    for (int i = 0 ; i< titleArr.count ; i++ ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 40*WidthRate-0.5);
        btn.tag = 1000 + i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(0.44, 0.44, 0.44) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchClick:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn];
        if (i+1 == _index){
            btn.selected = !btn.selected;
        }
        UIView * heighView = [[UIView alloc]initWithFrame:CGRectMake(btn.right, 0, 0.5, btn.height)];
        heighView.backgroundColor = RGB(0.44, 0.44, 0.44);
        [headView addSubview:heighView];
    }
    UIView *Line1 = [[UIView alloc]initWithFrame:CGRectMake(0, headView.bottom -0.5, kScreenWidth, 0.5)];
    Line1.backgroundColor = RGB(0.44, 0.44, 0.44);
    [headView addSubview:Line1];
    
    
    return headView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _num = 0;
    [receTimeDataArr removeAllObjects];
    [receTimeArr removeAllObjects];
    [useDataArr removeAllObjects];
    [timeArr removeAllObjects];
    [beyTimeDataArr removeAllObjects];
    [beyTimeArr removeAllObjects];
    for (int i= 0 ;i < dataArr.count;i++){
        WxUserModel * mol = dataArr[i];
        if (_index == 1){
            if (![mol.status isEqualToString:[NSString stringWithFormat:@"%d",2]]){
                [receTimeArr addObject:[NSString stringWithFormat:@"%ld",mol.use_time]];
                sortReceTimeArr = [receTimeArr sortedArrayUsingSelector:@selector(compare:)];
                [receTimeDataArr addObject:mol];
                _num ++;
            }
        }else if (_index == 2){
            if ([mol.status isEqualToString:[NSString stringWithFormat:@"%ld",_index-1]]){
                [timeArr addObject:[NSString stringWithFormat:@"%ld",mol.use_time]];
                sortTimeArr = [timeArr sortedArrayUsingSelector:@selector(compare:)];
                [useDataArr addObject:mol];
                _num ++;
            }
        }
        else{
            if ([mol.status isEqualToString:[NSString stringWithFormat:@"%d",2]]){
                [beyTimeArr addObject:[NSString stringWithFormat:@"%ld",mol.use_time]];
                sortBeyTimeArr = [timeArr sortedArrayUsingSelector:@selector(compare:)];
                [beyTimeDataArr addObject:mol];
                _num ++;
            }
        }
        
    }
    return _num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WxUserTableViewCell * wxUserTableViewCell = [tableView dequeueReusableCellWithIdentifier:WxUserTableViewCellIdenfire];
   
    if(_index == 1){
        if (receTimeDataArr.count >0){
            for (int i = 0 ;i < receTimeDataArr.count ;i++){
                WxUserModel * useMol = receTimeDataArr[i];
                if ([sortReceTimeArr[indexPath.row] intValue] == useMol.use_time){
                    [wxUserTableViewCell.WxImg sd_setImageWithURL:[NSURL URLWithString:useMol.headimgurl] placeholderImage:[UIImage imageNamed:@"epu_loading_pic"]];
                    wxUserTableViewCell.nickNameLab.text = useMol.nickname;
                    wxUserTableViewCell.receTimeLab.text = [NSDate stringWithTimestamp:useMol.create_time format:@"yyyy-MM-dd hh:mm:ss"];
                    wxUserTableViewCell.useTimeLab.text = [NSDate stringWithTimestamp:useMol.use_time format:@"yyyy-MM-dd hh:mm:ss"];
                }
            }
        }
    }
    else if (_index == 2){
        if (useDataArr.count >0){
            for (int i = 0 ;i < useDataArr.count ;i++){
                WxUserModel * useMol = useDataArr[i];
                if ([sortTimeArr[indexPath.row] intValue] == useMol.use_time){
                    [wxUserTableViewCell.WxImg sd_setImageWithURL:[NSURL URLWithString:useMol.headimgurl] placeholderImage:[UIImage imageNamed:@"epu_loading_pic"]];
                    wxUserTableViewCell.nickNameLab.text = useMol.nickname;
                    wxUserTableViewCell.receTimeLab.text = [NSDate stringWithTimestamp:useMol.create_time format:@"yyyy-MM-dd hh:mm:ss"];
                    wxUserTableViewCell.useTimeLab.text = [NSDate stringWithTimestamp:useMol.use_time format:@"yyyy-MM-dd hh:mm:ss"];
                }
            }
        }
    }
    else{
        if (beyTimeDataArr.count >0){
            for (int i = 0 ;i < beyTimeDataArr.count ;i++){
                WxUserModel * useMol = beyTimeDataArr[i];
                if ([sortBeyTimeArr[indexPath.row] intValue] == useMol.use_time){
                    [wxUserTableViewCell.WxImg sd_setImageWithURL:[NSURL URLWithString:useMol.headimgurl] placeholderImage:[UIImage imageNamed:@"epu_loading_pic"]];
                    wxUserTableViewCell.nickNameLab.text = useMol.nickname;
                    wxUserTableViewCell.receTimeLab.text = [NSDate stringWithTimestamp:useMol.create_time format:@"yyyy-MM-dd hh:mm:ss"];
                    wxUserTableViewCell.useTimeLab.text = [NSDate stringWithTimestamp:useMol.use_time format:@"yyyy-MM-dd hh:mm:ss"];
                }
            }
        }
    }
    
    
    
    return wxUserTableViewCell;
}
-(void)touchClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    
    for (int i = 0 ; i <3;i++){
        if (sender.tag == 1000+i){
            if (sender.selected == YES){
                _index = i+1;
                [_listTableView reloadData];
            }
            
        }else {
            
            UIButton * btn = (UIButton *)[self.view viewWithTag:1000+i];
            if (btn.selected == YES){
                btn.selected = !btn.selected;
            }
            
        }
    }
    
}
-(void)releaseDetailTableViewHeaderRefresh{
    _pageID = 0;
    isRefresh = YES;
    [self getDataSource];
}
-(void)releaseDetailTableViewFooterRefresh{
    _pageID =+15;
    isRefresh = NO;
    [self getDataSource];
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
