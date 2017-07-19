//
//  ViewController.m
//  GuidancePage
//
//  Created by dxs on 2017/6/30.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "ViewController.h"

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface ViewController ()

@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UILabel *lab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 100, 100)];
    _lab.center = self.view.center;
    [self.lab setBackgroundColor:[UIColor greenColor]];
    _lab.layer.masksToBounds = YES;
    _lab.layer.cornerRadius = 50.f;
//    [lab setCenter:self.view.center];
    _lab.text = @"主界面";
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_lab];
    
    [self circleBezierPath];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
}


-(void)circleBezierPath
{
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    [self.shapeLayer setFrame:CGRectZero];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 5.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.lab.layer addSublayer:self.shapeLayer];
}

- (void)circleAnimationTypeOne
{
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
        self.shapeLayer.strokeStart += 0.1;
    }else if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += 0.1;
    }
    
    if (self.shapeLayer.strokeEnd == 0) {
        self.shapeLayer.strokeStart = 0;
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
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
