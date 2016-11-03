//
//  PerAdMesViewController.m
//  caa
//
//  Created by xichao on 16/10/31.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "PerAdMesViewController.h"
#import "BusinessChooseViewController.h"
#import "JKImagePickerController.h"

@interface PerAdMesViewController ()<UITextFieldDelegate,JKImagePickerControllerDelegate>
@property (strong,nonatomic)NSMutableArray *assetsArray;

@end

@implementation PerAdMesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [_previewBtn setBackgroundColor:[UIColor whiteColor]];
   
    [_nextBtn setBackgroundColor:[UIColor whiteColor]];
    

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _assetsArray = [NSMutableArray array];
    self.navigationItem.title = @"完善广告信息";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12, 10*WidthRate, kScreenWidth-24, 160*WidthRate)];
    _bgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    [self.view addSubview:_bgView];
    if (_assetsArray.count == 0){
    _defaultLab = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 145*WidthRate)/2, (_bgView.height - 60*WidthRate)/2, 150*WidthRate, 60*WidthRate)];
    _defaultLab.text = @"添加商品照片";
    _defaultLab.textColor  = RGB(0.84, 0.84, 0.84);
    _defaultLab.font = [UIFont systemFontOfSize:20];
    [_bgView addSubview:_defaultLab];
    }
    else{
        
    }
    _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _addBtn.frame = CGRectMake(_bgView.right-45, _bgView.bottom - 45, 25, 25);
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"home_addphotos"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addPhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_addBtn];
    
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _bgView.bottom + 10*WidthRate, 50, 30)];
    _textLab.text = @"标题:";
    _textLab.textColor = RGB(0.41, 0.41, 0.41);
    _textLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_textLab];
    
    _titleText = [[UITextField alloc]initWithFrame:CGRectMake(_textLab.right + 5, _bgView.bottom + 10*WidthRate, kScreenWidth-_textLab.right-22, 30)];
    _titleText.placeholder = @"请输入您的标题";
    _titleText.delegate = self;
    _titleText.clearButtonMode = UITextFieldViewModeWhileEditing;

    _titleText.textColor = RGB(0.41, 0.41, 0.41);
    _titleText.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_titleText];
    
    _titleLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleText.height-5, _titleText.width, 1)];
    _titleLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_titleText addSubview:_titleLine];
    
    _effectLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _textLab.bottom + 10*WidthRate, 80, 30)];
    _effectLab.font = [UIFont systemFontOfSize:15];
    _effectLab.textColor = RGB(0.41, 0.41, 0.41);
    _effectLab.text = @"动画效果:";
    [self.view addSubview:_effectLab];
    
    for (int i=0 ; i<4 ; i++){
        _effectImg = [[UIImageView alloc]initWithFrame:CGRectMake(_effectLab.right +(60*WidthRate +5)*i , _effectLab.origin.y+10, 50*WidthRate, 50*WidthRate)];
        _effectImg.userInteractionEnabled = YES;
        _effectImg.tag = i+1000;
        [_effectImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_addmotion"]];
        _effectNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_effectImg.left + 11, _effectImg.bottom + 8, 30, 20)];
        _effectNumLab.textColor = RGB(0.41, 0.41, 0.41);
        _effectNumLab.text = [@"" stringByAppendingFormat:@"%@%d",@"效果",i+1];
        _effectNumLab.font  = [UIFont systemFontOfSize:10];
        [self.view addSubview:_effectImg];
        [self.view addSubview: _effectNumLab];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(effectSelectTap:)];
        [_effectImg addGestureRecognizer:tapGes];
        
    }
     _textLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _effectNumLab.bottom + 10*WidthRate, 80, 30)];
    _textLab.font = [UIFont systemFontOfSize:15];
    _textLab.textColor = RGB(0.41, 0.41, 0.41);
    _textLab.text = @"动画文字:";
    [self.view addSubview:_textLab];
    
    _textBgView = [[UIView alloc]initWithFrame:CGRectMake(_textLab.right + 10, _textLab.origin.y, kScreenWidth - _textLab.right-27, 60*WidthRate)];
    _textBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _textBgView.layer.borderWidth = 1;
    _textBgView.userInteractionEnabled = YES;
    [self.view addSubview:_textBgView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTextTap)];
    [_textBgView addGestureRecognizer:tapGes];
    _textDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _textBgView.width-10, _textBgView.height-10)];
    _textDeLab.font = [UIFont systemFontOfSize:10];
    _textDeLab.numberOfLines = 4;
    _textDeLab.textColor = RGB(0.41, 0.41, 0.41);
    [_textBgView addSubview:_textDeLab];
    
    _defTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _textBgView.width-10, _textBgView.height-10)];
    _defTextDeLab.numberOfLines = 0;
    _defTextDeLab.font = [UIFont systemFontOfSize:20];
    _defTextDeLab.text = @"文字个数五十";
    _defTextDeLab.textColor = RGB(0.84, 0.84, 0.84);
    [_textBgView addSubview:_defTextDeLab];

    _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewBtn.frame = CGRectMake(20,kScreenHeight-120*WidthRate , 120*WidthRate, 30*WidthRate);
    _previewBtn.layer.masksToBounds = YES;
    _previewBtn.layer.cornerRadius = 15*WidthRate;
    _previewBtn.layer.borderWidth = 1;
    _previewBtn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    [_previewBtn setBackgroundColor:[UIColor whiteColor]];
    [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    _previewBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45 ) forState:UIControlStateNormal];
    [_previewBtn setTitleColor:RGB(0.98, 0.88, 0.85) forState:UIControlStateSelected];
    [self.view addSubview:_previewBtn];
    [_previewBtn addTarget:self action:@selector(previewClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(kScreenWidth-120*WidthRate-20,kScreenHeight-120*WidthRate , 120*WidthRate, 30*WidthRate);
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 15*WidthRate;
    _nextBtn.layer.borderWidth = 1;
    _nextBtn.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    [_nextBtn setBackgroundColor:[UIColor whiteColor]];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_nextBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
    [_nextBtn setTitleColor:RGB(0.98, 0.88, 0.85) forState:UIControlStateSelected];
    [self.view addSubview:_nextBtn];
    [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)addPhotoClick{
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 0;//最小选取照片数
    imagePickerController.maximumNumberOfSelection = 9;//最大选取照片数
    imagePickerController.selectedAssetArray =self.assetsArray;//已经选择了的照片
    UINavigationController*navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
   }
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    self.assetsArray=[assets mutableCopy];
    NSLog(@"%ld",self.assetsArray.count);
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
    for (JKAssets *asset in assets) {
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                NSData *imageData = UIImageJPEGRepresentation(image,0.5);
                
            }
            
        } failureBlock:^(NSError *error) {
            
        }];
    }
}
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)effectSelectTap:(UITapGestureRecognizer *)tap{
    UIImageView * img = (UIImageView *)tap.view;
    NSLog(@"%ld",img.tag);
}
-(void)addTextTap{
    _defTextDeLab.hidden = YES;
    NSLog(@"%@",@"文字编写");
}
-(void)previewClick:(UIButton *)btn{
    btn.selected =!btn.selected;
    if (btn.selected == YES){
        btn.selected = !btn.selected;

    [_previewBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
    
    }
    else{
        [_previewBtn setBackgroundColor:[UIColor whiteColor]];
        [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
    }
}
-(void)nextClick:(UIButton *)btn{
    btn.selected =!btn.selected;
    if (btn.selected == YES){
        btn.selected = !btn.selected;

        [_nextBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
        BusinessChooseViewController * bcVC = [[BusinessChooseViewController alloc]init];
        bcVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bcVC animated:YES];
    }
    else{
        [_nextBtn setBackgroundColor:[UIColor whiteColor]];
        [_nextBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleText resignFirstResponder];
    return YES;
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
