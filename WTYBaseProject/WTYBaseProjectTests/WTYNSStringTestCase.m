//
//  WTYNSStringTestCase.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/8/31.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WTYNSStringTestCase : XCTestCase

@end

@implementation WTYNSStringTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
}

#pragma mark *** String funnel methods ***

/* NSString primitives. A minimal subclass of NSString just needs to implement these two, along with an init method appropriate for that subclass. We also recommend overriding getCharacters:range: for performance.
 */
//
//@property (readonly) NSUInteger length;
//- (unichar)characterAtIndex:(NSUInteger)index;
/* The initializers available to subclasses. See further below for additional init methods.
 * 初始化 参数 符号化
 */
//- (instancetype)init
// 这个方法 归档
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder

-(void)testStringInit {
    NSString *string1 = @"wang";
    NSString *string2 = [NSString stringWithFormat:@"12"];
    unichar newChar = [string1 characterAtIndex:2];
    NSLog(@"%c",newChar);
    
    NSLog(@"%@,%@",string1,string2);
}

- (void)testPerformanceExample {
    
    [self measureBlock:^{
    }];
}

@end
