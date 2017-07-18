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
#import "StartAdDetailController.h"

@interface StartAdController ()

@property (strong, nonatomic) StartAdView *adView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval countDown;
@property (strong, nonatomic) StartAdDetailController *controller;

@end

static const char kAssociateKeyAdEnableSkip;
static const char kAssociateKeyAdEnableTouch;
static const char kAssociateKeyAdInfo;

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
    
    if ([objc_getAssociatedObject(self, &kAssociateKeyAdEnableSkip) boolValue]) {
       [[_adView valueForKey:@"timerLab"] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTimerLabAction:)]];
    }
    
    if ([objc_getAssociatedObject(self, &kAssociateKeyAdEnableTouch) boolValue]) {
        [[_adView valueForKey:@"adImageView"] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdImageAction:)]];
    }
    
    if (objc_getAssociatedObject(self, &kAssociateKeyAdInfo)) {
        NSDictionary *dict = objc_getAssociatedObject(self, &kAssociateKeyAdInfo);
        UIImageView *adImageView = [_adView valueForKey:@"adImageView"];
        [adImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"imageURL"]]]]];
    }
    
    
    
    [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelStatusBar+1];
}

- (void)showCustomAdvertiseAtStartAllowSkip:(BOOL)skip timeInterval:(NSTimeInterval)timeInterval adAllowTouch:(BOOL)enableTouch adInfoDictionary:(NSDictionary *)infoDic{
    
    _countDown = timeInterval;
    
    objc_setAssociatedObject(self, &kAssociateKeyAdEnableSkip, [NSNumber numberWithBool:skip], OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &kAssociateKeyAdEnableTouch, [NSNumber numberWithBool:enableTouch], OBJC_ASSOCIATION_ASSIGN);
    if (infoDic) {
        objc_setAssociatedObject(self, &kAssociateKeyAdInfo, infoDic, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
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

- (void)tapAdImageAction:(UITapGestureRecognizer*)sender {
    if (_timer) {
        _countDown = MAXFLOAT;
    }
    _controller = [[StartAdDetailController alloc] init];
    __weak NSTimer *blockTimer = _timer;
    __weak typeof(self) weakSelf = self;
    _controller.backClickBlock = ^{
        [weakSelf.view removeFromSuperview];
        [blockTimer invalidate];
    };
    [_controller showAdDetailView];
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
    NSLog(@"停止计时器，销毁self");
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
