//
//  StartAdController.m
//  GuidancePage
//
//  Created by dxs on 2017/7/15.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "StartAdController.h"

#import "StartAdView.h"

@interface StartAdController ()

@property (strong, nonatomic) StartAdView *adView;

@end

@implementation StartAdController

- (void)loadView {
    self.view = self.adView;
}

- (StartAdView *)adView {
    if (!_adView) {
        _adView = [[StartAdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_adView setBackgroundColor:[UIColor redColor]];
    }
    return _adView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)showCustomAdvertiseAtStartWithAppDescImageToScreenScale:(float)scale {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
    
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(closeLaunchAdview) userInfo:nil repeats:NO];
}

- (void)closeLaunchAdview {
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
