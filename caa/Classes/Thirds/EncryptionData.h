//
//  encryptionData.h
//  test
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionData : NSObject
//加密
- (NSString*)encodeString:(NSString*)data key:(NSString*)key;
//解密
- (NSString*)decryption:(NSString*)data key:(NSString*)key;

@end
