//
//  WTYHTTPRequest.h
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constant.h"

@interface WTYHTTPRequest : NSObject
@property (nonatomic, copy) NSString *userInfo;
@property (nonatomic, copy) RequestFailureBlock failure;

- (NSString *)interface;
- (NSDictionary *)makeParameters;
- (void)handleResponse:(id)responseObject;
- (void)handleError:(NSError *)error;
@end
