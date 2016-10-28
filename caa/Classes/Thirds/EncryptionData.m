//
//  encryptionData.m
//  test
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "EncryptionData.h"

@implementation EncryptionData
//加密
- (NSString *)encodeString:(NSString *)data key:(NSString *)key{
    NSString *result=[[NSMutableString alloc] init];
    NSInteger keyLength = [key length];
    int position = 0;
    int keyChar = 0;
    int strChar = 0;
    for (int i = 0; i < [data length]; i++) {
        position = i % keyLength;
        strChar = [data characterAtIndex:i];
        keyChar =[key characterAtIndex:position];
        int  ch = strChar ^ keyChar;
        unichar ca = (char) ch;
        result=[result stringByAppendingString:[NSString stringWithFormat:@"%C",ca]];
    }
    NSData* sampleDat1a = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSString * base64String1 = [sampleDat1a base64EncodedStringWithOptions:0];
    NSMutableString * total = [[NSMutableString alloc] init];
    //生成随机数的长度
    int value = (arc4random() % 8) + 2;
    [total appendFormat:@"%d",value];
    NSString *baseString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    char c;
    for(int i =0;i< value;i++){
        c = [baseString characterAtIndex:arc4random()%64];
        [total appendFormat:@"%c",c];
    }
    [total appendFormat:@"%@",base64String1];
    return total;
}
//解密
- (NSString*)decryption:(NSString*)data key:(NSString*)key{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    data = [data stringByTrimmingCharactersInSet:whitespace];
    int length = [[data substringToIndex:1] intValue];
    data = [data substringFromIndex:(length+1)];
    NSData* dataFromString1 = [[NSData alloc] initWithBase64EncodedString:data options:0];
    NSString* str1= [[NSString alloc] initWithData:dataFromString1  encoding:NSUTF8StringEncoding];
    NSString *result=[[NSMutableString alloc]
                      init];
    NSInteger keyLength = [key length];
    int position = 0;
    int keyChar = 0;
    int strChar = 0;
    for (int i = 0; i < [str1 length]; i++) {
        position = i % keyLength;
        strChar = [str1 characterAtIndex:i];
        keyChar =[key characterAtIndex:position];
        int  ch = strChar ^ keyChar;
        char ca = (char) ch;
        result=[result stringByAppendingString:[NSString stringWithFormat:@"%c",ca]];
    }
    NSData* dataFromString = [[NSData alloc] initWithBase64EncodedString:result options:0];
    NSString* str= [[NSString alloc] initWithData:dataFromString  encoding:NSUTF8StringEncoding];
    return str;
}@end
