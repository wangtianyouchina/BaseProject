//
//  WTYClient.h
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTYHTTPRequest.h"

@class WTYUserInfo;
@interface WTYClient : NSObject
@property(nonatomic,copy) NSString *baseURL;
@property (nonatomic, copy) NSDictionary *commonParameters;

+ (instancetype)shareInstance;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(WTYUserInfo *userInfo))success failure:(RequestFailureBlock)failure;
- (void)registerUserWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(WTYUserInfo *userInfo))success failure:(RequestFailureBlock)failure;
@end
