//
//  UIBarButtonItem+Extension.h
//  
//
//

#import <UIKit/UIKit.h>

//自定义导航栏item的分类

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage target:(id)target action:(SEL)action;


+(UIBarButtonItem *)leftItemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage target:(id)target action:(SEL)action;


+(UIBarButtonItem *)rightWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage target:(id)target action:(SEL)action;

@end
