//
//  AppDelegate.m
//  iOSProject
//
//  Created by Thomas on 2019/9/26.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "AppDelegate.h"
#import "VCTTabBarController.h"
#import "LoginViewController.h"
#import "LHJNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil];
    LoginViewController *login = sb.instantiateInitialViewController;
//    self.window.rootViewController = login;
    
    
    LHJNavigationController *nav = [[LHJNavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController = nav;
    
//
//    VCTTabBarController *tabBarControllerConfig = [VCTTabBarController new];
//    self.window.rootViewController = tabBarControllerConfig;
//    [tabBarControllerConfig.view addSubview:nav.view];
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

@end
