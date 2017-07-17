//
//  StartAdController.m
//  GuidancePage
//
//  Created by dxs on 2017/7/15.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "StartAdController.h"

#import "StartAdView.h"
#import <objc/runtime.h>

@interface StartAdController ()

@property (strong, nonatomic) StartAdView *adView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval countDown;

@end

static const char kAssociateKey;

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
    
    if ([objc_getAssociatedObject(self, &kAssociateKey) boolValue]) {
       [[_adView valueForKey:@"timerLab"] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTimerLabAction:)]];
    }
    [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelStatusBar+1];
}

- (void)showCustomAdvertiseAtStartAllowSkip:(BOOL)skip WithTimeInterval:(NSTimeInterval)timeInterval {
    
    _countDown = timeInterval;
    objc_setAssociatedObject(self, &kAssociateKey, [NSNumber numberWithBool:skip], OBJC_ASSOCIATION_ASSIGN);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
    
    _timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerLabShowCountdownAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
    
}

- (void)timerLabShowCountdownAction:(NSTimer*)timer {

    if (_countDown == 0) {
        [_timer invalidate];
        [self disappearAnimation];
    } else {
        UILabel *lab = [_adView valueForKey:@"timerLab"];
        [lab setText:[NSString stringWithFormat:@"%d",(int)_countDown]];
        _countDown--;
    }
    
}

- (void)tapTimerLabAction:(UITapGestureRecognizer*)sender {
    [self disappearAnimation];
}

- (void)disappearAnimation {
    [UIView animateWithDuration:0.5f animations:^{
        [self.view setAlpha:0.01f];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
    }];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
