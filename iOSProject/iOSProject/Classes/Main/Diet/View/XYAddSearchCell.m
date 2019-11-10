//
//  XYAddSearchCell.m
//  xyk
//
//  Created by Ss H on 2018/9/1.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYAddSearchCell.h"
@interface XYAddSearchCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;


@end
@implementation XYAddSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic
{
    self.titleLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    self.hotLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"hot"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
