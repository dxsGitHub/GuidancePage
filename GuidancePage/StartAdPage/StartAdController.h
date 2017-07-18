//
//  StartAdController.h
//  GuidancePage
//
//  Created by dxs on 2017/7/15.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartAdController : UIViewController

- (void)showCustomAdvertiseAtStartAllowSkip:(BOOL)skip timeInterval:(NSTimeInterval)timeInterval adAllowTouch:(BOOL)enableTouch adInfoDictionary:(NSDictionary *)infoDic;

@end
