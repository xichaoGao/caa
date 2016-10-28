//
//  LGReachability.m
//  AFN封装实时更新网络状态
//
//  Created by ZR比KLQ帅 on 15/11/8.
//  Copyright © 2015年 ZR比KLQ帅 All rights reserved.
//


#import "LGReachability.h"

@implementation LGReachability

+ (void)LGwithSuccessBlock:(successBlock)success
{
    [[self sharedManager]startMonitoring];
    
    [[self sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == 0) {
            success(@"无连接");
        }else if (status == 1){
            success(@"3G/4G网络");
        }else if (status == 2){
            success(@"wifi状态下");
        }
    }];
}

@end
