//
//  BaseViewController.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = RGB(0.95, 0.39, 0.21);
    
  

    UIView *statusBarView1 = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 64)];
        //设置
        statusBarView1.backgroundColor = RGB(0.95, 0.39, 0.21);
    // 添加到 navigationBar 上
    [self.navigationController.navigationBar addSubview:statusBarView1];
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 44, 44);
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    
    [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(doBackWithBaseVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 44, 44);
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    self.rightBtn.hidden = YES;
    
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)doBackWithBaseVC:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)errorMessages:(NSString *)errorStr{
    
    if (errorStr.length == 0) {
        errorStr = @"获取数据失败";
    }
    
    HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:errorStr buttonTitles:@"确定", nil];
    [alert showInView:self.view completion:nil];
    
}

- (void)showMBProgressView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hiddenMBProgressView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


//-(NSString *)getMemberIDWithEncrypt{
//    if (kpassPortMemberStatusMemberIDStr != nil) {
//        EncryptionData *encryptionData = [[EncryptionData alloc] init];
//        NSString *decodeString = [encryptionData decryption:kpassPortMemberStatusMemberIDStr key:messageStr];
//        NSMutableDictionary *dic = [decodeString objectFromJSONString];
//        NSString *memberIDStr = [dic objectForKey:@"memberID"];
//        return memberIDStr;
//    }else{
//        return nil;
//    }
//}

//-(id)encryptWithParamer:(id)paramer{
//    
//    
//    //对参数做处理 前加# 后加+
//    NSData *jsonDatas = [NSJSONSerialization dataWithJSONObject:paramer options:NSJSONWritingPrettyPrinted error:nil];
//    
//    NSMutableString *parStr = [NSMutableString stringWithFormat:@"%@",[[NSString alloc] initWithData:jsonDatas encoding:NSUTF8StringEncoding]];
//    
//    [parStr insertString:@"#" atIndex:0];
//    [parStr appendFormat:@"%@",@"+"];
//    
//    //然后将参数进行加密
//    EncryptionData *encryptionData = [[EncryptionData alloc] init];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parStr options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonString = [jsonData base64EncodedStringWithOptions:0];
////    NSString *encodeString = [encryptionData encodeString:jsonString key:messageStr];
////    NSDictionary *paramerDic = @{@"sign":encodeString};
//    return paramerDic;
//}
//
//-(id)decryptionWithResult:(id)result{
//    EncryptionData *encryptionData = [[EncryptionData alloc] init];
//    NSString *resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
//    resultString = [resultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
////    NSString *decodeString = [encryptionData decryption:resultString key:messageStr];
////    NSMutableDictionary *dic = [decodeString objectFromJSONString];
//    return dic;
//}
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
