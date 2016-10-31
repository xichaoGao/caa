//
//  NotificationConfigure.h
//  ZhiNengHuFu
//
//  Created by Kong on 16/5/16.
//  Copyright © 2016年 韩佳雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface NotificationConfigure : NSObject
/**
 *  注册通知;
 */
singleton_interface(NotificationConfigure);

- (void)registerNotification;


- (void)saveDeviceTokenWithDeviceTokenDescription:(NSString *)deviceToken; //保存加密的 DeviecToken;

- (NSString *)getDeviceToken; //加密后的 DeviceToken;

@end
