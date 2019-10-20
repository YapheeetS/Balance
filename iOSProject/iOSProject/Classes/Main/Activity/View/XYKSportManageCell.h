//
//  XYKSportManageCell.h
//  xyk
//
//  Created by Jame on 2018/9/3.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYKSportManageCell : UICollectionViewCell

@property (nonatomic, copy) NSString *motionType;
@property (nonatomic, copy) NSString *motionId;
@property (nonatomic, copy) NSString *consumeCalorie;

- (void)setData:(NSDictionary *)dataDict;
@end
