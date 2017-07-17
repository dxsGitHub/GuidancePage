//
//  ViewController.m
//  GuidancePage
//
//  Created by dxs on 2017/6/30.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    [lab setCenter:self.view.center];
    lab.text = @"主界面";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:lab];
}

- (void)viewWillAppear:(BOOL)animated {
    [self prefersStatusBarHidden];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
