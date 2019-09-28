//
//  LHJNavigationController.h
//  LHJ
//
//

#import <UIKit/UIKit.h>

@interface LHJNavigationController : UINavigationController
/// 自定义全屏拖拽返回手势
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *popGestureRecognizer;

@end
