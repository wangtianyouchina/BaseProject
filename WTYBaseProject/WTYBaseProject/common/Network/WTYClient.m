//
//  WTYClient.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYClient.h"
#import <AFNetworking.h>

#import "WTYGetUserInfoReq.h"
#import "WTYRegisterUserReq.h"

#import "WTYUserInfo.h"
#import "constant.h"

static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

static NSString * AFPercentEscapedQueryStringKeyFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFCharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kAFCharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

static NSString * AFPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}




@interface QueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (id)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding;

@end

@implementation QueryStringPair

- (id)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return AFPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding);
    } else {
        return [NSString stringWithFormat:@"%@=%@", AFPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding), AFPercentEscapedQueryStringValueFromStringWithEncoding([self.value description], stringEncoding)];
    }
}

@end



NSArray *QueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = [dictionary objectForKey:nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:QueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        NSMutableString *param = [[NSMutableString alloc] init];
        [param appendString:@"["];
        for (NSInteger i = 0; i < [array count]; i++) {
            id nestedValue = [array objectAtIndex:i];
            if ([nestedValue isKindOfClass:[NSDictionary class]]) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nestedValue options:0 error:nil];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [param appendString:jsonString];
                if (i < [array count] - 1) {
                    [param appendString:@","];
                }
            }
        }
        [param appendString:@"]"];
        [mutableQueryStringComponents addObjectsFromArray:QueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@", key], param)];
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:QueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[QueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}



@interface WTYClient ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *wdManager;
@end
@implementation WTYClient
+ (instancetype)shareInstance
{
    static WTYClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

- (instancetype)init
{
    if (self = [super init]) {
        _baseURL = nil;//kWDInterfaceBaseURL;static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
    }
    
    return self;
}

- (AFHTTPRequestOperationManager *)wdManager
{
    if (!_wdManager)
        _wdManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:_baseURL]];
    NSStringEncoding gbkEncoding = NSUTF8StringEncoding;//CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    _wdManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    _wdManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    _wdManager.responseSerializer.stringEncoding = gbkEncoding;
//    _wdManager.requestSerializer.stringEncoding = gbkEncoding;
    
    [_wdManager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        NSMutableArray *mutablePairs = [NSMutableArray array];
        for (QueryStringPair *pair in QueryStringPairsFromKeyAndValue(nil, parameters)) {
            [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:gbkEncoding]];
        }
        
        NSString *paramString = [mutablePairs componentsJoinedByString:@"&"];
//        DDLogVerbose(@"paramString = %@", paramString);
        
        return paramString;
    }];
    
    return _wdManager;
}

- (AFHTTPRequestOperation *)POST:(NSString *)interface
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSDictionary *params = [self makeParameters:parameters];
    
    AFHTTPRequestOperation *operation = [[self wdManager] POST:interface parameters:params success:success failure:failure];
    
    return operation;
}

- (NSDictionary *)makeParameters:(NSDictionary *)parameters
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    // 添加公共参数
    [param addEntriesFromDictionary:_commonParameters];
    // 添加接口参数
    [param addEntriesFromDictionary:parameters];
    
    return param;
}

//- (AFHTTPRequestOperation *)GET:(NSString *)URLString
//                     parameters:(id)parameters
//                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    NSDictionary *params = [self makeParameters:parameters];
//    
//    AFHTTPRequestOperation *operation = [[self wdManager] GET:URLString parameters:params success:success failure:failure];
//    
//    return operation;
//}



#pragma mark -
#pragma mark - User

- (void)getUserInfoWithSuccess:(void (^)(WTYUserInfo *userInfo))success failure:(RequestFailureBlock)failure
{
    WTYGetUserInfoReq *req = [[WTYGetUserInfoReq alloc] init];
    req.failure = failure;
    req.success = ^(WTYUserInfo *userInfo) {
        
        if (success) {
            success(userInfo);
        }
    };
    
    [self startRequest:req];
}
- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(WTYUserInfo *userInfo))success failure:(RequestFailureBlock)failure {
    WTYGetUserInfoReq *req = [[WTYGetUserInfoReq alloc] init];
    req.username = username;
    req.password = password;
    req.success = success;
    req.failure = failure;
    
    [self startRequest:req];
}

- (void)registerUserWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(WTYUserInfo *userInfo))success failure:(RequestFailureBlock)failure {

    WTYRegisterUserReq *req = [[WTYRegisterUserReq alloc] init];
    req.username = username;
    req.password = password;
    req.success = success;
    req.failure = failure;
    
    [self startRequest:req];
}


#pragma mark -
#pragma mark - Interfaces

- (AFHTTPRequestOperation *)startRequest:(WTYHTTPRequest *)request
{
    NSDictionary *params = [request makeParameters];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    NSString *paramsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *interfaceURL = [request interface];
//    DDLogVerbose(@"Post %@ URL = %@: param = %@", NSStringFromClass([request class]), interfaceURL, paramsString);
    
    AFHTTPRequestOperation * operation = [self POST:interfaceURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [request handleResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [request handleError:error];
    }];
    
    return operation;
}


@end
