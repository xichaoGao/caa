//
//  TextView.m
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "TextView.h"
@interface TextView()<UITextViewDelegate>


@end
@implementation TextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _textView =[ [UITextView alloc]initWithFrame:CGRectMake(15,20,frame.size.width-30 ,220)];
        _textView.delegate = self;
        [_textView becomeFirstResponder];
        _textView.textColor = RGB(0.41, 0.41, 0.41);
        _textView.layer.borderWidth = 1.0;//边宽
        _textView.layer.cornerRadius = 5.0;//设置圆角
        _textView.font = [UIFont systemFontOfSize:24];
        _textView.layer.borderColor = RGB(0.84, 0.84, 0.84).CGColor;
        
        //再创建个可以放置默认字的lable
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,20,_textView.width-20,60)];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textColor = RGB(0.84, 0.84, 0.84);
        _placeHolderLabel.backgroundColor =[UIColor clearColor];
        
        //多余的一步不需要的可以不写  计算textview的输入字数
        self.residueLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textView.width-40, _textView.height-40, 40, 40)];
        self.residueLabel.backgroundColor = [UIColor clearColor];
        self.residueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.residueLabel.text =[NSString stringWithFormat:@"50/50"];
        self.residueLabel.textColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [_textView addSubview:_residueLabel];
        
        //最后添加上即可
        [self addSubview :_textView];
        [self.textView addSubview:self.placeHolderLabel];
        
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancleBtn.frame = CGRectMake(20, _textView.bottom + 50*WidthRate, 80, 40);
        [_cancleBtn setTitle:@"取消" forState: UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _cancleBtn.layer.cornerRadius = 20;
        [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleBtn];
        
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _sureBtn.frame = CGRectMake(kScreenWidth -100, _textView.bottom + 50*WidthRate, 80, 40);
        [_sureBtn setTitle:@"确定" forState: UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.backgroundColor = RGB(0.95, 0.39, 0.21);
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _sureBtn.layer.cornerRadius = 20;
        [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureBtn];
        
        
    }
    return self;
}

-(void)textViewDidChange:(UITextView*)textView

{
    
    if([textView.text length] == 0){
        
        self.placeHolderLabel.text = @"请输入你的文字描述最多50字";
        
    }else{
        
        self.placeHolderLabel.text = @"";//这里给空
        
    }
    
    //计算剩余字数   不需要的也可不写
    
    NSString *nsTextCotent = textView.text;
    
    int existTextNum = (int)[nsTextCotent length];
    
    int remainTextNum = 50 - existTextNum;
    
    self.residueLabel.text = [NSString stringWithFormat:@"%d/50",remainTextNum];
    
}

//设置超出最大字数（140字）即不可输入 也是textview的代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"n"]) {     //这里"n"对应的是键盘的 return 回收键盘之用
        
        [textView resignFirstResponder];
        
        return YES;
        
    }
    if (range.location >= 50){
        return NO;
    }else{
        return YES;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_textView resignFirstResponder];
}
-(void)cancleClick{
    
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
    }];
    [_textView resignFirstResponder];
    self.block(_textView.text,0);
    
}
-(void)sureClick{
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
    }];
    [_textView resignFirstResponder];
    
    self.block(_textView.text,1);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
