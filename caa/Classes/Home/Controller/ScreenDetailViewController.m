//
//  ScreenDetailViewController.m
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ScreenDetailViewController.h"
#import "AdsDetailModel.h"
#import "LoginViewController.h"
@interface ScreenDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * tagView;
    NSMutableArray * dataArr;
}
@property(nonatomic,strong)NSDictionary *pramerDic;

@end

@implementation ScreenDetailViewController
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
    self.navigationItem.title = @"屏幕详情";
    dataArr = [NSMutableArray arrayWithCapacity:1];
    [self createUI];
    [self getDataSource];
    // Do any additional setup after loading the view.
}
-(void)getDataSource{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"],@"device_id":_device_id};
    
    
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetAdsDet RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            _bgView.hidden = NO;
            AdsDetailModel * model = [AdsDetailModel mj_objectWithKeyValues:[result objectForKey:@"data"]];
            if ( ![model.photo isEqualToString:@""]){
                _faceImg.hidden = YES;
                _faceLab.hidden = YES;
                [_screenImg sd_setImageWithURL:[NSURL URLWithString:model.photo]];
            }else{
                _faceLab.hidden = NO;
                _faceImg.hidden = NO;
            }
            _titleLab.text = model.name;
            
            if ( model.tags.count > 0){
                tagView = [self createViewWithY:_bgView.bottom+10 Title:@"餐厅标签" contentArray:model.tags];
                _listLab.hidden = NO;
                _listLab.frame = CGRectMake(12, tagView.bottom + 10*WidthRate, 150, 25*WidthRate);
            }
            else{
                _listLab.hidden = NO;
                _listLab.frame = CGRectMake(12, _bgView.bottom + 10*WidthRate, 150, 25*WidthRate);
            }
            [self.view addSubview:tagView];
            
            dataArr  = model.playlist;
            if(dataArr.count >0){
                _listTableView.frame = CGRectMake(-5*WidthRate, _listLab.bottom + 10, kScreenWidth -24, 150);
                _listTableView.hidden = NO;
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
            NSString *mess = [result objectForKey:@"message"];
            [self errorMessages:mess];
        }
    }];
}

-(void)createUI{
    _screenImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth - 24, 160*WidthRate)];
    _screenImg.layer.masksToBounds = YES;
    _screenImg.layer.cornerRadius = 5;
    _screenImg.layer.borderColor = RGB(0.81, 0.81, 0.81).CGColor;
    _screenImg.layer.borderWidth = 1;
    [self.view addSubview:_screenImg];
    _faceImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_pic"]];
    _faceImg.frame = CGRectMake((_screenImg.width - 80*WidthRate)/2, (_screenImg.height - 80*WidthRate)/2-20*WidthRate, 80*WidthRate, 80*WidthRate);
    [_screenImg addSubview:_faceImg];
    
    _faceLab = [[UILabel alloc]initWithFrame:CGRectMake((_screenImg.width - 150*WidthRate)/2, _faceImg.bottom + 5, 150*WidthRate, 30*WidthRate)];
    _faceLab.text = @"正在努力加载中...";
    _faceLab.textColor = RGB(0.84, 0.84, 0.84);
    _faceLab.textAlignment = NSTextAlignmentCenter;
    _faceLab.font = [UIFont systemFontOfSize:16];
    [_screenImg addSubview:_faceLab];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _screenImg.bottom + 5, kScreenWidth, 25*WidthRate)];
    _bgView.hidden = YES;
    [self.view addSubview:_bgView];
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 150, 25*WidthRate)];
    _titleLab.textColor = RGB(0.96, 0.55, 0.40);
    _titleLab.font = [UIFont systemFontOfSize:20];
    [_bgView addSubview:_titleLab];
    _hotLab = [[UILabel alloc]initWithFrame:CGRectMake(_bgView.width - 120, 5, 40, 25*WidthRate)];
    _hotLab.text = @"热度:";
    _hotLab.textColor = RGB(0.41, 0.41, 0.41);
    _hotLab.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_hotLab];
    for (int i=0 ; i<3;i++){
        _heartImg = [[UIImageView alloc]initWithFrame:CGRectMake(_hotLab.right+5 + i*20, 10, 15, 15)];
        [_heartImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_detail_heat"]];
        [_bgView addSubview:_heartImg];
    }
    
    _listLab = [[UILabel alloc]init];
    _listLab.textColor = RGB(0.41, 0.41, 0.41);
    _listLab.text = @"正在播放广告列表";
    _listLab.font = [UIFont systemFontOfSize:18];
    _listLab.hidden = YES;
    [self.view addSubview:_listLab];
    _listTableView = [[UITableView alloc]init];
    _listTableView.delegate = self;
    _listTableView.rowHeight = 30;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _listTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_listTableView];
    _listTableView.hidden = YES;
}
-(UIView *)createViewWithY:(CGFloat) y Title:(NSString *)title contentArray:(NSMutableArray *)array{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, (((array.count-1)/4 +1) *50*WidthRate)+40*WidthRate)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 150, 30)];
    titleLab.text = title;
    titleLab.textColor = RGB(0.41, 0.41, 0.41);
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    for (int i = 0 ; i< array.count ; i++ ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%4)*((view.width-60)/4+12) + 12, titleLab.bottom + 15*WidthRate + (i/4)*(40*WidthRate +10), (view.width-60)/4, 40*WidthRate);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 1000 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateNormal];
        [view addSubview:btn];
        
    }
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellID";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    cell.textLabel.text = dataArr[indexPath.row][@"title"];
    cell.textLabel.textColor = RGB(0.41, 0.41, 0.41);
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
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
