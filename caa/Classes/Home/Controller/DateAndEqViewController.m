//
//  DateAndEqViewController.m
//  caa
//
//  Created by xichao on 16/11/4.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "DateAndEqViewController.h"
#import "JSONKit.h"
#import "DateModel.h"
#import "EqModel.h"
#import "LoginViewController.h"
#import "ReleaseSuccessViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface DateAndEqViewController ()
{
    UIButton * allBtn;
    UIView *_dateView;
    UIView *_eqView;
    NSMutableArray *_dateArr;
    NSMutableArray *_eqArr;
    NSMutableDictionary * _releaseDic;
    UIView * _grayView;
    UIImageView * _selectedImg;
    NSMutableArray *_defaultArr;
    
    
}
@property(nonatomic,strong)NSMutableArray *idArr;
@property(nonatomic,strong)NSMutableArray *listArr;
@property(nonatomic,strong)NSDictionary *pramerDic;
@property(nonatomic,assign)int num;
@property(nonatomic,assign)int addNum;
@property(nonatomic,assign)int  totalNum;
@property(nonatomic,assign)int  defalutTag;

@end

@implementation DateAndEqViewController
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
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    for ( int i=0; i<6; i++) {
        [u setObject:@[] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    self.navigationItem.title = @"日期和设备选择";
    _listArr = [NSMutableArray arrayWithCapacity:1];
    _idArr = [NSMutableArray arrayWithCapacity:1];
    _defaultArr = [NSMutableArray arrayWithCapacity:1];
    _eqArr = [NSMutableArray arrayWithCapacity:1];
    _dateArr= [NSMutableArray arrayWithCapacity:1];
    [self getDateDatas];
    
    // Do any additional setup after loading the view.
}
//获取日期数据
-(void)getDateDatas{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"]};
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetTime RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        NSLog(@"loginResult==%@",result);
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            if([[result objectForKey:@"data"] count] > 0){
                NSArray * dataArr = [result objectForKey:@"data"];
                [_dateArr removeAllObjects];
                for (int i = 0 ; i<dataArr.count ; i++){
                    DateModel * dateModel  = [DateModel mj_objectWithKeyValues:[dataArr objectAtIndex:i]];
                    NSLog(@"%@",dateModel.date);
                    [_dateArr addObject:dateModel];
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
//创建日期按钮界面
-(void)createUI{
    _dateView = [self createViewWithY:30*WidthRate Title:@"选择时间" contentArray:_dateArr part:1];
    [self.view addSubview:_dateView];
    _totalLab = [[UILabel alloc]initWithFrame:CGRectMake(12, kScreenHeight - 120, 60, 20)];
    _totalLab.textColor = RGB(0.30, 0.30, 0.30);
    _totalLab.text = @"总计:";
    _totalLab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_totalLab];
    _totalNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_totalLab.right , _totalLab.top, 100, 20)];
    _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
    _totalNumLab.font = [UIFont boldSystemFontOfSize:20];
    _totalNumLab.textColor = RGB(0.30, 0.30, 0.30);
    [self.view addSubview:_totalNumLab];
    _releaseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _releaseBtn.frame = CGRectMake(kScreenWidth-112, _totalLab.top-10, 100, 40*WidthRate);
    [_releaseBtn setTitle:@"发布" forState: UIControlStateNormal];
    [_releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _releaseBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _releaseBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _releaseBtn.layer.cornerRadius = 20*WidthRate;
    [_releaseBtn addTarget:self action:@selector(ReleaseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_releaseBtn];
}
-(UIView *)createViewWithY:(CGFloat) y Title:(NSString *)title contentArray:(NSMutableArray *)array part :(NSInteger)tag{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, (((array.count-1)/2 +1) *50*WidthRate)+40*WidthRate)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 150, 30)];
    titleLab.text = title;
    titleLab.textColor = RGB(0.30, 0.30, 0.30);
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    for (int i = 0 ; i< array.count ; i++ ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%2)*((view.width-44)/2+20) + 12, titleLab.bottom + 15*WidthRate + (i/2)*(40*WidthRate +10), (view.width-44)/2, 40*WidthRate);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 100*tag + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        DateModel * da = array[i];
        NSString * title;
        if (da.type == 0){
            title = [NSString stringWithFormat:@"%@ 中午",da.date];
        }else
            title = [NSString stringWithFormat:@"%@ 晚上",da.date];
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:RGB(0.96, 0.55, 0.40) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(0.44, 0.44, 0.44) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchDateClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
    }
    return view;
}
-(UIView *)createViewWithH:(CGFloat) y Title:(NSString *)title contentArray:(NSMutableArray *)array part :(NSInteger)tag{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, (((array.count-1)/4 +1) *(kScreenWidth-65)/4)+40*WidthRate +20)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 150, 30)];
    titleLab.text = title;
    titleLab.textColor = RGB(0.30, 0.30, 0.30);
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    UILabel * allSelectLab = [[UILabel alloc]initWithFrame:CGRectMake(view.width - 12-40, titleLab.top, 40, 25)];
    allSelectLab.text = @"全选";
    allSelectLab.textAlignment  = NSTextAlignmentRight;
    allSelectLab.textColor = RGB(0.30, 0.30, 0.30);
    allSelectLab.font = [UIFont systemFontOfSize:17];
    [view addSubview:allSelectLab];
    allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(allSelectLab.left-20, allSelectLab.top+4, 17*WidthRate, 17*WidthRate);
    allBtn.layer.masksToBounds = YES;
    allBtn.layer.borderColor = RGB(0.30, 0.30, 0.30).CGColor;
    allBtn.layer.borderWidth = 1;
    allBtn.tag = 100000;
    [allBtn setImage:[UIImage imageNamed:@"home_all_tick"] forState:UIControlStateSelected];
    [allBtn addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:allBtn];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    _idArr = [user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]];
    for (int i = 0 ; i< array.count ; i++ ){
        EqModel * mol = (EqModel *)array[i];
        UIButton * screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        screenBtn.frame = CGRectMake((i%4)*((view.width-65)/4+12) + 12, titleLab.bottom + 15*WidthRate + (i/4)*((view.width-65)/4 +30), (view.width-65)/4, (view.width-65)/4);
        screenBtn.layer.masksToBounds = YES;
        screenBtn.layer.cornerRadius = 8;
        screenBtn.tag = i+10000;
        screenBtn.userInteractionEnabled = YES;
        screenBtn.adjustsImageWhenHighlighted = NO;
        [screenBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mol.logo]]] forState:UIControlStateNormal];
        screenBtn.backgroundColor = [UIColor whiteColor];
        [screenBtn setImage:nil forState:UIControlStateHighlighted];
        [screenBtn addTarget:self action:@selector(screenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:screenBtn];
        _grayView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenBtn.width, screenBtn.height)];
        _grayView.layer.cornerRadius = 8;
        _grayView.layer.borderColor = RGB(1, 1, 1).CGColor;
        _grayView.layer.borderWidth = 0.2;
        _grayView.backgroundColor = RGB(1, 1, 1);
        _grayView.userInteractionEnabled = YES;
        _grayView.alpha = 0.8;
        _grayView.tag = 1000*tag+ i;
        [screenBtn addSubview:_grayView];
        
        _selectedImg= [[UIImageView alloc]initWithFrame:CGRectMake((screenBtn.width-20)/2, (screenBtn.width-20)/2, 20, 20)];
        _selectedImg.tag = 1000*(tag+1)+ i;
        _selectedImg.userInteractionEnabled  = YES;
        [_selectedImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_select_tick"]];
        [screenBtn addSubview:_selectedImg];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uncheckTap:)];
        [_selectedImg addGestureRecognizer:tapGes];
        
        UILabel * screenTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(screenBtn.left, screenBtn.bottom+5, screenBtn.width, 20)];
        screenTitleLab.textAlignment = NSTextAlignmentCenter;
        screenTitleLab.textColor = RGB(0.30, 0.30, 0.30);
        screenTitleLab.font = [UIFont systemFontOfSize:9];
        [view addSubview:screenTitleLab];
        _selectedImg.hidden = YES;
        _grayView.hidden = YES;
        
        if ([mol.max_ads isEqualToString:mol.current_ads]){
            screenBtn.enabled = NO;
            _grayView.hidden = NO;
            screenTitleLab.text = [NSString stringWithFormat:@"%@(满)",mol.name];
        }else{
            _num++;
            screenBtn.enabled = YES;
            _grayView.hidden = YES;
            screenTitleLab.text = mol.name;
        }
        if ([[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]] isKindOfClass:[NSString class]]){
            _selectedImg.hidden = YES;
            _grayView.hidden = YES;
        }
        else {
            if (_idArr.count > 0){
                _addNum = (int)_idArr.count;
                for (int j = 0;j<_idArr.count;j++){
                    
                    if (_idArr[j] == mol.device_id){
                        _selectedImg.hidden = NO;
                        _grayView.hidden = NO;
                    }
                }
            }else
                _addNum = 0;
            
        }
    }
    if ([[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]] isKindOfClass:[NSArray class]]){
        NSMutableArray * arr = [NSMutableArray arrayWithArray:[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
        if (arr.count == _num){
            if (allBtn.selected == YES){
                
            }else
                allBtn.selected = !allBtn.selected;
        }
    }
    return view;
}
//日期按钮点击事件
-(void)touchDateClick:(UIButton*)sender{
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    [_eqView removeFromSuperview];
    sender.selected = !sender.selected;
    for (int i = 0 ; i <_dateArr.count;i++){
        if (sender.tag == 100+i){
            if (sender.selected == YES){
                _num = 0;
                _addNum = 0;
                sender.layer.borderColor = RGB(0.96, 0.55, 0.40).CGColor;
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _pramerDic = [NSDictionary dictionary];
                DateModel * mol = (DateModel *)_dateArr[i];
                _defalutTag = i;
                _pramerDic = @{@"token":[use objectForKey:@"token"],@"area_id":_area_id,@"timestamp":[NSString stringWithFormat:@"%d",mol.timestamp],@"type":[NSString stringWithFormat:@"%d",mol.type]};
                [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"GET" SubUrlString:KGetEq RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
                    hud.hidden = YES;
                    NSLog(@"loginResult==%@",result);
                    int status = [[result objectForKey:@"status"] intValue];;
                    if (status == 1) {
                        if([[result objectForKey:@"data"] count] > 0){
                            NSArray * dataArr = [result objectForKey:@"data"];
                            [_eqArr removeAllObjects];
                            for (int i = 0 ; i<dataArr.count ; i++){
                                EqModel * eqModel  = [EqModel mj_objectWithKeyValues:[dataArr objectAtIndex:i]];
                                [_eqArr addObject:eqModel];
                                
                            }
                            [self performSelectorOnMainThread:@selector(createEqUI) withObject:nil waitUntilDone:YES];
                            
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
            else{
                [_eqView removeFromSuperview];
                _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum-_num];
                _totalNum = _totalNum - _num;
                if([[use objectForKey:[NSString stringWithFormat:@"%d",(int)sender.tag - 100]] isKindOfClass:[NSArray class]]){
                    NSMutableArray * arr = [NSMutableArray arrayWithArray:[use objectForKey:[NSString stringWithFormat:@"%d",(int)sender.tag - 100]]];
                    [arr removeAllObjects];
                    [use setObject:arr forKey:[NSString stringWithFormat:@"%d",(int)sender.tag - 100]];
                }

                sender.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            }
        }else {
            UIButton * btn = (UIButton *)[self.view viewWithTag:100+i];
            if (btn.selected == YES){
                btn.selected = !btn.selected;
                btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            }
            else{
                btn.layer.borderColor = RGB(0.44, 0.44, 0.44).CGColor;
            }
        }
    }
}
-(void)createEqUI{
    _eqView = [self createViewWithH:_dateView.bottom +5 Title:@"可选商家" contentArray:_eqArr part:2];
    [self.view addSubview:_eqView];
}
//全选按钮点击事件
-(void)allSelectClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    //    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    if (sender.selected == YES) {
        for (int i = 0 ; i <_eqArr.count;i++){
            EqModel * eqMol = _eqArr[i];
            NSLog(@"%@",_idArr);
            if (eqMol.current_ads != eqMol.max_ads){
                _totalNum++;
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                if([[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]] isKindOfClass:[NSArray class]]){
                    NSMutableArray * arr = [NSMutableArray arrayWithArray:[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
                    [arr addObject:eqMol.device_id];
                    [user setObject:arr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
                }else{
                    [_idArr addObject:eqMol.device_id];
                    [user setObject:_idArr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
                    
                }
            
            _grayView = (UIView *)[self.view viewWithTag:2000+i];
            _grayView.hidden = NO;
            _selectedImg = (UIImageView *)[self.view viewWithTag:3000+i];
            _selectedImg.hidden = NO;
            }
        }
        if (_addNum == 0){
            _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
        }
        else{
            _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum-_addNum];
            _totalNum = _totalNum -_addNum;
            _addNum = _num-_addNum;
        }
    }
    else{
        for (int i = 0 ; i <_eqArr.count;i++){
            
            EqModel * eqMol = _eqArr[i];
            if (eqMol.current_ads != eqMol.max_ads){
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSMutableArray * arr = [NSMutableArray arrayWithArray:[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
                [arr removeAllObjects];
                [user setObject:arr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
                _totalNum--;
                
            
            
            _grayView = (UIView *)[self.view viewWithTag:2000+i];
            _grayView.hidden = YES;
            _selectedImg = (UIImageView *)[self.view viewWithTag:3000+i];
            _selectedImg.hidden = YES;
           } 
        }
        _addNum = 0;
        _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
    }
}

//设备按钮点击事件
-(void)screenBtnClick:(UIButton *)sender{
    sender.selected  = !sender.selected;
    if (sender.selected == YES) {
        NSLog(@"addnum%d",_addNum);
        _addNum++;
        _totalNum++;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
        if (_addNum == _num){
            UIButton * all = (UIButton *)[self.view viewWithTag:100000];
            if (all.selected != YES){
                all.selected = !all.selected;
            }else{
            }
        }
        EqModel * eqMol = _eqArr[sender.tag%10000];
        
        if([[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]] isKindOfClass:[NSArray class]]){
            NSMutableArray * arr = [NSMutableArray arrayWithArray:[user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
            [arr addObject:eqMol.device_id];
            [user setObject:arr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
        }else{
            [_idArr addObject:eqMol.device_id];
            [user setObject:_idArr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
            
        }
        _grayView = (UIView *)[self.view viewWithTag:2000+sender.tag%10000];
        _grayView.hidden = NO;
        _selectedImg = (UIImageView *)[self.view viewWithTag:3000+sender.tag%10000];
        _selectedImg.hidden = NO;
    }
    else{
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arr  =[NSMutableArray arrayWithArray: [user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
        EqModel * eqMol = _eqArr[sender.tag%10000];
        for  (int i = 0 ; i<arr.count;i++){
            if (arr[i] ==eqMol.device_id){
                [arr removeObjectAtIndex:i];
            }
        }
        [user setObject:arr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
        _addNum--;
        _totalNum--;
        _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
        if (_addNum == _num){
            _addNum = 0;
            UIButton * all = (UIButton *)[self.view viewWithTag:100000];
            if (all.selected != YES){
            }else{
                all.selected = !all.selected;
                
            }
            
        }
        _grayView = (UIView *)[self.view viewWithTag:2000+sender.tag%10000];
        _grayView.hidden = YES;
        _selectedImg = (UIImageView *)[self.view viewWithTag:3000+sender.tag%10000];
        _selectedImg.hidden = YES;
        
    }
}
//对号图片点击手势
-(void)uncheckTap:(UITapGestureRecognizer *)tap{
    UIButton * btn =  (UIButton *)[self.view viewWithTag:tap.view.tag%3000+10000];
    if (btn.selected == YES){
        btn.selected = !btn.selected;
        _addNum--;
        if (_addNum < _num){
            UIButton * all = (UIButton *)[self.view viewWithTag:100000];
            if (all.selected == YES){
                all.selected = !all.selected;
            }else{
            }
        }
        EqModel * eqMol = _eqArr[tap.view.tag%3000];
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arr  =[NSMutableArray arrayWithArray: [user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
        [arr removeObject:eqMol.device_id];
        _totalNum--;
        _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
        [user setObject:arr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
        _grayView = (UIView *)[self.view viewWithTag:tap.view.tag-1000];
        _grayView.hidden = YES;
        _selectedImg = (UIImageView *)[self.view viewWithTag:tap.view.tag];
        _selectedImg.hidden = YES;
    }
    else{
        _addNum--;
        if (_addNum < _num){
            UIButton * all = (UIButton *)[self.view viewWithTag:100000];
            if (all.selected == YES){
                all.selected = !all.selected;
            }else{
            }
        }
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arr  =[NSMutableArray arrayWithArray: [user objectForKey:[NSString stringWithFormat:@"%d",_defalutTag]]];
        EqModel * eqMol = _eqArr[tap.view.tag%3000];
        
        for  (int i = 0 ; i<arr.count;i++){
            if (arr[i] ==eqMol.device_id){
                [arr removeLastObject];
            }
        }
        [user setObject:arr forKey:[NSString stringWithFormat:@"%d",_defalutTag]];
        
        _totalNum--;
        _totalNumLab.text = [NSString stringWithFormat:@"%d 屏",_totalNum];
        _grayView = (UIView *)[self.view viewWithTag:tap.view.tag-1000];
        _grayView.hidden = YES;
        _selectedImg = (UIImageView *)[self.view viewWithTag:tap.view.tag];
        _selectedImg.hidden = YES;
    }
}
//发布按钮点击事件
-(void)ReleaseClick{
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    for (int i = 0 ;i < _dateArr.count ; i++){
        if ([[use objectForKey:[NSString stringWithFormat:@"%d",i]] isKindOfClass:[NSArray class]]){
            if ([[use objectForKey:[NSString stringWithFormat:@"%d",i]] count] > 0){
                DateModel  * mol = _dateArr[i];
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",mol.timestamp],@"date",[NSString stringWithFormat:@"%d",mol.type],@"type",[use objectForKey:[NSString stringWithFormat:@"%d",i]],@"device_id", nil];
                [_listArr addObject:dict];
            }
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSArray * md5Items = [KSubmitAd componentsSeparatedByString:@"/"];
    NSString * md5Str = [md5Items[0] stringByAppendingString:[self md5:@"bjyfkj4006010136"]];
    NSString * sign = [self md5:[md5Str stringByAppendingString:md5Items[1]]];
    
    NSString *playlistStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:_listArr options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    _pramerDic = @{@"sign":sign,@"token":[use objectForKey:@"token"],@"title":[use objectForKey:@"title"],@"content":[use objectForKey:@"text"],@"shop_name":[use objectForKey:@"contentText"],@"shop_address":[use objectForKey:@"address"],@"playlist":[playlistStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"start_time":[use objectForKey:@"beginTime"],@"end_time":[use objectForKey:@"endTime"],@"promotion_content":[use objectForKey:@"redContent"],@"promotion_expire":@"1",@"promotion_get_type":[use objectForKey:@"limit"]};
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    managers.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managers POST:[BASEURL stringByAppendingString:KSubmitAd] parameters:_pramerDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        hud.hidden = YES;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSArray * photoArr = [user objectForKey:@"photoArray"];
        for ( int i = 0 ;i< photoArr.count ;i++){
            [formData appendPartWithFileData:photoArr[i] name:@"poster[]" fileName:@"icon.jpg" mimeType:@"image/jpg/file/png"];
        }
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic = [resultString mj_JSONObject];
        int status = [[dic objectForKey:@"status"] intValue];;
        if (status == 1) {
            [use setObject:nil forKey:@"text"];
            [use setObject:nil forKey:@"contentText"];
            [use setObject:nil forKey:@"address"];
            [use setObject:@[] forKey:@"photoArray"];
            ReleaseSuccessViewController * rsVC = [[ReleaseSuccessViewController alloc]init];
            rsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rsVC animated:YES];
            
        }
        else if (status == -1){
            [use setObject:nil forKey:@"text"];
            [use setObject:nil forKey:@"contentText"];
            [use setObject:nil forKey:@"address"];
            HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"登录超时" buttonTitles:@"确定", nil];
            [alert showInView:self.view completion:^(HYAlertView *alertView, NSInteger selectIndex) {
                LoginViewController * logVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:logVC animated:YES];            }];
        }
        else{
            NSString *mess = [dic objectForKey:@"message"];
            [self errorMessages:mess];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
    }];
    
}
-(void)setHighlighted:(BOOL)highlighted{
    
}
//md5 加密
-(NSString *)md5:(NSString *)string{
    const char *str = [string UTF8String];
    unsigned char result[16];
    CC_MD5( str, (CC_LONG)strlen(str), result );
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}
//字典转为Json字符串
-(NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
