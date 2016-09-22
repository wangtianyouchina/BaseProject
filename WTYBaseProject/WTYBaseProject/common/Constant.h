//
//  constant.h
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#ifndef WTYBaseProject_constant_h
#define WTYBaseProject_constant_h

typedef void(^RequestSuccessArrayBlock)(NSArray *datas);
typedef void(^RequestSuccessBlock)();
typedef void(^RequestFailureBlock)(NSError *error);
#define kWXDDomain nil


#pragma mark -
#pragma mark - 设备属性相关宏定义

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

#define iOS6Earlier ([[[UIDevice currentDevice] systemVersion] floatValue] <= 6.0)

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#endif
