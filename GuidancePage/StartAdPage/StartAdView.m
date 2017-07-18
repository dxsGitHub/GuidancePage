//
//  StartAdView.m
//  GuidancePage
//
//  Created by dxs on 2017/7/15.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "StartAdView.h"
#import "UIProgressView+customProgress.h"

#define kLabWidth                     30
#define kLabMarginToSuperView         20
#define kAppDescScaleToScreen         1/5.f
#define kContainerScaleToScreen    4/5.f

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height


@interface StartAdView ()

@property (strong, nonatomic) UILabel *timerLab;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIImageView *adImageView;
@property (strong, nonatomic) UIImageView *appDescImageView;
@property (strong, nonatomic) UIProgressView *timerProgress;

@end

@implementation StartAdView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configLayoutSubviews];
    }
    return self;
}

- (UILabel *)timerLab {
    if (!_timerLab) {
        _timerLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - kLabMarginToSuperView - kLabWidth, CGRectGetMinY(self.frame) + kLabMarginToSuperView, kLabWidth, kLabWidth)];
        [_timerLab.layer setMasksToBounds:YES];
        [_timerLab setUserInteractionEnabled:YES];
        [_timerLab setAdjustsFontSizeToFitWidth:YES];
        [_timerLab setTextColor:[UIColor whiteColor]];
        [_timerLab.layer setCornerRadius:kLabWidth/2];
        [_timerLab setFont:[UIFont systemFontOfSize:18]];
        [_timerLab setTextAlignment:NSTextAlignmentCenter];
        [_timerLab setBackgroundColor:[UIColor darkGrayColor]];
    }
    return _timerLab;
}

- (UIProgressView *)timerProgress {
    if (!_timerProgress) {
        _timerProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_timerLab.frame), CGRectGetMinY(_timerLab.frame), CGRectGetWidth(_timerLab.frame), CGRectGetHeight(_timerLab.frame))];
        _timerProgress.progress = 0.3f;
    }
    return _timerProgress;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * kContainerScaleToScreen)];
        [_containerView addSubview:self.adImageView];
        [_containerView addSubview:self.timerLab];
//        [_containerView addSubview:self.timerProgress];
    }
    return _containerView;
}

- (UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] initWithFrame:_containerView.frame];
        [_adImageView setContentMode:UIViewContentModeScaleToFill];
        [_adImageView setUserInteractionEnabled:YES];
    }
    return _adImageView;
}

- (UIImageView *)appDescImageView {
    if (!_appDescImageView) {
        _appDescImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight * kContainerScaleToScreen, kScreenWidth, kScreenHeight * kAppDescScaleToScreen)];
        [_appDescImageView setImage:[UIImage imageNamed:@"bottom"]];
    }
    return _appDescImageView;
}

- (void)configLayoutSubviews {
    [self addSubview:self.appDescImageView];
    [self addSubview:self.containerView];
}

@end
