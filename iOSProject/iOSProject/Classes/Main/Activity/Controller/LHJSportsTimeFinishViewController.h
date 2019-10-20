//
//  LHJSportsTimeFinishViewController.h
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHJSportsTimeFinishViewController : LHJBaseViewController
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *motionId;
@property (nonatomic, copy) NSString *totalCalorie;
@property (nonatomic, assign) NSInteger totalSeconds;
@end

NS_ASSUME_NONNULL_END
