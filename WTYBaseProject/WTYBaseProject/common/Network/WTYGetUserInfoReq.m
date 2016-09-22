//
//  WTYGetUserInfoReq.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYGetUserInfoReq.h"

@implementation WTYGetUserInfoReq
- (NSString *)interface
{
    //    return @"http://127.0.0.1/~apple/PHPDemo/signUp.php";
    
    return @"http://wangtianyou.wang/phpProject/login.php";
}

- (void)onResponse:(NSDictionary *)json
{
    for (NSString *key in json.allKeys) {
        NSLog(@"%@:%@",key,json[key]);
    }
    NSDictionary *userInfoDic = nil;//[json objectForKey:@"ret"];
    WTYUserInfo *userInfo = [[WTYUserInfo alloc] init];
    [userInfo setValuesForKeysWithDictionary:userInfoDic];
    userInfo.username = [json objectForKey:@"ret"];
    
    if (self.success) {
        self.success(userInfo);
    }
}

@end
