//
//  XYKDownBackImageView.m
//  xyk
//
//  Created by Jame on 2018/8/30.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKDownBackImageView.h"
#import "XYKGoSportButton.h"

@implementation XYKDownBackImageView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 将点击事件在父视图的坐标转为参照按钮的坐标,这样方便确定点击是否在按钮上
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[XYKGoSportButton class]]) {
            CGPoint btnPoint = [view convertPoint:point fromView:self];
            if ([view pointInside:btnPoint withEvent:event]) {
                return view;
            }else{
                return [super hitTest:point withEvent:event];
            }
        }
    }
    return [super hitTest:point withEvent:event];
}
@end
