//
//  CFLMyViewController.m
//  国寿金融
//
//  Created by Ss H on 2018/4/11.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "UIView+SDViewController.h"

@implementation UIView (SDViewController)

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    
    do {
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}


- (UIViewController *)getCurrentViewContoller{
    UIResponder *next = self.nextResponder;
    
    UIViewController *controller;
    
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            controller = (UIViewController *)next;
            if (controller.navigationController.childViewControllers) {
                return controller;
            }
        }
        next = next.nextResponder;
    }

    return controller;
}

@end
