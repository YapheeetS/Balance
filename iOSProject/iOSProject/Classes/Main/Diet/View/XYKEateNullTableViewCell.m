//
//  XYKEateNullTableViewCell.m
//  xyk
//
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
