//
//  NotificationConfigure.m
//  ZhiNengHuFu
//
//  Created by Kong on 16/5/16.
//  Copyright © 2016年 韩佳雪. All rights reserved.
//

#import "NotificationConfigure.h"

@implementation NotificationConfigure
singleton_implementation(NotificationConfigure);


- (void)registerNotification
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound];
    }
}

- (void)saveDeviceTokenWithDeviceTokenDescription:(NSString *)deviceToken
{
    EncryptionData *encryptionData = [[EncryptionData alloc] init];
    NSString *clientId = [[[deviceToken
                            stringByReplacingOccurrencesOfString: @"<" withString: @""]
                           stringByReplacingOccurrencesOfString: @">" withString: @""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Here Here Here 🐮🐮🐮🐮🐮🐮%@",clientId);
    NSData *encodeData = [clientId dataUsingEncoding:NSUTF8StringEncoding];
    NSString * base64String1 = [encodeData base64EncodedStringWithOptions:0];
    
    NSString *encryptionDeviceToken = [encryptionData encodeString:base64String1 key:messageStr];
//    [self saveDeviceTokenToServiceWithDeviceTokenDescription:encryptionDeviceToken];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:encryptionDeviceToken forKey:kDeviveTokenStr];
    [userDefaults synchronize];
}

- (NSString *)getDeviceToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pushTokenStr = [userDefaults objectForKey:kDeviveTokenStr];
    return pushTokenStr;
}

//- (void)saveDeviceTokenToServiceWithDeviceTokenDescription:(NSString *)deviceToken
//{
//    NSString *deviceTokenStr = deviceToken;
//    [[GetDataHandle sharedGetDataHandle] analysisDataWithSubUrlString:kAddpushToken RequestDic:@{@"PushToken":deviceTokenStr} ResponseBlock:^(id result, NSError *error) {
//        if (![[result objectForKey:@"status"] isEqualToString:@"success"]) {
//            [self saveDeviceTokenToServiceWithDeviceTokenDescription:deviceTokenStr];
//        }
//    }];
//}


@end
