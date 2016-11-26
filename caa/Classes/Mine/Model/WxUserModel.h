//
//  WxUserModel.h
//  caa
//
//  Created by xichao on 16/11/26.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseModel.h"

@interface WxUserModel : BaseModel
@property(nonatomic,strong)NSString * headimgurl;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * status;
@property(nonatomic,strong)NSString * create_time;
@property(nonatomic,strong)NSString * use_time;
@end
