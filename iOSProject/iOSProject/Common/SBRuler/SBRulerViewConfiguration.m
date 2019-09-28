//
//  SBRulerViewConfiguration.m
//  RulerDemo
//
//  Created by wenjie on 2018/7/10.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "SBRulerViewConfiguration.h"

static SBRulerViewConfiguration *sharedRVC = nil;
@implementation SBRulerViewConfiguration

+ (SBRulerViewConfiguration *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRVC = [[super allocWithZone:NULL] init];
        [SBRulerViewConfiguration defaultSetup];
    });
    
    return sharedRVC;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copy {
    return self;
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

///默认配置
+ (void)defaultSetup{
    sharedRVC.triangle_Color = [UIColor yellowColor];
    sharedRVC.rulerView_BGColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    sharedRVC.rulerTitle_Color = [UIColor colorWithRed:138/255.0 green:179/255.0 blue:255/255.0 alpha:1];
    sharedRVC.rulerView_H = 70.f;
    sharedRVC.rulerLong = 50.f;
    sharedRVC.rulerShort = 40.f;
    sharedRVC.trangle_W = 20.f;
    sharedRVC.rulerTitle_H = 20.f;
    sharedRVC.rulerFont = 15.f;
    sharedRVC.rulerTitle_Padding = 8.f;
    sharedRVC.rulerShort_W = 2;
    sharedRVC.rulerLong_W = 1;
    sharedRVC.red = 138;
    sharedRVC.green = 179;
    sharedRVC.blue = 255;
    sharedRVC.alpha = 1;
    sharedRVC.rulerGap = 50.f;
}
///颜色设置 健壮性处理
- (void)setRed:(CGFloat)red{
    if (red > 255) {
        red = 255;
    }
    if (red < 0) {
        red = 0;
    }
    _red = red;
}

- (void)setGreen:(CGFloat)green{
    if (green > 255) {
        green = 255;
    }
    if (green < 0) {
        green = 0;
    }
    _green = green;
}

- (void)setBlue:(CGFloat)blue{
    if (blue > 255) {
        blue = 255;
    }
    if (blue < 0) {
        blue = 0;
    }
    _blue = blue;
}

- (void)setAlpha:(CGFloat)alpha{
    if (alpha > 1) {
        alpha = 1;
    }
    if (alpha < 0) {
        alpha = 0;
    }
    _alpha = alpha;
}
@end
