//
//  ReleaseDetailViewController.m
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ReleaseDetailViewController.h"
#import "ReleaseDetailTableViewCell.h"
#import "ScreenDetailViewController.h"
#import "AdsListModel.h"
#import "LoginViewController.h"

static NSString * ReleaseDetailTableViewCellIdenfire = @"ReleaseDetailTableViewCell";
@interface ReleaseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataArray;
}
@property(nonatomic,assign)int pageID;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel * nowReleaseLab;
@property(nonatomic,strong)UILabel * releaseNumLab;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSDictionary *pramerDic;

@end

@implementation ReleaseDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageID = 1;
    self.navigationItem.title = @"发布详情";
    _dataArray = [NSMutableArray array];
    [self getDataSource];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)getDataSource{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"]};
    
    
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetAdsList RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            NSArray * arr = [result objectForKey:@"data"];
            
            for (int i = 0 ;i < arr.count ;i++){
                AdsListModel * model = [AdsListModel mj_objectWithKeyValues:arr[i]];
                [_dataArray addObject:model];
            }
            if (_dataArray.count > 0){
            _releaseNumLab.text = [NSString stringWithFormat:@"%d 屏",(int)[_dataArray count]];
            }else
            _releaseNumLab.text = @"0 屏";
            [_tableView reloadData];
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
-(void)createUI{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    _bgView.backgroundColor = RGB(0.97, 0.97, 0.97);
    _nowReleaseLab  = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 80, 30)];
    _nowReleaseLab.text = @"正在发布:";
    _nowReleaseLab.textColor = RGB(0.32, 0.32, 0.32);
    _nowReleaseLab.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_nowReleaseLab];
    _releaseNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_nowReleaseLab.right, 0, 40, 30)];
    _releaseNumLab.textColor = RGB(0.32, 0.32, 0.32);
    _releaseNumLab.text = [NSString stringWithFormat:@"%d 屏",(int)[_dataArray count]];
    _releaseNumLab.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_releaseNumLab];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _bgView.bottom, kScreenWidth, 0.5)];
    _lineView.backgroundColor = RGB(0.90, 0.90, 0.90);
    [_bgView addSubview:_lineView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[ReleaseDetailTableViewCell class] forCellReuseIdentifier:ReleaseDetailTableViewCellIdenfire];
    _tableView.tableHeaderView = _bgView;
    _tableView.rowHeight = 95;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(releaseDetailTableViewHeaderRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(releaseDetailTableViewFooterRefresh)];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReleaseDetailTableViewCell * releaseDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:ReleaseDetailTableViewCellIdenfire];
    AdsListModel * mol = _dataArray[indexPath.row];
    [releaseDetailTableViewCell.screenImg sd_setImageWithURL:[NSURL URLWithString:mol.logo] placeholderImage:[UIImage imageNamed:@"epu_loading_pic"]];
    releaseDetailTableViewCell.titleLab.text = mol.name;
    releaseDetailTableViewCell.playNumLab.text = [NSString stringWithFormat:@"%@次",mol.play_count];
    releaseDetailTableViewCell.receNumLab.text = [NSString stringWithFormat:@"%@次",mol.get_count];
    releaseDetailTableViewCell.toShopNumLab.text = [NSString stringWithFormat:@"%@次",mol.use_count];
    return releaseDetailTableViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScreenDetailViewController * sdVC = [[ScreenDetailViewController alloc]init];
    sdVC.hidesBottomBarWhenPushed = YES;
    sdVC.device_id = ((AdsListModel *)_dataArray[indexPath.row]).device_id;
    [self.navigationController pushViewController:sdVC animated:YES];
}
-(void)releaseDetailTableViewHeaderRefresh{
    _pageID = 1;
    [self getDataSource];
}
-(void)releaseDetailTableViewFooterRefresh{
    _pageID ++;
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
