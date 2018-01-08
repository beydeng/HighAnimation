//
//  AppDelegate.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/18.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TheViewOfSomeThing.h"
#import "Shijuexiaoguo.h"
#import "TransformMakeRotationViewCOntroller.h"
#import "CAShapeLayerViewController.h"
#import "AnimationViewControllerOfYin.h"
#import "AnimationViewControllerOfXian.h"
#import "TuchengTimeViewController.h"
#import "HuanCongViewController.h"
#import "BaseOfTheTimeAnimatonViewControllew.h"
#import "ChipmunkOfAnimationViewController.h"
#import "TheGaoxiaoHuituViewController.h"
#import "UIBezierPathViewController.h"
#import "HuiTuViewController.h"

@interface AppDelegate ()<UITabBarDelegate>

@property (nonatomic,strong) UITabBarController *tabBar;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    HuiTuViewController *viewRoot = [HuiTuViewController new];
    
    self.window.rootViewController = viewRoot;
    
//    AnimationViewControllerOfYin *viewRoot1 = [AnimationViewControllerOfYin new];
    
//    self.tabBar = [UITabBarController new];
//    
//    self.tabBar.viewControllers = @[viewRoot,viewRoot1];
//    self.tabBar.delegate = self;

//    self.window.rootViewController = self.tabBar;
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController

{
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.tabBar.view.layer addAnimation:transition forKey:nil];    
    
}

@end
