//
//  HistoryModel.h
//  caa
//
//  Created by xichao on 16/11/25.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseModel.h"

@interface HistoryModel : BaseModel
@property(nonatomic,strong)NSString * status;
@property(nonatomic,strong)NSString * ads_id;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * type;
@end
