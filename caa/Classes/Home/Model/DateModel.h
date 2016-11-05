//
//  DateModel.h
//  caa
//
//  Created by xichao on 16/11/5.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "BaseModel.h"

@interface DateModel : BaseModel
@property(nonatomic,strong)NSString * date;
@property(nonatomic,assign)int  timestamp;
@property(nonatomic,assign)int  type;
@end
