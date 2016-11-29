//
//  WxUserTableViewCell.m
//  caa
//
//  Created by xichao on 16/11/26.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "WxUserTableViewCell.h"

@implementation WxUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _WxImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 60, 60)];
        _WxImg.layer.masksToBounds = YES;
        _WxImg.layer.cornerRadius = 10;
        [self addSubview:_WxImg];
        _nickNameLab = [[UILabel alloc]initWithFrame:CGRectMake(_WxImg.right + 10, _WxImg.top, 150, 15)];
        _nickNameLab.textColor = RGB(0.96, 0.55, 0.40);
        _nickNameLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nickNameLab];
        _receLab = [[UILabel alloc]initWithFrame:CGRectMake(_nickNameLab.left, _nickNameLab.bottom + 5, 80, 15)];
        _receLab.textColor = RGB(0.41, 0.41, 0.41);
        _receLab.font = [UIFont systemFontOfSize:12];
        _receLab.text = @"领取时间：";
        [self addSubview:_receLab];
        
        _receTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_receLab.right, _nickNameLab.bottom + 5, 125, 15)];
        _receTimeLab.textColor = RGB(0.41, 0.41, 0.41);
        _receTimeLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_receTimeLab];
        
        _useLab = [[UILabel alloc]initWithFrame:CGRectMake(_nickNameLab.left, _receTimeLab.bottom + 5, 80, 15)];
        _useLab.textColor = RGB(0.41, 0.41, 0.41);
        _useLab.font = [UIFont systemFontOfSize:12];
        _useLab.text = @"使用时间：";
        [self addSubview:_useLab];
        
        _useTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_useLab.right, _receTimeLab.bottom + 5, 125, 15)];
        _useTimeLab.textColor = RGB(0.41, 0.41, 0.41);
        _useTimeLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_useTimeLab];
        
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79.5, kScreenWidth, 0.5)];
        _lineView.backgroundColor = RGB(0.90, 0.90, 0.90);
        [self addSubview:_lineView];
    }
    
    return self;
}

@end
