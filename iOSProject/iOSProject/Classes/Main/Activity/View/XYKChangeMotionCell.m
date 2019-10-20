//
//  XYKChangeMotionCell.m
//  xyk
//
//  Created by Jame on 2018/9/4.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKChangeMotionCell.h"

@interface XYKChangeMotionCell()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *motionLabel;
@end

@implementation XYKChangeMotionCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView
{
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backView.userInteractionEnabled = true;
    [backView setImage:[UIImage imageNamed:@"sport_change_motion_cell_background"]];
    [self addSubview:backView];
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    self.iconImage = iconImage;
    iconImage.userInteractionEnabled = true;
    [self addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55*Kwidth, 55*Kwidth));
        make.top.mas_equalTo(self.mas_top).offset(15*Kwidth);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    UILabel *motionLabel = [[UILabel alloc]init];
    [self addSubview:motionLabel];
    self.motionLabel = motionLabel;
    motionLabel.textAlignment = NSTextAlignmentCenter;
    motionLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:14];
    motionLabel.textColor = RGB(102, 102, 102);
    [motionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15*Kwidth);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
}

- (void)setData:(NSDictionary *)dataDict
{
    NSURL *imgUrl = [NSURL URLWithString:dataDict[@"motion_picture"]];
    [self.iconImage sd_setImageWithURL:imgUrl];
    self.motionLabel.text = dataDict[@"motion_name"];

}

@end
