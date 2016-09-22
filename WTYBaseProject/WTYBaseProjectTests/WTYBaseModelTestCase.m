//
//  WTYBaseModelTestCase.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/6/1.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTYBaseModel.h"
#import "WTYUserInfo.h"
@interface WTYBaseModelTestCase : XCTestCase

@end

@implementation WTYBaseModelTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
}

-(void)testNewModel {
    
    NSDictionary *dic = @{
                          @"username":@"wang",
                          @"age":@10
                          };
    WTYUserInfo *userInfo = [[WTYUserInfo alloc] init];
    [userInfo setValuesForKeysWithDictionary:dic];
    XCTAssert(userInfo.username != nil,@"username 不能为 nil");
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        
    }];
}

@end
