//
//  MBProgressHUD+Package.h
//  StoreAgent
//
//  Created by Kong on 16/5/10.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Package)

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view titleLableText:(NSString *)labelText;

@end
