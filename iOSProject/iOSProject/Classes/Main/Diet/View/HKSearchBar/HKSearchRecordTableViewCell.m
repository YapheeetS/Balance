//
//  HKSearchRecordTableViewCell.m
//  阿甘汇客
//
//  Created by 卢安林 on 16/9/9.
//  Copyright © 2016年 YHH. All rights reserved.
//

#import "HKSearchRecordTableViewCell.h"

@implementation HKSearchRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *timeLogo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 15, 15)];
        [timeLogo setImage:[UIImage imageNamed:@"history"]];
        [self.contentView addSubview:timeLogo];
        
        self.labeText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLogo.frame)+10, 15,self.frame.size.width-115, 15)];
        self.labeText.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.labeText];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
-(void)layoutSubviews{

for (UIView *subView in self.subviews) {
    if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
        // 拿到subView之后再获取子控件
        UIView *deleteConfirmationView = subView.subviews[0];
        //改背景颜色
        deleteConfirmationView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:42.0/255.0 blue:62.0/255.0 alpha:1.0];
        for (UIView *deleteView in deleteConfirmationView.subviews) {
            NSLog(@"%@",deleteConfirmationView.subviews);
            UIImageView *deleteImage = [[UIImageView alloc] init];
            deleteImage.contentMode = UIViewContentModeScaleAspectFit;
            deleteImage.image = [UIImage imageNamed:@"删除"];
            deleteImage.frame = CGRectMake(0, 0, deleteView.frame.size.width, deleteView.frame.size.height);
            [deleteView addSubview:deleteImage];
        }
    }
  }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
