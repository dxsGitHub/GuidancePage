//
//  AppDelegate+GuidancePage.m
//  ShareView
//
//  Created by dxs on 2017/6/6.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "AppDelegate+GuidancePage.h"
#import "GuidancePageController.h"
#import <objc/runtime.h>

const char* kGuidanceWindowKey = "kGuidanceWindowKey";
NSString * const kLastVersionKey = @"kLastVersionKey";

@implementation AppDelegate (GuidancePage)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString* lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kLastVersionKey];
        NSString* curtVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        
        if ([curtVersion compare:lastVersion] == NSOrderedDescending) {
            
            Method originMethod = class_getInstanceMethod(self.class, @selector(application:didFinishLaunchingWithOptions:));
            Method customMethod = class_getInstanceMethod(self.class, @selector(guidance_Application:didFinishLaunchingWithOptions:));
            
            method_exchangeImplementations(originMethod, customMethod);
            
        }
        
    });
}

- (BOOL)guidance_Application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.guidanceWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.guidanceWindow setWindowLevel:UIWindowLevelStatusBar + 1];
    [self.guidanceWindow makeKeyAndVisible];
    
//    GuidancePageController* controller_click = [[GuidancePageController alloc] initPagesButtonImageWithArray:@[@"GuidancePage.bundle/Image1", @"GuidancePage.bundle/Image2", @"GuidancePage.bundle/Image3", @"GuidancePage.bundle/Image4", @"GuidancePage.bundle/hidden"] enterStyle:ENTER_CLICK];
    
    GuidancePageController *controller_scroll = [[GuidancePageController alloc] initPagesButtonImageWithArray:@[@"GuidancePage.bundle/Image1", @"GuidancePage.bundle/Image2", @"GuidancePage.bundle/Image3", @"GuidancePage.bundle/Image4",@"GuidancePage.bundle/hidden"] enterStyle:ENTER_SCROLL];
    
    __weak typeof(self)weakSelf = self;
    //点击进入主界面 / 滑动进入主界面  controller_click 和 controller_scroll替换即可
    controller_scroll.hiddeGuidanceWindow = ^{
        
        NSString* curtVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:curtVersion forKey:kLastVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [weakSelf.guidanceWindow resignKeyWindow];
        [weakSelf.guidanceWindow setHidden:YES];
        weakSelf.guidanceWindow = nil;
        
    };
    
    [self.guidanceWindow setRootViewController:controller_scroll];
    
    return [self guidance_Application:application didFinishLaunchingWithOptions:launchOptions];
}


- (UIWindow *)guidanceWindow{
    
    return  objc_getAssociatedObject(self, kGuidanceWindowKey);
    
}

- (void)setGuidanceWindow:(UIWindow *)guidanceWindow {
    
    objc_setAssociatedObject(self, kGuidanceWindowKey, guidanceWindow, OBJC_ASSOCIATION_RETAIN);
    
}


@end
