//
//  LHJBaseViewController.h
//  LHJBaseViewController
//
//

#import <UIKit/UIKit.h>
@class VCTPayView;
@interface LHJBaseViewController : UIViewController
/**
 判断是否有网络

 @param completion 回调状态
 */
- (void)getNetworkStatus:(void (^)(bool status))completion;

/**
 设置默认状态栏
 */
- (void)setDefaultStatusBar;

/**
 设置高亮状态栏
 */
- (void)setLightStatusBar;
@end
