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
@property(nonatomic,assign)NSInteger  create_time;
@property(nonatomic,assign)NSInteger  use_time;
@end
