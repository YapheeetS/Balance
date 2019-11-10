

#import "KEScrollView.h"

@interface KEScrollView ()<UIScrollViewDelegate> {
    BOOL _userForceScroll;
    CGFloat _lastWidth;
}
@end

@implementation KEScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doAdditionalInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self doAdditionalInit];
}

- (void)doAdditionalInit {
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.delegate = self;
    self.scrollEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (void)setViewControllers:(NSArray *)viewControllers{
    [self setViewControllers:viewControllers andCurrenPage:0];
}

- (void)setViewControllers:(NSArray *)viewControllers andCurrenPage:(NSInteger)page{
    for (UIViewController *controller in _viewControllers) {
        if (controller.viewLoaded) {
            [controller.view removeFromSuperview];
        }
    }
    _viewControllers = viewControllers;
    self.currentPage = page;
}

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    if (self.viewControllers.count == 0) {
        return;
    }
    if (currentPage >= self.viewControllers.count) {
        currentPage = self.viewControllers.count - 1;
    }
    if (currentPage < 0) {
        currentPage = 0;
    }
    if (_currentPage < self.viewControllers.count) {
        UIViewController *controller = [self.viewControllers objectAtIndex:_currentPage];
        [controller viewWillDisappear:YES];
        [controller viewDidDisappear:YES];
    }
    _currentPage = currentPage;
    [self displayViewControllerAtPage:currentPage];
    [self setContentOffset:CGPointMake(currentPage * self.frame.size.width, 0) animated:animated];
    _userForceScroll = animated;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [self setCurrentPage:currentPage animated:NO];
}

- (void)displayViewControllerAtPage:(NSInteger)page {
    if (page < 0 || page >= self.viewControllers.count) {
        return;
    }
    if ([self.pagingDelegate respondsToSelector:@selector(pagingScrollView:willDisplayViewControllerAtIndex:)]) {
        [self.pagingDelegate pagingScrollView:self willDisplayViewControllerAtIndex:page];
    }
    UIViewController *controller = [self.viewControllers objectAtIndex:page];
    controller.view.frame = CGRectMake(page * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    if (controller.view.superview != self) {
        [controller.view removeFromSuperview];
        [self addSubview:controller.view];
        //system will call viewwillappear, so ...
    }
    else {
        [controller viewWillAppear:YES];
        [controller viewDidAppear:YES];
    }
}

- (CGFloat)pageForOffset:(CGPoint)offset {
    return (offset.x + self.frame.size.width / 2) / self.frame.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = [self pageForOffset:scrollView.contentOffset];
    self.currentPage = page;
    if ([self.pagingDelegate respondsToSelector:@selector(pagingScrollView:currentPageDidChange:)]) {
        [self.pagingDelegate pagingScrollView:self currentPageDidChange:page];
    }
    _userForceScroll = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _userForceScroll = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageInFloat = [self pageForOffset:CGPointMake(scrollView.contentOffset.x - self.frame.size.width / 2, scrollView.contentOffset.y)];
    if (!_userForceScroll) {
        if ([self.pagingDelegate respondsToSelector:@selector(pagingScrollView:currentPageDidChangeInFloat:)]) {
            [self.pagingDelegate pagingScrollView:self currentPageDidChangeInFloat:pageInFloat];
        }
    }
}

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate {
    if (delegate) {
        [super setDelegate:self];
    }
    else [super setDelegate:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentSize = CGSizeMake(self.frame.size.width * self.viewControllers.count, 0);
    if (_lastWidth != self.frame.size.width) {
        for (int i = 0; i < self.viewControllers.count; ++i) {
            UIViewController *controller = [self.viewControllers objectAtIndex:i];
            if (controller.viewLoaded) {
                CGRect f = self.bounds;
                f.origin.x = i * f.size.width;
                controller.view.frame = f;
            }
        }
        self.contentOffset = CGPointMake(self.frame.size.width * self.currentPage, 0);
        _lastWidth = self.frame.size.width;
    }
}

@end
