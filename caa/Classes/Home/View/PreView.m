//
//  PreView.m
//  caa
//
//  Created by xichao on 16/11/9.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "PreView.h"
#import "NSDate+extend.h"

@implementation PreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
        self.backgroundColor = RGB(0.97, 0.97, 0.97);
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, frame.size.width, frame.size.height-500)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _bgView =[ [UIView alloc]initWithFrame:CGRectMake(0,0,view.width-160*WidthRate ,view.height-70)];
        _bgView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:_bgView];
        UILabel * defLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _bgView.height/2-15, _bgView.width, 30)];
        defLab.text = @"搞笑视频播放区域";
        defLab.textColor = [UIColor redColor];
        defLab.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:defLab];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _bgView.bottom-15, _bgView.width, 10)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.font = [UIFont systemFontOfSize:10.0f];
       NSString * shopNameStr = [use objectForKey:@"shopName"];
       NSString * addressStr = [use objectForKey:@"address"];
        _addressLabel.text = [NSString stringWithFormat:@"本视频由(%@)特约播出(%@)",shopNameStr,addressStr];
        _addressLabel.textColor = [UIColor redColor];
        [_bgView addSubview:_addressLabel];
        
        
        
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,_bgView.bottom + 15   ,_bgView.width,40)];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:16.0f];
        _contentLabel.backgroundColor =[UIColor whiteColor];
       NSString * _contenStr = [use objectForKey:@"content"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = [NSString stringWithFormat:@"%@",_contenStr];
        [view addSubview:_contentLabel];
        
        
        
        
        _adImg = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.right, 0, 160*WidthRate, _bgView.bottom-20*WidthRate)];
        [_adImg sd_setImageWithURL:nil placeholderImage:[UIImage imageWithData:[[use objectForKey:@"photoArray"] firstObject]]];
        [view addSubview:_adImg];
        
        _codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.right, _adImg.bottom+5, _adImg.width-80*WidthRate, view.height - _adImg.height - 15)];
        [_codeImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"code"]];
        [view addSubview:_codeImg];
        
        _shopImg = [[UIImageView alloc]initWithFrame:CGRectMake(view.right-60*WidthRate, _codeImg.top, 40*WidthRate, _codeImg.height/2)];
        
        [_shopImg sd_setImageWithURL:nil placeholderImage:[UIImage imageWithData:[[use objectForKey:@"btnPhotoArray"] firstObject]]];
        [view addSubview:_shopImg];
        
        
        _tipLab = [[UILabel alloc]initWithFrame:CGRectMake(view.right-80*WidthRate, _shopImg.bottom+10*WidthRate, 80*WidthRate, _shopImg.height)];
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.text = [use objectForKey:@"tip"];
        _tipLab.textColor = [UIColor redColor];
        _tipLab.font = [UIFont systemFontOfSize:12];
        [view addSubview:_tipLab];
        
        
        //时间
        //        UILabel * beiginLab = [[UILabel alloc]initWithFrame:CGRectMake(view.right-80*WidthRate, _tipLab.bottom+5, 80*WidthRate, 20)];
        //        beiginLab.text = [NSDate stringWithTimestamp:[[use objectForKey:@"beginTime"] doubleValue] format:@"MM-dd"];
        //        beiginLab.textColor = [UIColor redColor];
        //        beiginLab.font = [UIFont systemFontOfSize:14];
        //        beiginLab.textAlignment = NSTextAlignmentCenter;
        //        [view addSubview:beiginLab];
        //
        //        UILabel * endLab = [[UILabel alloc]initWithFrame:CGRectMake(view.right-80*WidthRate, beiginLab.bottom+5, 80*WidthRate, 20)];
        //        endLab.text = [NSString stringWithFormat:@"至%@",[NSDate stringWithTimestamp:[[use objectForKey:@"endTime"] doubleValue] format:@"MM-dd"]];
        //        endLab.textColor = [UIColor redColor];
        //        endLab.font = [UIFont systemFontOfSize:14];
        //        endLab.textAlignment = NSTextAlignmentCenter;
        //        [view addSubview:endLab];
        
        
        //        UILabel * defaultLab = [[UILabel alloc]initWithFrame:CGRectMake(view.right-80*WidthRate, view.height - 45*WidthRate, 80*WidthRate, 40*WidthRate)];
        //                defaultLab.textColor = [UIColor redColor];
        //                defaultLab.text = @"微信扫一扫领取优惠券";
        //                defaultLab.numberOfLines = 2;
        //                defaultLab.textAlignment = NSTextAlignmentLeft;
        //                defaultLab.font = [UIFont systemFontOfSize:12];
        //                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:defaultLab.text];
        //                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //                [paragraphStyle setLineSpacing:5];//调整行间距
        //                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [defaultLab.text length])];
        //                defaultLab.attributedText = attributedString;
        //
        //                [view addSubview:defaultLab];
        
        //        最后添加上即可
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(10, 5, 25, 25);
        _closeBtn.layer.masksToBounds = YES;
        _closeBtn.layer.cornerRadius = 12.5;
        _closeBtn.backgroundColor = [UIColor lightGrayColor];
        [_closeBtn setImage:[UIImage imageNamed:@"btn_cancle"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(CloseClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_closeBtn];
        
    }
    return self;
}
-(void)CloseClick{
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [self removeFromSuperview];
    }];
    self.block();
}
@end
