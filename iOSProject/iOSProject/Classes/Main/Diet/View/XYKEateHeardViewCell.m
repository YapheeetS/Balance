//
//  XYKEateHeardViewCell.m
//  xyk
//
//

#import "XYKEateHeardViewCell.h"

@implementation XYKEateHeardViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (IS_IPHONE_X) {
        self.topViewHeight.constant = 114;
        self.cardHeight.constant = 230*Kwidth;
        self.firstLabelTop.constant = -35*Kwidth;
    }else{
        self.cardHeight.constant = 230*Kwidth;
        self.firstLabelTop.constant = -35*Kwidth;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (IBAction)tobankButtonAction:(id)sender {
    self.clickToBack();
    
}
- (IBAction)toWeakButtonAction:(id)sender {
    self.clickToWeak();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
