//
//  WTYRegisterUserReq.h
//  WTYBaseProject
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYHTTPRequest.h"
#import "WTYUserInfo.h"
@interface WTYRegisterUserReq : WTYHTTPRequest
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *password;

@property (nonatomic, copy) void(^success)(WTYUserInfo *userInfo);

@end
