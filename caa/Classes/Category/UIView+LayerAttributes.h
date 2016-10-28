//
//  UIView+LayerAttributes.h
//  ZhiNengHuFu
//
//  Created by Kong on 16/3/25.
//  Copyright © 2016年 韩佳雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerAttributes)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
