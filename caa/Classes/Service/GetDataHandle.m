//
//  GetDataHandle.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "GetDataHandle.h"
#import "EncryptionData.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>
@implementation GetDataHandle
singleton_implementation(GetDataHandle);

-(NSString *)md5:(NSString *)string{
    const char *str = [string UTF8String];
    unsigned char result[16];
    CC_MD5( str, (CC_LONG)strlen(str), result );
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
- (void)analysisDataWithSubUrlString:(NSString *)subUrlString RequestDic:(NSDictionary *)requestDic ResponseBlock:(void (^)(id, NSError *))block
{
    
   }

@end
