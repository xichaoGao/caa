//
//  BaseViewController.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic ,strong) UIButton *leftBtn;//左侧button
@property (nonatomic ,strong) UIButton *rightBtn;//右侧button

-(void)errorMessages:(NSString *)errorStr;


/**
 *  MBProgressView
 */

- (void)showMBProgressView;
- (void)hiddenMBProgressView;

/*
 *  获取解密后的memberID
 */

-(NSString *)getMemberIDWithEncrypt;

/*
 * 加密
 */
-(id)encryptWithParamer:(id)paramer;

/*
 * 解密
 */
-(id)decryptionWithResult:(id)result;

/*
 * 长连接参数
 */


@end
