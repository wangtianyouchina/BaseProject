//
//  WTYUserInfo.h
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYBaseModel.h"

@interface WTYUserInfo : WTYBaseModel
@property(nonatomic,strong) NSString *username;

-(void)show;
+(void)show;

-(void)hello;
@end
