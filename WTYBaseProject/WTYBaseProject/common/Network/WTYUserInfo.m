//
//  WTYUserInfo.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYUserInfo.h"
#import "WTYLoginModel.h"
@implementation WTYUserInfo
-(void)show {
    
    NSLog(@"show");
}
+(void)show {
    
    NSLog(@"class show");
}
+(BOOL)resolveClassMethod:(SEL)sel {

    BOOL ret = [super resolveClassMethod:sel];
    
    NSLog(@"%d --- %s",ret,__FUNCTION__);
    return ret;
}

+(BOOL)resolveInstanceMethod:(SEL)sel {
    BOOL ret = [super resolveInstanceMethod:sel];
    NSLog(@"%d --------- %s",ret,__FUNCTION__);
    return ret;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
   NSLog(@"forwardingTargetForSelector");
   
    NSString *selectorString = NSStringFromSelector(aSelector);
   
    // 将消息转发给_helper来处理
    id ret =  [super forwardingTargetForSelector:aSelector];
    NSLog(@"%@",ret);
//    if([selectorString isEqualToString:@"hello"]) {
//
//        return [[WTYLoginModel alloc] init];
//    }
    
    return ret;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];//[[NSMethodSignature alloc] init];
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"hello"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    NSLog(@"%@",sig);
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@",anInvocation);
}
@end
