//
//  VCTTabBarController.m
//
//
//

#import "VCTTabBarController.h"
#import "VCTTabBar.h"
#import "VCTTabbarButton.h"
#import "LHJBalanceViewController.h"
#import "LHJDietViewController.h"
#import "LHJActivityViewController.h"
#import "LHJProfileViewController.h"

@interface VCTTabBarController ()<VCTTabBarDelegate>
@property (nonatomic, weak) VCTTabBar *customTabBar;

@end

@implementation VCTTabBarController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    [self removeSystemitem];
}

-(void)removeSystemitem {
    
    for (UIView *view in self.tabBar.subviews) {

        if (![view isKindOfClass:[VCTTabBar class]]) {

            [view removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = false;

    // 初始化tabbar
    [self setupTabbar];
    //初始化子控制器
    [self initSubVC];
}

// !!!: 初始化tabbar
- (void)setupTabbar {
    VCTTabBar *customTabBar = [[VCTTabBar alloc] init];
    self.customTabBar = customTabBar;
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    customTabBar.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:customTabBar atIndex:99];

    [[UITabBar appearance] setBackgroundImage:[[UIImage imageWithColor:[UIColor whiteColor]] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage imageWithColor:[UIColor colorFromHexCode:@"#f0f0f0 "]] init]];
}

// !!!: 监听tabbar按钮的改变
- (void)tabBar:(VCTTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
}

// !!!: 给tabbar绑定对应的控制器
- (void)initSubVC {
    //1
    LHJBalanceViewController *home = [[LHJBalanceViewController alloc]init];
    [self setupChildVC:home Title:@"Balance" imageName:@"tab_home_nor" selectedImageName:@"tab_home_sel"];
    //2
    LHJDietViewController *valley = [[LHJDietViewController alloc]init];
    [self setupChildVC:valley Title:@"Diet" imageName:@"tab_system_nor" selectedImageName:@"tab_system_sel"];
    //3
    LHJActivityViewController *Artificial = [[LHJActivityViewController alloc]init];
    [self setupChildVC:Artificial Title:@"Activity" imageName:@"tab_subject_nor"  selectedImageName:@"tab_subject_sel"];
    //4
    LHJProfileViewController *mineVc = [[LHJProfileViewController alloc]init];
    [self setupChildVC:mineVc Title:@"Profile" imageName:@"tab_mine_nor" selectedImageName:@"tab_mine_sel"];
}

// !!!: 初始化所有子控制器
- (void)setupChildVC:(UIViewController *)childVC Title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    //1.设置标题
    childVC.title = title;
    //2.设置图片
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    //3.设置选中图片
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    //不在渲染图片
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //4.添加导航控制器
    
    LHJNavigationController *nav = [[LHJNavigationController alloc] initWithRootViewController:childVC];

    nav.navigationItem.leftBarButtonItems = nil;

    [self addChildViewController:nav];
    //5.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVC.tabBarItem];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    self.customTabBar.hidden = hidesBottomBarWhenPushed;
}

@end
