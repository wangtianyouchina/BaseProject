//
//  WTYHTTPRequest.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYHTTPRequest.h"
#import <objc/runtime.h>
#import "constant.h"

@implementation WTYHTTPRequest
- (NSDictionary *)makeParameters
{
    NSMutableDictionary *dictionaryFormat = [NSMutableDictionary dictionary];
    
    // 取得当前类类型
    Class cls = [self class];
    
    unsigned int ivarsCnt = 0;
    // 获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    // 遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如@property(retain) NSString *abc;则key == _abc;
        if ([key hasPrefix:@"_"]) {
            key = [key substringFromIndex:1];
        }
        
        if ([key compare:@"success"] == NSOrderedSame) {
            // 回调函数不作为参数
            continue;
        }
        
        // 获取变量值
        id value = [self valueForKey:key];
        
        // 取得变量类型
        // 通过type[0]可以判断其具体的内置类型
        //        const char *type = ivar_getTypeEncoding(ivar);
        
        if (value)
        {
            if (![value isKindOfClass:[NSArray class]]) {
                [dictionaryFormat setObject:value forKey:key];
            }
            else {
                NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[value count]];
                
                for (NSObject *obj in value) {
                    NSDictionary *dic = nil;//[obj dictionaryRecordPropertyWithIgnore:@"success"];
                    [array addObject:dic];
                }
                
                [dictionaryFormat setObject:array forKey:key];
            }
        }
    }
    return dictionaryFormat;
}

- (void)handleResponse:(id)responseObject
{
//    DDLogVerbose(@"%@ Response Type = %@ = %@", NSStringFromClass([self class]), NSStringFromClass([responseObject class]), responseObject);
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *json = responseObject;
        NSInteger code = [[json objectForKey:@"status"] intValue];
        
        if (code == 0) {
            @try {
                [self onResponse:json];
            }
            @catch (NSException *exception) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self handleProtocolError];
                });
            }
        }
        else {
            NSString *errorMessage = [json objectForKey:@"err"];
           // NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey];
            NSError *error = nil;//[NSError errorWithDomain:kWXDDomain code:code userInfo:userInfo];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (![self handleCommonError:error]) {
                    
                }
                [self onError:error];
            });
        }
    }
    else if ([responseObject isKindOfClass:[NSData class]]) {
        // Wanggou接口
        NSStringEncoding gbkEncoding = NSUTF8StringEncoding;//CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:gbkEncoding];
        
//        NSRange beginRange = [responseString rangeOfString:@"({"];
//        NSRange endRange = [responseString rangeOfString:@"})"];
//        
//        NSRange range = NSMakeRange(beginRange.location + 2, endRange.location - beginRange.location - 2);
//        
//        NSString *jsonString = [[responseString substringWithRange:range] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//        
//        NSString *fixedString = [self fixJSONString:jsonString];
//        //DDLogCDebug(@"fixedString=%@", fixedString);
//        
//        NSData *jsonData = [fixedString dataUsingEncoding:NSUTF8StringEncoding];
//        
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        
        if (jsonDic) {
            [self onResponse:jsonDic];
        }
        else {
            //DDLogCDebug(@"Error=%@", error.localizedDescription);
            
            NSString *errorMessage = @"网购接口错误，请联系客服";
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:kWXDDomain code:-1 userInfo:userInfo];
            [self onError:error];
        }
    }
    else {
        NSString *errorMessage = @"接口返回空数据，请联系客服";
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey];
        NSError *error = nil;//[NSError errorWithDomain:kWXDDomain code:-1 userInfo:userInfo];
        [self onError:error];
    }
}

- (NSString *)fixJSONString:(NSString *)jsonString
{
    NSMutableString *fixedString = [[NSMutableString alloc] initWithString:@"{"];
    NSArray *array = [jsonString componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < [array count]; i++) {
        NSString *item = [array objectAtIndex:i];
        
        NSArray *itemArray = [item componentsSeparatedByString:@":"];
        if ([itemArray count] == 2)
        {
            if (i < [array count] - 1) {
                [fixedString appendFormat:@"\"%@\":%@, ", [itemArray objectAtIndex:0], [itemArray objectAtIndex:1]];
            }
            else {
                [fixedString appendFormat:@"\"%@\":%@", [itemArray objectAtIndex:0], [itemArray objectAtIndex:1]];
            }
        }
        else
        {
            NSRange range = [item rangeOfString:@"StepRemark:"];
            if(range.location != NSNotFound)
            {
                NSString *stepStr = [item substringFromIndex:10];
                [fixedString appendFormat:@"\"StepRemark\"%@", stepStr];
            }
        }
    }
    
    [fixedString appendString:@"}"];
    
    return fixedString;
}

- (BOOL)handleCommonError:(NSError *)error
{
    NSInteger code = error.code;
    /*
    switch (code) {
        case 1:
            // 未登录
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkDidNotLoggedNotification object:error];
            break;
            
        case 3840:
        {
            // 返回的数据无法解析为JSON
            NSString *errorMessage = @"数据无法解析为JSON，请检查接口返回数据是否正确。";
            NSInteger code = 3840;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:kWXDDomain code:code userInfo:userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkInvalidJSONDataNotification object:error];
        }
            break;
            
        case 10000: // 登录接口调用异常
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkLoginInterfaceErrorNotification object:error];
            break;
            
        case 10008: // 参数异常
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkParametersErrorNotification object:error];
            break;
            
        case 10015: // 没有权限调用该接口
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkPermissionDeniedNotification object:error];
            break;
            
        default:
            // 不是全局错误
            return NO;
    }
     */
    
    return YES;
}

- (void)handleProtocolError
{
    // 协议错误
    NSString *errorMessage = @"协议错误，请检查接口返回数据是否正确。";
    NSInteger code = -1;
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:kWXDDomain code:code userInfo:userInfo];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkProtocolErrorNotification object:error];
}

- (void)handleError:(NSError *)error
{
    [self onError:error];
}

#pragma mark -
#pragma mark - Virtual

- (NSString *)interface
{
    return nil;
}

- (void)onResponse:(NSDictionary *)json
{
    
}

- (void)onError:(NSError *)error
{
    if (self.failure) {
        self.failure(error);
    }
}

@end
