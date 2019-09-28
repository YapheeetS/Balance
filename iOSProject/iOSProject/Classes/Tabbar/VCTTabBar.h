//
//  VCTabBar.h
//
//
//

#import <UIKit/UIKit.h>
#import "VCTTabbarButton.h"
@class VCTTabBar;
@protocol VCTTabBarDelegate <NSObject>

@optional
- (void)tabBar:(VCTTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabBardidPlusButton:(VCTTabBar *)tabBar;
@end

@interface VCTTabBar : UIView
@property (weak, nonatomic) id<VCTTabBarDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *tabBarButtons;
@property (weak, nonatomic) VCTTabbarButton *selectedButton;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

/**
 选中某个button

 @param index 索引
 */
- (void)setSelectButtonAtIndex:(NSInteger)index;

@end
