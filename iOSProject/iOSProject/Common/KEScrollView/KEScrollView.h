

#import <UIKit/UIKit.h>
#import "UIView+SDViewController.h"

@class KEScrollView;

@protocol KEScrollViewDelegate <NSObject>

@optional
- (void)pagingScrollView:(KEScrollView *)scrollView willDisplayViewControllerAtIndex:(NSInteger)index;
- (void)pagingScrollView:(KEScrollView *)scrollView currentPageDidChange:(NSUInteger)page;
- (void)pagingScrollView:(KEScrollView *)scrollView currentPageDidChangeInFloat:(CGFloat)floatInPage;

@end

@interface KEScrollView : UIScrollView

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, weak) id<KEScrollViewDelegate> pagingDelegate;

- (void)setViewControllers:(NSArray *)viewControllers andCurrenPage:(NSInteger)page;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
