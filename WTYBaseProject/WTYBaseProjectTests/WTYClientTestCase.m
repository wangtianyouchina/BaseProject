//
//  WTYClientTestCase.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/4/20.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTYClient.h"
#import "WTYUserInfo.h"
@interface WTYClientTestCase : XCTestCase

@end

@implementation WTYClientTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


-(void)testCreatClient {
    WTYClient *client = [WTYClient shareInstance];
    
    XCTAssertNotNil(client,@"创建失败");
    //    XCTAssertNil(client,@"创建失败");
}
//设置变量和设置预期值
- (void)testExample1 {
    //设置变量和设置预期值
    NSUInteger a = 10;NSUInteger b = 15;
    NSUInteger expected = 24;
    //执行方法得到实际值
    NSUInteger actual = [self add:a b:b];
    //断言判定实际值和预期是否符合
    XCTAssertEqual(expected, actual,@"add方法错误！");
}
-(NSUInteger)add:(NSUInteger)a b:(NSUInteger)b{
    return a+b;
}

//性能测试
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testClint {
    WTYClient *clinet = [WTYClient shareInstance];
    NSString *username = @"sdfs";
    NSString *password = @"12345";
    XCTestExpectation *exp = [self expectationWithDescription:@"请求失败"];

    [clinet loginWithUsername:username password:password success:^(WTYUserInfo *userInfo) {
        
        NSLog(@"%@",userInfo.username);
        [exp fulfill];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
    
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
// 异步测试
- (void)testAsynExample {
    
    XCTestExpectation *exp = [self expectationWithDescription:@"这里可以是操作出错的原因描述。。。"];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        //模拟这个异步操作需要2秒后才能获取结果，比如一个异步网络请求
        sleep(2);
        //模拟获取的异步操作后，获取结果，判断异步方法的结果是否正确
        XCTAssertEqual(@"a", @"a");
        //如果断言没问题，就调用fulfill宣布测试满足
        [exp fulfill];
    }];
    
    //设置延迟多少秒后，如果没有满足测试条件就报错
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}
- (void)testThatBackgroundImageChanges {
//    XCTAssertNil([self.button backgroundImageForState:UIControlStateNormal]);
//    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(UIButton  * _Nonnull button, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [button backgroundImageForState:UIControlStateNormal] != nil;
//    }];
//    
//    [self expectationForPredicate:predicate
//              evaluatedWithObject:self.button
//                          handler:nil];
//    [self waitForExpectationsWithTimeout:20 handler:nil];
}
@end
