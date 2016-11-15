//
//  TextView.h
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UIView
@property(nonatomic,strong)UITextView  * textView;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@property(nonatomic,strong)UILabel *residueLabel;// 输入文本时剩余字数
@property(nonatomic,strong)UIButton * cancleBtn;
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,copy)void (^block)(NSString*);

@end
