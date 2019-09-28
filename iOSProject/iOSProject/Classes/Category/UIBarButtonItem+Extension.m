//
//  UIBarButtonItem+Extension.m
//
//
//

#import "UIBarButtonItem+Extension.h"

@interface UIBarButtonItem ()
@property (strong, nonatomic) UIView *redDotView;
@end

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //设置背景图片
    if (norImage != nil && ![norImage isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    if (higImage != nil && ![higImage isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    //设置标题
    if (title != nil && ![title isEqualToString:@""]) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:x_theme forState:UIControlStateNormal];
    }

    //监听点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (UIBarButtonItem *)leftItemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];

    //设置背景图片
    if (norImage != nil && ![norImage isEqualToString:@""]) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    if (higImage != nil && ![higImage isEqualToString:@""]) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    //设置标题
    if (title != nil && ![title isEqualToString:@""]) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:x_theme forState:UIControlStateNormal];
    }

    //监听点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (UIBarButtonItem *)rightWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //设置背景图片
    if (norImage != nil && ![norImage isEqualToString:@""]) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    if (higImage != nil && ![higImage isEqualToString:@""]) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    //设置标题
    if (title != nil && ![title isEqualToString:@""]) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:x_theme forState:UIControlStateNormal];
    }

    //监听点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
