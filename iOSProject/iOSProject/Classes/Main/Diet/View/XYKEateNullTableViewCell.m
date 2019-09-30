//
//  XYKEateNullTableViewCell.m
//  xyk
//
//  Created by Ss H on 2018/8/15.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKEateNullTableViewCell.h"

@implementation XYKEateNullTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)addButton:(id)sender {
    self.nofontclickAdd(self.titleLabel.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
