//
//  ColorDef.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//
#ifndef ParamsDef_h
#define ParamsDef_h




#endif /* ColorDef_h */
// 颜色设置
#define CLEARCOLOR [UIColor clearColor]

//十六进制方式设置rgb
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

//#define RGBAColor(r,g,b,a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//#define RGB(r,g,b) RGBAColor(r,g,b,1.0f)

#define RGBAColor(r,g,b,a)        [UIColor colorWithRed:r green:g blue:b alpha:a]
#define RGB(r,g,b) RGBAColor(r,g,b,1.0f)
