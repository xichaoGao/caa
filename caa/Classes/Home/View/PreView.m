//
//  PreView.m
//  caa
//
//  Created by xichao on 16/11/9.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "PreView.h"

@implementation PreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSUserDefaults * use = [NSUserDefaults standardUserDefaults];
        _tipStr  = [use objectForKey:@"text"];
        self.backgroundColor = RGB(0.97, 0.97, 0.97);
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, frame.size.width, frame.size.height-300)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _bgView =[ [UIView alloc]initWithFrame:CGRectMake(0,0,view.width-180*WidthRate ,view.height-50)];
        _bgView.backgroundColor = [UIColor blackColor];
        [view addSubview:_bgView];
        
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,_bgView.bottom + 5   ,_bgView.width,20)];
        _contentLabel.textColor = RGB(0.96, 0.64, 0.35);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:16.0f];
        _contentLabel.backgroundColor =[UIColor whiteColor];
        _contenStr = [use objectForKey:@"contentText"];
        _contentLabel.text = [NSString stringWithFormat:@"活动内容:%@",_contenStr];
        [view addSubview:_contentLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _contentLabel.bottom+5, _bgView.width, 20)];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.font = [UIFont systemFontOfSize:16.0f];
        _addressStr = [use objectForKey:@"address"];
        _addressLabel.text = [NSString stringWithFormat:@"活动地址:%@",_addressStr];
        _addressLabel.textColor = RGB(0.96, 0.64, 0.35);
        [view addSubview:_addressLabel];
        
        
        _adImg = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.right, 0, 180*WidthRate, _bgView.bottom-100*WidthRate)];
        if ([[use objectForKey:@"photoArray"] count]>0){
            NSLog(@"%@",[[use objectForKey:@"photoArray"] firstObject]);
             [_adImg sd_setImageWithURL:nil placeholderImage:[UIImage imageWithData:[[use objectForKey:@"photoArray"] firstObject]]];
        }
        else
        [_adImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"loading_pic"]];
        [view addSubview:_adImg];
        
        _codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.right, _adImg.bottom+5, _adImg.width*0.6, view.height - _adImg.height - 10)];
        [_codeImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"loading_pic"]];
        [view addSubview:_codeImg];
        _tipLab = [[UILabel alloc]initWithFrame:CGRectMake(_codeImg.right+5, _codeImg.top+5, _adImg.width*0.4-5, 25)];
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.numberOfLines = 0;
        _tipLab.text = [NSString stringWithFormat:@"%@",_tipStr];
        _tipLab.textColor = RGB(0.96, 0.64, 0.35);
        _tipLab.font = [UIFont systemFontOfSize:10];
        [view addSubview:_tipLab];
        
        UILabel * defaultLab = [[UILabel alloc]initWithFrame:CGRectMake(_codeImg.right, view.height - 40*WidthRate, _adImg.width*0.4, 40*WidthRate)];
        defaultLab.textColor = RGB(0.96, 0.64, 0.35);
        defaultLab.text = @"微信扫一扫领取优惠券";
        defaultLab.numberOfLines = 0;
        defaultLab.textAlignment = NSTextAlignmentCenter;
        defaultLab.font = [UIFont systemFontOfSize:14];
        [view addSubview:defaultLab];
        //最后添加上即可
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(view.right -30, 0, 30, 30);
        _closeBtn.layer.masksToBounds = YES;
        _closeBtn.layer.cornerRadius = 15;
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
