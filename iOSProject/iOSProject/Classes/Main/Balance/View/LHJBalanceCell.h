//
//  LHJBalanceCell.h
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHJBalanceCell : UITableViewCell
@property (nonatomic, copy) NSString *consume;
@property (nonatomic, copy) NSString *intake;
- (void)reloadChart;
@end

NS_ASSUME_NONNULL_END
