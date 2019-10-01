//
//  XYKEateTableViewCell.m
//  xyk
//
//

#import "XYKEateTableViewCell.h"

@implementation XYKEateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickaddButton:(id)sender {
    self.clickadd(self.titleLabel.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
