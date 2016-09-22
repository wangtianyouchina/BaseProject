//
//  WTYBlockTest.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/5/27.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYBlockTest.h"
#import <objc/runtime.h>
static int a = 0;
typedef void(^GetClassName)(void);

@interface WTYBlockTest ()
@property(nonatomic,strong) NSObject *obj;
@property(nonatomic) NSInteger c;

@end
@implementation WTYBlockTest

{
    NSInteger globInt;
}

//+(BOOL)resolveInstanceMethod:(SEL)sel {
//    NSLog(@"222 %@",NSStringFromSelector(sel));
//    return [super resolveInstanceMethod:sel];
//}
//
//+(BOOL)resolveClassMethod:(SEL)sel {
//    NSLog(@"ddsd %@",NSStringFromSelector(sel));
//    return [super resolveClassMethod:sel];
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if(aSelector == @selector(foo:)){
//        return alternateObject;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


//- (void)forwardInvocation:(NSInvocation *)invocation
//{
//    SEL sel = invocation.selector;
//    
//    if([alternateObject respondsToSelector:sel]) {
//        [invocation invokeWithTarget:alternateObject];
//    }
//    else {
//        [self doesNotRecognizeSelector:sel];
//    }
//}

//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
//    
//    if (!signature)
//         signature = [alternateObject methodSignatureForSelector:selector];
//     return signature;
//}

-(void)longTest {
    
    NSNumber *expectNum = [NSNumber numberWithLong:-10000];
    long expect  = expectNum.unsignedLongValue;
    
    NSLog(@"%lu / 3600 = %ld",expectNum.unsignedLongValue, expectNum.unsignedLongValue/ 3600);
    
    NSLog(@"expect / 60 = %ld",expect / 60);
    expect = -100;
    
    NSLog(@"-100 / 60 = %ld",expect / 60);
    expect = -50;
    NSLog(@"-50 / 60 = %ld",expect / 60);
    expect = 61;
    NSLog(@"61 / 60 = %ld",expect / 60);
    
    expect = 51;
    NSLog(@"51 / 60 = %ld",expect / 60);
    expect = 333;
    NSLog(@"333 / 60 = %ld",expect / 60);
    
    
    
    
    
    
}
-(void)start {
    
    [self longTest];
    return;
    [self blockTest];
    globInt = 9;
     
     self.obj = [[NSObject alloc] init];
     
     IMP aa = [self methodForSelector:@selector(blockTest)];
     int b = 12;
     
     int * point = &a;
     NSLog(@"point ===== %p",point);
     NSLog(@"point ===== %p",&point);

     NSLog(@"IMP ===== %p",aa);
     NSLog(@"@selector(blockTest) ===== %p",@selector(blockTest));
     NSLog(@"@selector(blockTest) ===== %p",&@selector(blockTest));
     NSLog(@"a ===== %p",&a);
     NSLog(@"b ===== %p",&b);
     NSLog(@"c ===== %p",&_c);
     NSLog(@"&obj ===== %p",&_obj);
     NSLog(@"obj ===== %p",_obj);
}

-(void)blockTest {
    
    GetClassName name = ^{
        NSLog(@"wang");
    };
    
    /**0x108713f50
    ***0x108713f50
     *  调用block 输出log
     *
     *  @param ^ 空
     *
     *  @return 空
     */
    void (^emptyBlock)() = ^(){
        
        NSLog(@"%@",@"emptyBlcok");
    };
    
    /**
     *  调用block 输出log
     *
     *  @param ^ 有
     *
     *  @return 空
     */
    void (^sumBlock)(int,int) = ^(int a, int b) {
      
        NSLog(@"a + b = %d",a+b);
    };

    
    
    NSLog(@"--sumBlock====%p",sumBlock);
    NSLog(@"--sumBlock====%p",CFBridgingRetain(sumBlock));
    /**
     *  调用block 输出log
     *
     *  @param ^ 空
     *
     *  @return 有
     */
    
    int (^subBlock1)() = ^(){
        NSLog(@"333");
        return 333;
    };
    
    /**
     *  调用block 输出log
     *
     *  @param ^ 有
     *
     *  @return 有
     */
    int (^sumBlock2)(int,int) = ^(int a,int b ){
        NSLog(@"a +b = %d",a+b);
        return a + b;
    };
    
    emptyBlock();
    sumBlock(1,2);
    subBlock1();
    sumBlock2(2,3);
    
    NSLog(@"emptyBlock = %@",emptyBlock);
    int temp = 4;
    __block int temp2 = 5;
    NSLog(@"globInt = %ld",(long)globInt);
    ^{
        globInt = 20;
        NSLog(@"globInt = %ld",(long)globInt);

        NSLog(@"%p",&temp);
        NSLog(@"%d",temp2);
        NSLog(@"sdfsf");
    }();
}


@end
