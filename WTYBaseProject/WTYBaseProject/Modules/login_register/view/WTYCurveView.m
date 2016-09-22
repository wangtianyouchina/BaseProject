//
//  WTYCurveView.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/7/5.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYCurveView.h"

@implementation WTYCurveView

- (void)drawRect:(CGRect)rect {
    NSMutableArray *pointArr = [@[] mutableCopy];
    for (int i = -200000; i < self.count; i ++) {
        CGPoint point = CGPointMake((i/1000.00)+200, (i/1000.00)*(i/100.00) + 250);
        [pointArr addObject:[NSValue valueWithCGPoint:point]];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
//    CGContextMoveToPoint(context, 0, 0);  //起点坐标
    CGPoint startPoint = [pointArr.firstObject CGPointValue];
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    for (int i = 0;i < pointArr.count; i ++) {
        if (i != 0) {
            CGPoint midPoint = [pointArr[i] CGPointValue];
            CGContextAddLineToPoint(context, midPoint.x, midPoint.y);   //终点坐标

        }
    }
    CGContextStrokePath(context);
}


@end
