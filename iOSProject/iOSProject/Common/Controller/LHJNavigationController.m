//
//  LHJNavigationController.m
//  LHJ
//
//

#import "LHJNavigationController.h"
#import <objc/runtime.h>

// HMFullScreenPopGestureRecognizerDelegate
@interface LHJFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation LHJFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }

    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }

    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }

    return YES;
}

@end

// LHJNavigationController
@interface LHJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LHJNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    // 设置导航控制器标题的颜色
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSForegroundColorAttributeName] = [UIColor colorFromHexCode:@"#333333"];
    [navBar setTitleTextAttributes:md];
    
    
}

+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(lhj_pushViewController:animated:));

    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)lhj_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.lhj_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.lhj_popGestureRecognizer];

        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");

        self.lhj_popGestureRecognizer.delegate = [self lhj_fullScreenPopGestureRecognizerDelegate];
        [self.lhj_popGestureRecognizer addTarget:internalTarget action:internalAction];

        // 禁用系统的交互手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }

    if (![self.viewControllers containsObject:viewController]) {
        [self lhj_pushViewController:viewController animated:animated];
    }
}

- (LHJFullScreenPopGestureRecognizerDelegate *)lhj_fullScreenPopGestureRecognizerDelegate {
    LHJFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[LHJFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;

        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = true;
        // 给每个子控制器的左上角添加一个按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem leftItemWithTitle:@"" norImage:@"nav_back" higImage:@"nav_back" target:self action:@selector(pop)];
    }

    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    [self popViewControllerAnimated:true];
}

// 1.获得手势中所有属性名
- (void)getIvarName {
    // 1.通过运行时，打印手势中的所有属性
    unsigned int count = 0;
    // 拷贝所有关于手势的属性，包含私有属性
    Ivar *ivars = class_copyIvarList([UIGestureRecognizer class], &count);
    // 遍历这个属性数组，拿到每一个属性
    NSMutableArray *ivarListArr = [NSMutableArray array];
    // 初始化一个count那么长的可变数组
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        // 获取成员变量名
        const char *ivarName = ivar_getName(ivars[i]);
        // 获取类的成员变量的类型
        //const char *ivarType = ivar_getTypeEncoding(ivars[i]);
        [mutableList addObject:[NSString stringWithUTF8String:ivarName]];
    }
    // 释放
    free(ivars);

    ivarListArr = [NSMutableArray arrayWithArray:mutableList];
}

#pragma mark - 每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }

    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }

    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }

    return YES;
}

- (UIPanGestureRecognizer *)lhj_popGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);

    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;

        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

@end
