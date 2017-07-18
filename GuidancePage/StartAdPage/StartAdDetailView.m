//
//  StartAdDetailView.m
//  GuidancePage
//
//  Created by dxs on 2017/7/18.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "StartAdDetailView.h"
#import <WebKit/WebKit.h>

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height

@interface StartAdDetailView ()

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIView *navContainerView;
@property (strong, nonatomic) UIProgressView *loadProgress;

@end

@implementation StartAdDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    [self addSubview:self.navContainerView];
    [self addSubview:self.webView];
    [self addSubview:self.loadProgress];
}

- (WKWebView *)webView {
    if (!_webView) {
        //初始化一个WKWebViewConfiguration对象
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;

        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60) configuration:config];
    }
    return _webView;
}

- (UIProgressView *)loadProgress {
    if (!_loadProgress) {
        _loadProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navContainerView.frame), kScreenWidth, 3)];
        _loadProgress.trackTintColor = [UIColor whiteColor];
        _loadProgress.progressTintColor = [UIColor redColor];
        [_loadProgress setProgress:0.3f animated:YES];
    }
    return _loadProgress;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton setFrame:CGRectMake(10, 25, 30, 30)];
        [_backButton.layer setMasksToBounds:YES];
        [_backButton.layer setCornerRadius:CGRectGetWidth(_backButton.frame)/2];
    }
    return _backButton;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_backButton.frame), 20, kScreenWidth - _backButton.frame.size.width * 2 - 20, CGRectGetHeight(_navContainerView.frame) - 20)];
        [_titleLab setText:@"天才篮球手"];
        [_titleLab setTextColor:[UIColor whiteColor]];
        [_titleLab setAdjustsFontSizeToFitWidth:YES];
        [_titleLab setTextAlignment:NSTextAlignmentCenter];
        [_titleLab setFont:[UIFont systemFontOfSize:19.f]];
    }
    return _titleLab;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_shareButton setFrame:CGRectMake(kScreenWidth - CGRectGetWidth(_backButton.frame) - 10, 25, 30, 30)];
        [_shareButton.layer setMasksToBounds:YES];
        [_shareButton.layer setCornerRadius:CGRectGetWidth(_shareButton.frame)/2];
    }
    return _shareButton;
}

- (UIView *)navContainerView {
    if (!_navContainerView) {
        _navContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        [_navContainerView setBackgroundColor:[UIColor redColor]];
        [_navContainerView addSubview:self.backButton];
        [_navContainerView addSubview:self.titleLab];
        [_navContainerView addSubview:self.shareButton];
    }
    return _navContainerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
