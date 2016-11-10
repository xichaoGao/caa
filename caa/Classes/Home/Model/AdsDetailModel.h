//
//  AdsDetailModel.h
//  caa
//
//  Created by xichao on 16/11/10.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseModel.h"

@interface AdsDetailModel : BaseModel
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * photo;
@property(nonatomic,strong)NSString * descriptions;
@property(nonatomic,strong)NSMutableArray * playlist;
@property(nonatomic,strong)NSMutableArray * tags;
@end
