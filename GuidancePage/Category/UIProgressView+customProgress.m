//
//  UIProgressView+customProgress.m
//  GuidancePage
//
//  Created by dxs on 2017/7/18.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "UIProgressView+customProgress.h"

@implementation UIProgressView (customProgress)

- (void)drawRect:(CGRect)rect {
    //路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //线宽
    path.lineWidth = 3.f;
    //颜色
    [[UIColor redColor] set];
    //拐角
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - 3.f) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [path addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * self.progress clockwise:YES];
    //连线
    [path stroke];
}

@end
