//
//  MBProgressHUD+Package.m
//  StoreAgent
//
//  Created by Kong on 16/5/10.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "MBProgressHUD+Package.h"


@implementation MBProgressHUD (Package)

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view titleLableText:(NSString *)labelText
{
    MBProgressHUD *hud            = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText                 = labelText;
    hud.mode                      = MBProgressHUDModeText;
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
    return hud;
}

@end
