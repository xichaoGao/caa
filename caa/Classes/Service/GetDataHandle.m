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

- (void)analysisDataWithSubUrlString:(NSString *)subUrlString RequestDic:(NSDictionary *)requestDic ResponseBlock:(void (^)(id, NSError *))block
{
    NSArray * md5Items = [subUrlString componentsSeparatedByString:@"/"];
    NSString * md5Str = [md5Items[0] stringByAppendingString:[self md5:@"bjyfkj4006010136"]];
    NSString * sign = [self md5:[md5Str stringByAppendingString:md5Items[1]]];
    NSMutableDictionary *paramer = [NSMutableDictionary dictionaryWithDictionary:@{@"sign":sign}];
      if (requestDic != nil) {
        [paramer addEntriesFromDictionary:requestDic];
    }
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    managers.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *str = [BASEURL stringByAppendingString:subUrlString];
    
    NSLog(@"参数 --  %@   url -- %@ ",paramer,str);
    if (![subUrlString isEqualToString:@"User/checkCode"]){
    [managers POST:str parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic = [resultString mj_JSONObject];
        block(dic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
        
        NSLog(@"%@ -- error",error);
        
    }];
    }
        else {
            [managers GET:str parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                EncryptionData *encryptionData = [[EncryptionData alloc] init];
                NSString *decodeString = [encryptionData decryption:resultString key:messageStr];
                NSMutableDictionary *dic = [decodeString mj_JSONObject];
                block(dic,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
                
                NSLog(@"%@ -- error",error);
                
            }];
        }
   }

@end
