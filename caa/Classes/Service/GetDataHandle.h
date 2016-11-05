//
//  GetDataHandle.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface GetDataHandle : NSObject

singleton_interface(GetDataHandle);

- (void)analysisDataWithType:(NSString *)typeStr SubUrlString:(NSString *)subUrlString
                          RequestDic:(NSDictionary *)requestDic
                       ResponseBlock:(void (^)(id result, NSError * error))block;
@end
