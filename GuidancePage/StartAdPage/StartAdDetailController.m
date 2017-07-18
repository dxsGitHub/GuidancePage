//
//  StartAdDetailController.m
//  GuidancePage
//
//  Created by dxs on 2017/7/18.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "StartAdDetailController.h"

#import <WebKit/WebKit.h>
#import "StartAdDetailView.h"

@interface StartAdDetailController ()<WKNavigationDelegate,WKUIDelegate>

@property (strong, nonatomic) StartAdDetailView *adDetailView;

@end

@implementation StartAdDetailController

- (void)loadView {
    self.view = self.adDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[_adDetailView valueForKey:@"backButton"] addTarget:self action:@selector(backButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [[_adDetailView valueForKey:@"shareButton"] addTarget:self action:@selector(shareButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    WKWebView *webView = [_adDetailView valueForKey:@"webView"];
    [webView setUIDelegate:self];
    [webView setNavigationDelegate:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (StartAdDetailView *)adDetailView {
    if (!_adDetailView) {
        _adDetailView = [[StartAdDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _adDetailView;
}

- (void)showAdDetailView {
    [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.view];
}

- (void)backButtonClickAction:(UIButton *)sender {
    [self disappearAnimation];
    if (self.backClickBlock) {
        self.backClickBlock();
    }
}

- (void)shareButtonClickAction:(UIButton *)sender {
    NSLog(@"点击了分享按钮");
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [[_adDetailView valueForKey:@"loadProgress"] setProgress:0.5f animated:YES];
    NSLog(@"WKWebView开始加载");
    
}

// 页面内容开始收到返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    [[_adDetailView valueForKey:@"loadProgress"] setProgress:0.9f animated:YES];
    NSLog(@"WKWebView收到内容");
}



// 页面内容加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [[_adDetailView valueForKey:@"loadProgress"] setProgress:1.0f animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[_adDetailView valueForKey:@"loadProgress"] removeFromSuperview];
    });
    
    NSLog(@"WKWebView导航完成");
}

// 页面加载数据失败时会调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"WKWebView加载数据失败");
}


- (void)disappearAnimation {
    [UIView animateWithDuration:0.5f animations:^{
        [self.view setAlpha:0.01f];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"已经销毁");
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
