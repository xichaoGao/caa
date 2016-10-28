//
//  LGReachability.h
//  AFN封装实时更新网络状态
//
//  Created by ZR比KLQ帅 on 15/11/8.
//  Copyright © 2015年 ZR比KLQ帅 All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"

//成功回调
typedef void (^successBlock)(NSString *status);



@interface LGReachability : AFNetworkReachabilityManager

/**
 *  网络状态
 */
+ (void)LGwithSuccessBlock:(successBlock)success;
@end
