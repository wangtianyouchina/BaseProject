//
//  WTYThreadTest.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/6/12.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYThreadTest.h"
@interface WTYThreadTest()
@property(nonatomic,strong) NSArray *threads;
@end
@implementation WTYThreadTest
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)creatThreads {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10000];
    for (int i = 0; i < 1000000; i ++) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
        [arr addObject:thread];
    }
    
    self.threads = arr.copy;
    for (NSThread *thread in self.threads) {
        [thread start];
    }
}

-(void)threadAction {
    for (int i = 0; i <  1000000; i++) {
//        NSObject *obj = [[NSObject alloc] init];
        NSLog(@"-------------");
//        NSLog(@"---- %@",[NSThread currentThread]);

    }
}

@end
