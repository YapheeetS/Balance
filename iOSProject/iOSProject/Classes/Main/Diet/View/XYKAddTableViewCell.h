//
//  XYKAddTableViewCell.h
//  xyk
//
//  Created by Ss H on 2018/8/15.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYKAddTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UIImageView *rightimg;
@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@end
