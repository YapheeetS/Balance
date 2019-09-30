//
//  XYKEateNullTableViewCell.h
//  xyk
//
//  Created by Ss H on 2018/8/15.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^noEateClickAdd) (NSString *title);
@interface XYKEateNullTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *qkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (nonatomic,copy)noEateClickAdd nofontclickAdd;
@end
