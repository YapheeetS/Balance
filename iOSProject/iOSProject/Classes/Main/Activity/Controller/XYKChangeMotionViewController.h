//
//  XYKChangeMotionViewController.h
//  xyk
//
//  Created by Jame on 2018/9/4.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "LHJBaseViewController.h"

typedef void (^ReturnValueBlock) (NSMutableDictionary *dataDict);

@interface XYKChangeMotionViewController : LHJBaseViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@end
