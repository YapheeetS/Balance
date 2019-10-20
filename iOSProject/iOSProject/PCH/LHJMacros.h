//
//  VCTMacros.h
//  VCTalk
//
//

#ifndef LHJMacros_h
#define LHJMacros_h


#define x_theme        [UIColor colorWithRed:126.0/255.0 green:170.0/255.0 blue:241.0/255.0 alpha:1]
#define x_theme2        [UIColor colorWithRed:250.0/255.0 green:129.0/255.0 blue:26.0/255.0 alpha:1]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0)

/**
 宽度的比例值
 
 @param value 值
 @return 按设备的宽度返回比例值
 */
#define xRealWidth(value) ((value / 375.0f) * [UIScreen mainScreen].bounds.size.width)

#define Kwidth SCREEN_WIDTH/375.0
#define KHeight SCREEN_HEIGHT/667.0

/** 视图弱引用 */
#define xWEAKSELF __weak typeof(self) weakSelf = self

/** 屏幕宽度 */
#define xScreenWidth [UIScreen mainScreen].bounds.size.width

/** 屏幕高度 */
#define xScreenHeight [UIScreen mainScreen].bounds.size.height

/** 下载管理工具 */
#define DownloadManager [ZFDownloadManager sharedDownloadManager]

/** 状态栏的高度 */
#define xStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

/** 导航栏的高度 */
#define xNavigationHeight (xStatusBarHeight + 44)

/** 屏幕真实宽度 */
#define xRealScreenWidth [[UIScreen mainScreen]bounds].size.width * [UIScreen mainScreen].scale

/** 屏幕真实高度 */
#define xRealScreenHeight [[UIScreen mainScreen]bounds].size.height * [UIScreen mainScreen].scale

/** 通知 */
#define xNotificationCenter [NSNotificationCenter defaultCenter]

/** 设置缓存 */
#define xCache [GVUserDefaults standardUserDefaults]

/** window */
#define xKeyWindow [UIApplication sharedApplication].keyWindow

/** VCTRealmTools */
#define xDBTools [VCTRealmTools shareTools]

/** VCTToolsManager */
#define xTools [VCTToolsManager shareTools]

/** 底部视图高度按屏幕高度适配 */
#define xTabBarHeight ((xScreenHeight > 800) ? 83 : 49)

/** 导航栏高度 */
#define xGetRectNavAndStatusHight self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height

#define xCornerRadius 4

//判断系统
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH >= 812.0)
#define IS_IPAD_768 (IS_IPAD && SCREEN_WIDTH == 768.0)
#define IS_IPAD_1024 (IS_IPAD && SCREEN_WIDTH == 1024.0)
#define IS_IPAD_834 (IS_IPAD && SCREEN_WIDTH == 834.0)


#endif /* VCTMacros_h */
