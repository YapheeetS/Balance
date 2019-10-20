//
//  XYKSportRecordCell.m
//  xyk
//
//  Created by Jame on 2018/9/5.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKSportRecordCell.h"

@interface XYKSportRecordCell ()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *accessImg;

@end

@implementation XYKSportRecordCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sport_record_cell_background"]];
        backImage.userInteractionEnabled = true;
        [backImage setFrame:CGRectMake(0, 0, xScreenWidth, 64)];
        
        UIImageView *iconImage = [[UIImageView alloc]init];
        [backImage addSubview:iconImage];
        iconImage.userInteractionEnabled = true;
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(backImage.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.left.mas_equalTo(backImage.mas_left).offset(25);
        }];
        self.iconImage = iconImage;
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.userInteractionEnabled = true;
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        titleLabel.textColor = RGB(51, 51, 51);
        [backImage addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 25));
            make.centerY.mas_equalTo(backImage.mas_centerY);
            make.left.mas_equalTo(iconImage.mas_right).offset(25);
        }];
        self.titleLabel = titleLabel;
        
        UIImageView *accessImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sport_record_access"]];
        accessImg.userInteractionEnabled = true;
        [backImage addSubview:accessImg];
        [accessImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(7, 11));
            make.centerY.mas_equalTo(backImage.mas_centerY);
            make.right.mas_equalTo(backImage.mas_right).offset(-20);
        }];
        self.accessImg = accessImg;
        
        UILabel *detail = [[UILabel alloc]init];
        detail.text = @"";
        detail.userInteractionEnabled = true;
        detail.font = [UIFont fontWithName:@"PingFangSC-Thin" size:16];
        detail.textColor = RGB(51, 51, 51);
        detail.tintColor =[UIColor clearColor];
        detail.textAlignment = NSTextAlignmentRight;
        [backImage addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(backImage.mas_right).offset(-47);
            make.centerY.mas_equalTo(backImage.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(120, 25));
        }];
        self.detail = detail;
        
        [self addSubview:backImage];
    }
    return self;
}

- (void)setViewWithImag:(UIImage *)image title:(NSString *)title access:(BOOL)access type:(int)type{
    [self.iconImage setImage:image];
    self.titleLabel.text = title;
    if (!access) {
        self.accessImg.hidden = true;
    }
}


@end
