//
//  AppDelegate.m
//  GuidancePage
//
//  Created by dxs on 2017/6/30.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "StartAdController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

extern NSString *const kLastVersionKey;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    [self.window setRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    NSString* lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kLastVersionKey];
    NSString* currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if (lastVersion && [lastVersion isEqualToString:currentVersion]) {
        StartAdController *controller = [[StartAdController alloc] init];
        [controller showCustomAdvertiseAtStartAllowSkip:YES timeInterval:10.f adAllowTouch:YES adInfoDictionary:@{@"imageURL":@"http://d.hiphotos.baidu.com/zhidao/pic/item/e61190ef76c6a7eff535cd85fcfaaf51f3de6605.jpg", @"detailURL":@"https:www.baidu.com"}];
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
