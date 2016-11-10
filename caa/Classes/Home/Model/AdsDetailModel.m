//
//  AdsDetailModel.m
//  caa
//
//  Created by xichao on 16/11/10.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "AdsDetailModel.h"

@implementation AdsDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]){
        _descriptions = value;
    }
}
@end
