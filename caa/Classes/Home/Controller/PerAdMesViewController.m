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
#import "XWScanImage.h"
#import "TextView.h"
#import "PreView.h"
#import "PreView1.h"
@interface PerAdMesViewController ()<UITextFieldDelegate,JKImagePickerControllerDelegate>
@property (strong,nonatomic)NSMutableArray *assetsArray;
@property(nonatomic,strong)NSMutableArray * imgArray;
@property(nonatomic,strong)NSMutableArray  *photoArray;
@property(nonatomic,assign)int selectTag;
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
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:nil forKey:@"photoArray"];
    [user setObject:@"" forKey:@"text"];
    [user setObject:@"" forKey:@"contentText"];
    _photoArray = [NSMutableArray arrayWithCapacity:1];
    _assetsArray = [NSMutableArray array];
    _imgArray = [NSMutableArray array];
    self.navigationItem.title = @"完善广告信息";
    [self createUI];
    // Do any additional setup after loading the view.
}
//创建界面
-(void)createUI{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(12, 10*WidthRate, kScreenWidth-24, 160*WidthRate)];
    _bgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    [self.view addSubview:_bgView];
    _defaultLab = [[UILabel alloc]initWithFrame:CGRectMake((_bgView.width - 145*WidthRate)/2, (_bgView.height - 60*WidthRate)/2, 150*WidthRate, 60*WidthRate)];
    _defaultLab.text = @"添加商品照片";
    _defaultLab.textAlignment = NSTextAlignmentCenter;
    _defaultLab.textColor  = RGB(0.84, 0.84, 0.84);
    _defaultLab.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:_defaultLab];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _addBtn.frame = CGRectMake(_bgView.right-55, _bgView.bottom - 55, 35, 35);
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
    
    for (int i=0 ; i<1 ; i++){
        _effectImg = [[UIImageView alloc]initWithFrame:CGRectMake(_effectLab.right +(60*WidthRate +5)*i , _effectLab.origin.y+10, 50*WidthRate, 50*WidthRate)];
        _effectImg.userInteractionEnabled = YES;
        _effectImg.tag = i+1000;
        [_effectImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"home_addmotion"]];
        _effectNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_effectImg.left, _effectImg.bottom + 8, _effectImg.width, 20)];
        _effectNumLab.userInteractionEnabled = YES;
        _effectNumLab.textColor = RGB(0.41, 0.41, 0.41);
        _effectNumLab.tag = 10000+i;
        _effectNumLab.textAlignment = NSTextAlignmentCenter;
        _effectNumLab.text = [@"" stringByAppendingFormat:@"%@%d",@"效果",i+1];
        _effectNumLab.font  = [UIFont systemFontOfSize:10];
        [self.view addSubview:_effectImg];
        [self.view addSubview: _effectNumLab];
        UIButton *selectBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(0, 0, _effectNumLab.width, _effectNumLab.height);
        [selectBtn setImage:nil forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"home_all_tick"] forState:UIControlStateSelected];
        selectBtn.tag = 20000+i;
        [selectBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [_effectNumLab addSubview:selectBtn];
        
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
        [_effectImg addGestureRecognizer:tapGes];
        
    }
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _effectNumLab.bottom + 10*WidthRate, 80, 30)];
    _textLab.font = [UIFont systemFontOfSize:15];
    _textLab.textColor = RGB(0.41, 0.41, 0.41);
    _textLab.text = @"动画文字:";
    [self.view addSubview:_textLab];
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    
    _textBgView = [[UIView alloc]initWithFrame:CGRectMake(_textLab.right, _textLab.origin.y, kScreenWidth - _textLab.right-17, 60*WidthRate)];
    _textBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _textBgView.layer.borderWidth = 1;
    _textBgView.userInteractionEnabled = YES;
    [self.view addSubview:_textBgView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTextTap)];
    [_textBgView addGestureRecognizer:tapGes];
    _textDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _textBgView.width-10, _textBgView.height-10)];
    _textDeLab.font = [UIFont systemFontOfSize:12];
    _textDeLab.numberOfLines = 4;
    _textDeLab.text = [use objectForKey:@"text"]?[use objectForKey:@"text"]:@"";
    _textDeLab.textColor = RGB(0.41, 0.41, 0.41);
    [_textBgView addSubview:_textDeLab];
    
    
    _defTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _textBgView.width-10, _textBgView.height-10)];
    _defTextDeLab.numberOfLines = 0;
    _defTextDeLab.text = @"请输入文字描述";
    _defTextDeLab.font = [UIFont systemFontOfSize:14];
    _defTextDeLab.textColor = RGB(0.84, 0.84, 0.84);
    [_textBgView addSubview:_defTextDeLab];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, _textBgView.bottom+5, kScreenWidth, 100*WidthRate)];
    [self.view addSubview:_contentView];
    _cotentLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 5*WidthRate, 80, 30)];
    _cotentLab.font = [UIFont systemFontOfSize:15];
    _cotentLab.textColor = RGB(0.41, 0.41, 0.41);
    _cotentLab.text = @"活动内容:";
    [_contentView addSubview:_cotentLab];
    
    _contentBgView = [[UIView alloc]initWithFrame:CGRectMake(_cotentLab.right, _cotentLab.origin.y, kScreenWidth - _cotentLab.right-17, 60*WidthRate)];
    _contentBgView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
    _contentBgView.layer.borderWidth = 1;
    _contentBgView.userInteractionEnabled = YES;
    [_contentView addSubview:_contentBgView];
    
    
    UITapGestureRecognizer *tapGess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addContentTextTap)];
    [_contentBgView addGestureRecognizer:tapGess];
    
    
    _contentTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _contentBgView.width-10, _contentBgView.height -5)];
    _contentTextDeLab.font = [UIFont systemFontOfSize:12];
    _contentTextDeLab.numberOfLines = 4;
    _contentTextDeLab.text = [use objectForKey:@"contentText"]?[use objectForKey:@"contentText"]:@"";
    _contentTextDeLab.textColor = RGB(0.41, 0.41, 0.41);
    [_contentBgView addSubview:_contentTextDeLab];
    
    
    _defContentTextDeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _contentBgView.width-10, _contentBgView.height -5)];
    _defContentTextDeLab.numberOfLines = 0;
    _defContentTextDeLab.text = @"请输入活动内容";
    _defContentTextDeLab.font = [UIFont systemFontOfSize:14];
    _defContentTextDeLab.textColor = RGB(0.84, 0.84, 0.84);
    [_contentBgView addSubview:_defContentTextDeLab];
    
    
    _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(12, _contentBgView.bottom + 10*WidthRate, 80, 30)];
    _addressLab.text = @"活动地址:";
    _addressLab.textColor = RGB(0.41, 0.41, 0.41);
    _addressLab.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:_addressLab];
    
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(_addressLab.right + 5, _contentBgView.bottom + 10*WidthRate, kScreenWidth-_addressLab.right-22, 30)];
    _addressTextField.placeholder = @"请输入活动地址";
    _addressTextField.delegate = self;
    _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressTextField.textColor = RGB(0.41, 0.41, 0.41);
    _addressTextField.font = [UIFont systemFontOfSize:13];
    [_contentView addSubview:_addressTextField];
    
    UIView *addressLine = [[UIView alloc]initWithFrame:CGRectMake(0, _addressTextField.height-1, _addressTextField.width, 1)];
    addressLine.backgroundColor = RGB(0.84, 0.84, 0.84);;
    [_addressTextField addSubview:addressLine];
    
    _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewBtn.frame = CGRectMake(20,kScreenHeight-120*WidthRate , 120*WidthRate, 30*WidthRate);
    _previewBtn.layer.masksToBounds = YES;
    _previewBtn.layer.cornerRadius = 15*WidthRate;
    _previewBtn.layer.borderWidth = 1;
    _previewBtn.tag = 100000;
    _previewBtn.enabled = NO;
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
    if ([_textDeLab.text isEqualToString:@""]){
        _defTextDeLab.hidden = NO;
    }else
        _defTextDeLab.hidden = YES;
    if ([_contentTextDeLab.text isEqualToString:@""]){
        _defContentTextDeLab.hidden = NO;
    }else
        _defContentTextDeLab.hidden = YES;
}
//添加图片点击事件
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
    [_imgArray removeAllObjects];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:nil forKey:@"photoArray"];
    [user synchronize];
    NSLog(@"%ld",(unsigned long)self.assetsArray.count);
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        if (_assetsArray.count == 0){
            _defaultLab.hidden = NO;
        }else{
            _defaultLab.hidden = YES;
            [_bgView removeAllSubviews];
            [_bgView addSubview:_addBtn];
            
            for (int i = 0; i<_assetsArray.count;i++){
                _photoImg = [[UIImageView alloc]initWithFrame:CGRectMake((i%5)*((_bgView.width - 60*WidthRate)/5 +11)+11, (i/5)*((_bgView.width - 60*WidthRate)/5+11)+11, (_bgView.width - 66*WidthRate)/5, (_bgView.width - 66*WidthRate)/5)];
                _photoImg.userInteractionEnabled = YES;
                [_photoImg sd_setImageWithURL:nil placeholderImage:_imgArray[i]];
                [_bgView addSubview:_photoImg];
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigTap:)];
                [_photoImg addGestureRecognizer:tapGes];
            }
        }
    }];
    for (JKAssets *asset in assets) {
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                [_imgArray addObject:image];
                
                NSData *imageData =  UIImageJPEGRepresentation([self rotateImage:image], 0.05);
                [_photoArray addObject:imageData];
                
            }
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:_photoArray forKey:@"photoArray"];
            [user synchronize];
        } failureBlock:^(NSError *error) {
            
        }];
    }
}
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
    }];
}
//这个方法是使拍照的时候控制照片的自动旋转
- (UIImage*)rotateImage:(UIImage *)image
{
    int kMaxResolution = 960; // Or whatever
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
//图片放大手势
-(void)bigTap:(UITapGestureRecognizer *)tap{
    for (int i = 0;i<1;i++){
        UIButton * btn = (UIButton *)[self.view viewWithTag:20000+i];
        btn.selected = !btn.selected;
        if (btn.tag == (tap.view.tag%1000 + 20000)){
            if (!(btn.selected = YES)){
                _previewBtn.enabled = YES;
                _selectTag = i;
                btn.selected = !btn.selected;
            }
            else{
                _previewBtn.enabled = YES;
                _selectTag = i;
            }
        
        }else{
            if ((btn.selected = YES)){
                btn.selected = !btn.selected;
            }
            else{
            }
            
        }
    }
    [_titleText resignFirstResponder];
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

//效果点击对号
-(void)selectedClick:(UIButton *)sender{
    [_titleText resignFirstResponder];
    sender.selected = !sender.selected;
    for (int i = 0 ; i< 4;i++){
        if (sender.tag == 20000+i){
            if (sender.selected == YES){
                _previewBtn.enabled = YES;
                _selectTag = i;
                
            }
            else{
                _previewBtn.enabled = NO;
                _selectTag = -1;
            }
        }else {
            
            UIButton * btn = (UIButton *)[self.view viewWithTag:20000+i];
            if (btn.selected == YES){
                _previewBtn.enabled = YES;
                _selectTag = i;
                btn.selected = !btn.selected;
            }
            
        }
    }
}
//添加内容
-(void)addTextTap{
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"text"]?[use objectForKey:@"text"]:@"";
    view.placeHolderLabel.text = @"请输入你的意见最多50字";
    
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    
    view.block=^(NSString * str){
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:str forKey:@"text"];
        [user synchronize];
        if ([str isEqualToString:@""]){
            _defTextDeLab.hidden = NO;
            _textDeLab.hidden = YES;
            _defTextDeLab.text = @"请输入文字描述";
        }else
        {
            _textDeLab.hidden = NO;
            _defTextDeLab.hidden = YES;
            _textDeLab.text = str;
            
        }
        
    };
    
    
    
}
//添加活动内容手势
-(void)addContentTextTap{
    NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
    
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.textView.text = [use objectForKey:@"contentText"]?[use objectForKey:@"contentText"]:@"";
    view.placeHolderLabel.text = @"请输入活动内容";
    view.residueLabel.hidden = YES;
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    view.block=^(NSString * str){
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:str forKey:@"contentText"];
        [user synchronize];
        if ([str isEqualToString:@""]){
            _defContentTextDeLab.hidden = NO;
            _contentTextDeLab.hidden = YES;
            _defContentTextDeLab.text = @"请输入活动内容";
        }else
        {
            _contentTextDeLab.hidden = NO;
            _defContentTextDeLab.hidden = YES;
            _contentTextDeLab.text = str;
            
        }
        
    };
    
}
//预览效果事件
-(void)previewClick:(UIButton *)btn{
    btn.selected =!btn.selected;
    switch (_selectTag) {
        case 0:
            if (btn.selected == YES){
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:_addressTextField.text forKey:@"address"];
                [user setObject:_textDeLab.text forKey:@"text"];
                [user setObject:_contentTextDeLab.text forKey:@"contentText"];
                [_previewBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
                PreView * view = [[PreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [self.view addSubview:view];
                view.transform = CGAffineTransformMakeScale(0.01, 0.01);
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    
                }];
                view.block =^(){
                    UIButton *btn = [self.view viewWithTag:100000];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                    }
                };
                
            }
            else{
                [_previewBtn setBackgroundColor:[UIColor whiteColor]];
                [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
            }
            break;
        case 1:
            if (btn.selected == YES){
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                [user setObject:_addressTextField.text forKey:@"address"];
                [user setObject:_textDeLab.text forKey:@"text"];
                [user setObject:_contentTextDeLab.text forKey:@"contentText"];
                [_previewBtn setBackgroundColor:RGB(0.95, 0.39, 0.21)];
                PreView1 * view = [[PreView1 alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                [self.view addSubview:view];
                view.transform = CGAffineTransformMakeScale(0.01, 0.01);
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    
                }];
                view.block =^(){
                    UIButton *btn = [self.view viewWithTag:100000];
                    if (btn.selected == YES){
                        btn.selected = !btn.selected;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                    }
                };
                
            }
            else{
                [_previewBtn setBackgroundColor:[UIColor whiteColor]];
                [_previewBtn setTitleColor:RGB(0.45, 0.45, 0.45) forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
    
}
//下一步 事件
-(void)nextClick:(UIButton *)btn{
    btn.selected =!btn.selected;
    if (btn.selected == YES){
        btn.selected = !btn.selected;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:_titleText.text forKey:@"title"];
        [user setObject:_addressTextField.text forKey:@"address"];
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
    [_addressTextField resignFirstResponder];
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
