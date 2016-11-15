//
//  MineViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "MineViewController.h"
#import "JKImagePickerController.h"
#import "MineReleaseViewController.h"
#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "TextView.h"
@interface MineViewController ()<JKImagePickerControllerDelegate>
{
    NSArray *titleArr;
}
@property(nonatomic,strong)NSDictionary *pramerDic;
@property(nonatomic,strong)UIImage * defaultImg;
@end

@implementation MineViewController
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
    self.navigationItem.title = @"我";
    self.leftBtn.hidden = YES;
    titleArr = @[@"消息中心",@"意见反馈",@"帮助",@"软件升级"];
    [self createUI];
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _headBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210*WidthRate)];
    [self.view addSubview:_headBgView];
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 60*WidthRate)/2, 40 * WidthRate, 60*WidthRate, 60*WidthRate)];
    _headImg.layer.masksToBounds = YES;
    _headImg.userInteractionEnabled = YES;
    _headImg.layer.cornerRadius = 30*WidthRate;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImg"]] placeholderImage:[UIImage imageNamed:@"wo_upload_headphoto"]];
    UITapGestureRecognizer *addPhotoTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoClick)];
    [_headImg addGestureRecognizer:addPhotoTapGes];
    
    [_headBgView addSubview:_headImg];
    _useNameLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 300)/2, _headImg.bottom + 10*WidthRate, 300, 30)];
    _useNameLab.textAlignment = NSTextAlignmentCenter;
    _useNameLab.textColor = RGB(0.41, 0.41, 0.41);
    _useNameLab.userInteractionEnabled = YES;
    _useNameLab.text = [user objectForKey:@"nickName"];
    [_headBgView addSubview:_useNameLab];
    UITapGestureRecognizer *tapGess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeContentTap)];
    [_useNameLab addGestureRecognizer:tapGess];
    _mineReleaseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _mineReleaseBtn.frame = CGRectMake((kScreenWidth - 150)/2, _useNameLab.bottom + 10*WidthRate, 150, 40*WidthRate);
    [_mineReleaseBtn setTitle:@"我的发布" forState: UIControlStateNormal];
    [_mineReleaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mineReleaseBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
    _mineReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _mineReleaseBtn.layer.cornerRadius = 20*WidthRate;
    [_mineReleaseBtn addTarget:self action:@selector(mineReleaseClick) forControlEvents:UIControlEventTouchUpInside];
    [_headBgView addSubview:_mineReleaseBtn];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headBgView.bottom-0.5, kScreenWidth,0.5)];
    lineView.backgroundColor = RGB(0.84, 0.84, 0.84);
    [_headBgView addSubview:lineView];
    UIView * bgView =  [[UIView alloc]initWithFrame:CGRectMake(0, _headBgView.bottom, kScreenWidth, kScreenHeight-_headBgView.bottom-49)];
    bgView.backgroundColor = RGB(0.97, 0.97, 0.97);
    [self.view addSubview:bgView];
    
    
    _bgView  = [[UIView alloc]initWithFrame:CGRectMake(0, 40*WidthRate, kScreenWidth, 40*titleArr.count)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:_bgView];
    
    
    for (int i = 0; i< titleArr.count;i++){
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, i*40, kScreenWidth,0.5)];
        lineView1.backgroundColor = RGB(0.84, 0.84, 0.84);
        [_bgView addSubview:lineView1];
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, lineView1.bottom, 80, 40)];
        titleLab.text = titleArr[i];
        titleLab.textColor = RGB(0.41, 0.41, 0.41);
        titleLab.font = [UIFont systemFontOfSize:18];
        [_bgView addSubview:titleLab];
        
        UIButton * _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(kScreenWidth - 15, 40*i+(40-14)/2, 6, 14);
        [_detailBtn setImage:[UIImage imageNamed:@"wo_more"] forState:UIControlStateNormal];
        [_bgView addSubview:_detailBtn];
        if (i == titleArr.count-1){
            UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, titleLab.bottom-0.5, kScreenWidth,0.5)];
            lineView2.backgroundColor = RGB(0.84, 0.84, 0.84);
            [_bgView addSubview:lineView2];
        }
    }
    UIView * View  = [[UIView alloc]initWithFrame:CGRectMake(0, _bgView.bottom+40*WidthRate, kScreenWidth, 40)];
    View.userInteractionEnabled = YES;
    View.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:View];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,0.5)];
    lineView1.backgroundColor = RGB(0.84, 0.84, 0.84);
    [View addSubview:lineView1];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, lineView1.bottom, kScreenWidth-24, 40)];
    titleLab.text = @"退出登录";
    titleLab.textColor = RGB(0.41, 0.41, 0.41);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:18];
    [View addSubview:titleLab];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, titleLab.bottom-0.5, kScreenWidth,0.5)];
    lineView2.backgroundColor = RGB(0.84, 0.84, 0.84);
    [View addSubview:lineView2];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutClick)];
    [View addGestureRecognizer:tapGes];
    
    
    
}
//退出事件
-(void)logoutClick{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _pramerDic = [NSDictionary dictionary];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    _pramerDic = @{@"token":[use objectForKey:@"token"]};
    
    
    [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"POST" SubUrlString:KLogout RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
        hud.hidden = YES;
        int status = [[result objectForKey:@"status"] intValue];;
        if (status == 1) {
            NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
            [defult setObject:nil forKey:@"userID"];
            [defult setObject:nil forKey:@"nickName"];
            [defult setObject:nil forKey:@"token"];
            [defult synchronize];
            [JPUSHService setTags:nil alias:nil fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            }];
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
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
//我的发布事件
-(void)mineReleaseClick{
    MineReleaseViewController * mrVC = [[MineReleaseViewController alloc]init];
    mrVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mrVC animated:YES];
}
//更换图片事件
-(void)addPhotoClick{
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 0;//最小选取照片数
    imagePickerController.maximumNumberOfSelection = 1;//最大选取照片数
    //    imagePickerController.selectedAssetArray =self.assetsArray;//已经选择了的照片
    UINavigationController*navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    for (JKAssets *asset in assets) {
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                _defaultImg = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            }
            
        } failureBlock:^(NSError *error) {
            
        }];
    }
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _pramerDic = [NSDictionary dictionary];
        NSArray * md5Items = [KSetHeadImg componentsSeparatedByString:@"/"];
        NSString * md5Str = [md5Items[0] stringByAppendingString:[self md5:@"bjyfkj4006010136"]];
        NSString * sign = [self md5:[md5Str stringByAppendingString:md5Items[1]]];
        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
        _pramerDic = @{@"token":[use objectForKey:@"token"],@"sign":sign};
        
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        managers.responseSerializer = [AFHTTPResponseSerializer serializer];
        [managers POST:[BASEURL stringByAppendingString:KSetHeadImg] parameters:_pramerDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
            hud.hidden = YES;
            NSData *imageData = UIImageJPEGRepresentation([self rotateImage:_defaultImg], 0.05);
            [formData appendPartWithFileData:imageData name:@"photo" fileName:@"icon.jpg" mimeType:@"image/jpg/file/png"];
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSMutableDictionary *dic = [resultString mj_JSONObject];
            int status = [[dic objectForKey:@"status"] intValue];;
            if (status == 1) {
                NSUserDefaults * usr = [NSUserDefaults standardUserDefaults];
                [usr setObject:[dic objectForKey:@"data"] forKey:@"headImg"];
                [self performSelector:@selector(saveImage:)  withObject:[dic objectForKey:@"data"] afterDelay:1];
            }
            else if (status == -1){
                [use setObject:nil forKey:@"text"];
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
    }];
    
}
- (void)saveImage:(NSString *)imageUrl {
    _headImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    
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
//md5 加密
-(NSString *)md5:(NSString *)string{
    const char *str = [string UTF8String];
    unsigned char result[16];
    CC_MD5( str, (CC_LONG)strlen(str), result );
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}
-(void)changeContentTap{
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    TextView * view = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49)];
    view.textView.text = [use objectForKey:@"nickName"];
    view.placeHolderLabel.hidden = YES;
    view.residueLabel.hidden = YES;
    [self.view addSubview:view];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
    
    view.block=^(NSString * str){
        if ([str isEqualToString:@""]){
            
        }
        else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _pramerDic = [NSDictionary dictionary];
        NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
        _pramerDic = @{@"token":[use objectForKey:@"token"],@"nickname":str};
        [[GetDataHandle sharedGetDataHandle]analysisDataWithType:@"POST" SubUrlString:KSetNickName RequestDic:_pramerDic ResponseBlock:^(id result, NSError *error) {
            hud.hidden = YES;
            int status = [[result objectForKey:@"status"] intValue];;
            if (status == 1) {
                NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
                [defult setObject:str forKey:@"nickName"];
                [defult synchronize];
                _useNameLab.text = str;
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
        };
    
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
