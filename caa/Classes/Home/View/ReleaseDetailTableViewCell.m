//
//  ReleaseDetailTableViewCell.m
//  caa
//
//  Created by xichao on 16/11/3.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "ReleaseDetailTableViewCell.h"

@implementation ReleaseDetailTableViewCell

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
        _screenImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 100, 75)];
        _screenImg.layer.masksToBounds = YES;
        _screenImg.layer.cornerRadius = 10;
        [self addSubview:_screenImg];
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_screenImg.right + 20, _screenImg.top, 100, 15)];
        _titleLab.textColor = RGB(0.96, 0.55, 0.40);
        _titleLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLab];
        _playLab = [[UILabel alloc]initWithFrame:CGRectMake(_titleLab.left, _titleLab.bottom + 5, 80, 15)];
        _playLab.textColor = RGB(0.41, 0.41, 0.41);
        _playLab.font = [UIFont systemFontOfSize:12];
        _playLab.text = @"播放次数：";
        [self addSubview:_playLab];
        
        _playNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_playLab.right, _titleLab.bottom + 5, 80, 15)];
        _playNumLab.textColor = RGB(0.41, 0.41, 0.41);
        _playNumLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_playNumLab];
        
        _receLab = [[UILabel alloc]initWithFrame:CGRectMake(_titleLab.left, _playLab.bottom + 5, 80, 15)];
        _receLab.textColor = RGB(0.41, 0.41, 0.41);
        _receLab.font = [UIFont systemFontOfSize:12];
        _receLab.text = @"领  取：";
        [self addSubview:_receLab];
        
        _receNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_receLab.right, _playLab.bottom + 5, 80, 15)];
        _receNumLab.textColor = RGB(0.41, 0.41, 0.41);
        _receNumLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_receNumLab];
        
        _toShopLab = [[UILabel alloc]initWithFrame:CGRectMake(_titleLab.left, _receLab.bottom + 5, 80, 15)];
        _toShopLab.textColor = RGB(0.41, 0.41, 0.41);
        _toShopLab.font = [UIFont systemFontOfSize:12];
        _toShopLab.text = @"到店人数：";
        [self addSubview:_toShopLab];
        
        _toShopNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_toShopLab.right, _receLab.bottom + 5, 80, 15)];
        _toShopNumLab.textColor = RGB(0.41, 0.41, 0.41);
        _toShopNumLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_toShopNumLab];
        
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(kScreenWidth - 15, (95-14)/2, 6, 14);
        [_detailBtn setImage:[UIImage imageNamed:@"home_public_more"] forState:UIControlStateNormal];
        [self addSubview:_detailBtn];
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 94.5, kScreenWidth, 0.5)];
        _lineView.backgroundColor = RGB(0.90, 0.90, 0.90);
        [self addSubview:_lineView];
    }
    
    return self;
}

@end
