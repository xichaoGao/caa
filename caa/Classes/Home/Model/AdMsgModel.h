//
//  AdMsgModel.h
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseModel.h"

@interface AdMsgModel : BaseModel
@property(nonatomic,strong)NSString * ads_id;
@property(nonatomic,strong)NSString * device_count;
@property(nonatomic,strong)NSString * play_count;
@property(nonatomic,strong)NSString * get_count;
@property(nonatomic,strong)NSString * use_count;
@property(nonatomic,strong)NSString * status;
@end
