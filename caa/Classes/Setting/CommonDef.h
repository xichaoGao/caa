//
//  CommonDef.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Package.h"
#import "AppDelegate.h"
#import "HYAlertView.h"
#import "MJRefresh.h"
//#import "NSStringManager.h"
#import "EncryptionData.h"
//#import "UIScrollView+APParallaxHeader.h"
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"
#import "LGReachability.h"
#import "JPUSHService.h"

#ifndef CommonDef_h
#define CommonDef_h

#define WidthRate kScreenWidth /375 //以iPhone6屏幕尺寸开发 
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kBackgroundColor UIColorFromHex(0Xf4f4f4) //整体背景颜色、底色
/**
 *  Notification;
 */
#define kDeviveTokenStr @"DeviveTokenStr"

#endif /* CommonDef_h */
