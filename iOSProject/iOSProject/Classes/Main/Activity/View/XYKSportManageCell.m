//
//  XYKSportManageCell.m
//  xyk
//
//  Created by Jame on 2018/9/3.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKSportManageCell.h"


@interface XYKSportManageCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end


@implementation XYKSportManageCell
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
    [backView setImage:[UIImage imageNamed:@"sport_manage_background"]];
    [self addSubview:backView];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(125*Kwidth, 125*Kwidth));
        make.top.mas_equalTo(self.mas_top).offset(43*KHeight);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    UILabel *titleLabel= [[UILabel alloc]init];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    titleLabel.textColor = RGB(34, 34, 34);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.top.mas_equalTo(imageView.mas_bottom).offset(10*KHeight);
        make.centerX.mas_equalTo(imageView.mas_centerX);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = RGB(153, 153, 153);
    contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(40*KHeight);
        make.centerX.mas_equalTo(titleLabel.mas_centerX);
    }];
}


- (void)setData:(NSDictionary *)dataDict
{
    NSURL *imgUrl = [NSURL URLWithString:dataDict[@"motion_picture"]];
    [self.imageView sd_setImageWithURL:imgUrl];
    self.titleLabel.text = dataDict[@"motion_name"];
    self.contentLabel.text = dataDict[@"motion_content"];
    
    self.contentLabel.text = [self.contentLabel.text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    self.motionId = dataDict[@"id"];
    self.consumeCalorie = dataDict[@"consume_calorie"];
    self.motionType = dataDict[@"motion_type"];
}

@end
