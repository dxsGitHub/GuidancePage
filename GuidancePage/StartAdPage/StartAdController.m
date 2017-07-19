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

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) StartAdView *adView;
@property (strong, nonatomic) NSTimer *circlePathTimer;
@property (assign, nonatomic) NSTimeInterval countDown;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) StartAdDetailController *controller;
@end

static const char kAssociateKeyAdInfo;
static const char kAssociateKeyAdEnableSkip;
static const char kAssociateKeyAdEnableTouch;
static const char kAssociateKeyCircleBezirePath;

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
    objc_setAssociatedObject(_timer, &kAssociateKeyAdEnableSkip, [NSNumber numberWithBool:skip], OBJC_ASSOCIATION_ASSIGN);
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
    
    _circlePathTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(circleBezierpathAnimation:) userInfo:nil repeats:YES];
    [self circleBezierPathForView:(UIView*)[_adView valueForKey:@"timerLab"]];
    objc_setAssociatedObject(self, &kAssociateKeyCircleBezirePath, [NSNumber numberWithFloat:timeInterval * 10], OBJC_ASSOCIATION_ASSIGN);
    
}

- (void)timerLabShowCountdownAction:(NSTimer *)timer {

    if (_countDown == 0) {
        [_timer invalidate];
        [self disappearAnimation];
    } else {
        UILabel *lab = [_adView valueForKey:@"timerLab"];
        if ([objc_getAssociatedObject(_timer, &kAssociateKeyAdEnableSkip) boolValue]) {
            [lab setText:@"跳过"];
        } else {
            [lab setText:[NSString stringWithFormat:@"%d",(int)_countDown]];
        }
        _countDown--;
    }
    
}

- (void)circleBezierpathAnimation:(NSTimer *)timer {
    NSNumber *num = objc_getAssociatedObject(self, &kAssociateKeyCircleBezirePath);
    if (!(_shapeLayer.strokeEnd < 1.0f)) {
        [_circlePathTimer invalidate];
        _circlePathTimer = nil;
    }else {
        _shapeLayer.strokeEnd = _shapeLayer.strokeEnd + 1/[num floatValue];
    }
}

- (void)tapTimerLabAction:(UITapGestureRecognizer *)sender {
    [self disappearAnimation];
}

- (void)tapAdImageAction:(UITapGestureRecognizer *)sender {
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


-(void)circleBezierPathForView:(UIView *)view{
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    [self.shapeLayer setFrame:CGRectZero];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 3.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0.f;
    self.shapeLayer.strokeEnd = 0.f;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [view.layer addSublayer:self.shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"停止计时器，销毁self");
    [_timer invalidate];
    _timer = nil;
    
    [_circlePathTimer invalidate];
    _circlePathTimer = nil;
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
