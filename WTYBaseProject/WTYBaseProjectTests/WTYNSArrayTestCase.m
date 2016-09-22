
//
//  WTYNSArrayTestCase.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/9/10.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WTYNSArrayTestCase : XCTestCase

@end

@implementation WTYNSArrayTestCase

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}
/**
 *  -componentsSeparatedByString
 *  -componentsJoinedByString
 */
-(void)testToString {
    
    NSArray *arr = @[];
    NSString *string = [arr componentsJoinedByString:@"|"];
    // string = @"";
    NSLog(@" %@-------- %@",arr,string);
    
    arr = nil;
    string = [arr componentsJoinedByString:@"|"];
    // string = nil;
    NSLog(@" %@-------- %@",arr,string);
    
    arr = @[@"A"];
    string = [arr componentsJoinedByString:@"|"];
    // string = @"A";
    NSLog(@" %@-------- %@",arr,string);

    arr = @[@"A",@"B"];
    string = [arr componentsJoinedByString:@"|"];
    // string = @"A|B";
    NSLog(@" %@-------- %@",arr,string);
    
    //--------分解----
    NSString *joinedString = nil;
    NSArray  *components = nil;
    components = [joinedString componentsSeparatedByString:@"|"];
    // components = nil;
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"";
    components = [joinedString componentsSeparatedByString:@"|"];
    // components = @[@""];
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"A";
    components = [joinedString componentsSeparatedByString:@"|"];
    /**
     *  components = @[@"A"];
     */
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"A|B";
    components = [joinedString componentsSeparatedByString:@"|"];
    /**
     *  components = @[
     *                  @"A"
     *                  @"B"
     *                ]
     */
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"A|";
    components = [joinedString componentsSeparatedByString:@"|"];
    /**
     *  components = @[
     *                  @"A"
     *                  @""
     *                ]
     */
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"A|B|";
    components = [joinedString componentsSeparatedByString:@"|"];
    /**
     *  components = @[
     *                  @"A"
     *                  @"B"
     *                  @""
     *                ]
     */
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"|A|B|";
    components = [joinedString componentsSeparatedByString:@"|"];
    /**
     *  components = @[
     *                  @""
     *                  @"A"
     *                  @"B"
     *                  @""
     *                ]
     */
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"|||";
    components = [joinedString componentsSeparatedByString:@"|"];
    /**
     *  components = @[
     *                  @""
     *                  @""
     *                  @""
     *                  @""
     *                ]
     */
    NSLog(@"%@ ==== %@",joinedString,components);
    
    joinedString = @"|||";
    components = [joinedString componentsSeparatedByString:@""];
    /**
     *  components = @[
     *                  @"|||"
     *                ]
     */
    NSLog(@"%@ ==== %@",joinedString,components);
}
-(void)testFunctionIsRight {
    NSArray *anwser = @[];
    NSArray *selectedAnswers = @[];
    
    NSInteger count = anwser.count;
    anwser = nil;
    count = anwser.count;
    
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
    
    anwser = nil;
    selectedAnswers = nil;
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
    
    anwser = @[@"A"];
    selectedAnswers = @[@"A"];
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
    
    anwser = @[@"A"];
    selectedAnswers = @[@"B"];
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
    
    anwser = @[@"A",@"B"];
    selectedAnswers = @[@"B",@"A"];
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
    
    anwser = @[@"A",@"B"];
    selectedAnswers = @[@"B",@"C"];
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
    
    anwser = @[@"A",@"B"];
    selectedAnswers = @[@"B"];
    if ([self isRightWithModel:anwser selectedAnswer:selectedAnswers]) {
        NSLog(@"%@ == %@",anwser,selectedAnswers);
    }
}

-(BOOL)isRightWithModel:(NSArray  *)answer selectedAnswer:(NSArray *)selectedAnswers {
    
    // 答案不能为空
    if (answer == nil || answer.count == 0) {
        NSLog(@"正确答案为空");
        return NO;
    }
    
    // 选择的答案为空
    if (selectedAnswers == nil || selectedAnswers.count == 0) {
        return NO;
    }
    
    // 选择的答案个数不一至 错误
    if (answer.count != selectedAnswers.count) {
        return NO;
    }
    
    answer = [answer sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    selectedAnswers = [selectedAnswers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    if ([answer isEqualToArray:selectedAnswers]) {
        return YES;
    }else {
        return NO;
    }
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
}

@end
