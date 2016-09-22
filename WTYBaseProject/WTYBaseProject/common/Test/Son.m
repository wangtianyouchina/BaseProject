

//
//  Son.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/6/15.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "Son.h"

@implementation Son
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(Class)class {
    return [Son class];
}

+(Class)class {
    return [[[Father alloc] init] class];
}

-(void)start {
    
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
    
    NSLog(@"%@",[self description]);
    NSLog(@"%@",[self debugDescription]);
}

+ (NSUInteger)hash {
   NSUInteger hash = [super hash];
    NSLog(@"hash = %lu",(unsigned long)hash);
    return hash;
}

@end
