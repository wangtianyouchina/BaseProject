//
//  WTYTestScrollView.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/8/8.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYTestScrollView.h"

@implementation WTYTestScrollView



-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *view = [super hitTest:point withEvent:event];
    
    NSLog(@"%@ %@ \n %@",view,NSStringFromCGPoint(point),event);
    
//    if ([view isKindOfClass:[ Class]]) {
    
//    }
    
    return view;
//    return view;
}
//
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
     BOOL ret = [super pointInside:point withEvent:event];
    
    NSLog(@"%d -- %@  --%@",ret  ,NSStringFromCGPoint(point),event);

    return ret;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"%s -- %@  --%@",__FUNCTION__,touches,event);
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"%s -- %@  --%@",__FUNCTION__,touches,event);

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"%s -- %@  --%@",__FUNCTION__,touches,event);

}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"%s -- %@  --%@",__FUNCTION__,touches,event);

}



@end
