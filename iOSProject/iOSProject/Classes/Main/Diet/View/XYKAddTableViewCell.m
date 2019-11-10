//
//  XYKAddTableViewCell.m
//  xyk
//
//  Created by Ss H on 2018/8/15.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKAddTableViewCell.h"

@implementation XYKAddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pictureImageView.layer.cornerRadius = 15.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
