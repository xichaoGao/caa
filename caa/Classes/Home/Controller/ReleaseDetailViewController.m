//
//  ReleaseDetailViewController.m
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ReleaseDetailViewController.h"
#import "ReleaseDetailTableViewCell.h"
static NSString * ReleaseDetailTableViewCellIdenfire = @"ReleaseDetailTableViewCell";
@interface ReleaseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataArray;
}
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel * nowReleaseLab;
@property(nonatomic,strong)UILabel * releaseNumLab;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UITableView * tableView;
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
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布详情";
    _dataArray = [NSMutableArray array];
    [self createUI];
    // Do any additional setup after loading the view.
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
    _releaseNumLab.text = @"10屏";
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
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReleaseDetailTableViewCell * releaseDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:ReleaseDetailTableViewCellIdenfire];
    [releaseDetailTableViewCell.screenImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_addmotion"]];
    releaseDetailTableViewCell.titleLab.text = @"老师的空间福";
    releaseDetailTableViewCell.playNumLab.text = [NSString stringWithFormat:@"%d次",25];
    releaseDetailTableViewCell.receNumLab.text = [NSString stringWithFormat:@"%d次",25];
    releaseDetailTableViewCell.toShopNumLab.text = [NSString stringWithFormat:@"%d次",25];
    return releaseDetailTableViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"slfklajdsfja");
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
