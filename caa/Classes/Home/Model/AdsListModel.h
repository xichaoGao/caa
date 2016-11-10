//
//  AdsListModel.h
//  caa
//
//  Created by xichao on 16/11/10.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseModel.h"

@interface AdsListModel : BaseModel
@property(nonatomic,strong)NSString * device_id;
@property(nonatomic,strong)NSString * play_count;
@property(nonatomic,strong)NSString * get_count;
@property(nonatomic,strong)NSString * use_count;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * logo;

@end
