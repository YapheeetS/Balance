//
//  XYKSportRecordCell.h
//  xyk
//
//  Created by Jame on 2018/9/5.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYKSportRecordCell : UIView
@property (nonatomic, strong) UILabel *detail;

- (void)setViewWithImag:(UIImage *)image title:(NSString *)title access:(BOOL)access type:(int)type;
@end
