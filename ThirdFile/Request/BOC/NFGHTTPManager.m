//
//  NFGHTTPManager.m
//  InternetBanking
//
//  Created by Mark on 16/6/30.
//  Copyright © 2016年 胡正好. All rights reserved.
//

#import "NFGHTTPManager.h"
//#import "LoginInstance.h"


static NFGHTTPManager *_instanceSingle = nil;

@implementation NFGHTTPManager


+ (instancetype )manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceSingle = [[self alloc] init];
    });

    return _instanceSingle;

}

- (AFHTTPSessionManager*)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    
    return _sessionManager;
}

- (NSURLSessionTask*)requestPOSTURL2:(NSString *)postUrl
                             header:(NSDictionary *)header
                      parametersUrl:(NSDictionary *)parametersUrl
                     parametersBody:(NSDictionary *)parametersBody
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    
    NSString *urlString = nil;
    if (parametersUrl && [parametersUrl count]>0)
    {
        urlString = [self serializeURL:postUrl params:parametersUrl];
    }
    else
    {
        urlString = postUrl;
    }
    
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer new];
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.sessionManager.requestSerializer.timeoutInterval = 60.0;
    
    self.sessionManager.securityPolicy.allowInvalidCertificates = NO;
    
    if (header) {
        [self.sessionManager.requestSerializer setCustomValueForHTTPHeaderDict:header];
    }else{
        [self.sessionManager.requestSerializer setCustomValueForHTTPHeaderDict:[self constructPostHeader]];
    }
    
    NSLog(@"post url:%@",postUrl);
    NSLog(@"headers:%@ ",self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"postBody:%@",parametersBody);
    
    NSURLSessionTask *task = [self.sessionManager POST:urlString parameters:parametersBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self printResponse:responseObject withUrl:urlString];
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {//返回类型错误报错处理
            NSError *error = [self coustructBusinessErrorWithErrorCode:@"[APP]" withErrorMsg:@"数据解析错误！"];
            if (failure) failure(error);
        }
        else {//返回数据类型正确
            NSDictionary *responseDict = responseObject;
            NSString *errorCode = responseDict[@"flag"];//实际返回的错误码
            if (errorCode.length == 0 ) {//正常数据
                if (success) success(responseObject);
            }
            else {//异常数据处理
                NSString *errorMsg = responseDict[@"msg"];
                NSError *error = [self coustructBusinessErrorWithErrorCode:errorCode withErrorMsg:errorMsg];
                if ([errorCode isEqualToString:@"MA-000005"] || [errorCode isEqualToString:@"MA-000003"] || [errorCode isEqualToString:@"MA-000006"] || [errorCode isEqualToString:@"MA-000008"] || [errorCode isEqualToString:@"MA-000010"]) {
//                    [[LoginInstance shareInstance] forceLogout];
                }
                else if ([errorCode isEqualToString:@"MA-HU0001"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExplainForTimeOut" object:nil];
                }
                if (failure) failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        if (failure) {
            failure(error);
        }
        NSLog(@"error: %@",error);
        
    }];
    
    return task;
}

- (NSURLSessionTask*)requestPOSTURL:(NSString *)postUrl
                header:(NSDictionary *)header
         parametersUrl:(NSDictionary *)parametersUrl
        parametersBody:(NSDictionary *)parametersBody
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure
{
    
    NSString *urlString = nil;
    if (parametersUrl && [parametersUrl count]>0)
    {
        urlString = [self serializeURL:postUrl params:parametersUrl];
    }
    else
    {
        urlString = postUrl;
    }

    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    self.sessionManager.requestSerializer.timeoutInterval = 60.0;

    self.sessionManager.securityPolicy.allowInvalidCertificates = NO;

    if (header) {
        [self.sessionManager.requestSerializer setCustomValueForHTTPHeaderDict:header];
    }else{
        [self.sessionManager.requestSerializer setCustomValueForHTTPHeaderDict:[self constructPostHeader]];
    }
    
    NSLog(@"post url:%@",postUrl);
    NSLog(@"headers:%@ ",self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"postBody:%@",parametersBody);

    NSURLSessionTask *task = [self.sessionManager POST:urlString parameters:parametersBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self printResponse:responseObject withUrl:urlString];
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {//返回类型错误报错处理
            NSError *error = [self coustructBusinessErrorWithErrorCode:@"[APP]" withErrorMsg:@"数据解析错误！"];
            if (failure) failure(error);
        }
        else {//返回数据类型正确
            NSDictionary *responseDict = responseObject;
            NSString *errorCode = responseDict[@"flag"];//实际返回的错误码
            if ([errorCode isEqualToString:@"0000000"]) {//正常数据
                if (success) success(responseObject);
            }
            else {//异常数据处理
                NSString *errorMsg = responseDict[@"msg"];
                NSError *error = [self coustructBusinessErrorWithErrorCode:errorCode withErrorMsg:errorMsg];
                if ([errorCode isEqualToString:@"MA-000005"] || [errorCode isEqualToString:@"MA-000003"] || [errorCode isEqualToString:@"MA-000006"] || [errorCode isEqualToString:@"MA-000008"] || [errorCode isEqualToString:@"MA-000010"]) {
//                    [[LoginInstance shareInstance] forceLogout];
                }
                else if ([errorCode isEqualToString:@"MA-HU0001"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExplainForTimeOut" object:nil];
                }
                if (failure) failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        if (failure) {
            failure(error);
        }
        NSLog(@"error: %@",error);
        
    }];
    
    return task;
}

- (NSURLSessionTask*)requestPOSTURL:(NSString *)postUrl
                             header:(NSDictionary *)header
                     parametersBody:(NSDictionary *)parametersBody
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure {
    NSURLSessionTask * task = [self requestPOSTURL:postUrl header:header parametersUrl:nil parametersBody:parametersBody success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return task;
}

//构建业务逻辑错误
- (NSError*)coustructBusinessErrorWithErrorCode:(NSString*)errorCode withErrorMsg:(NSString*)errorMsg {
    NSDictionary *businessLogicErrorInfo = @{KErrorCode:NOTNIL(errorCode),KErrorMessage:NOTNIL(errorMsg)};
    return [[NSError alloc] initWithDomain:kNFGSDKErrorDomain code:-1 userInfo:businessLogicErrorInfo];
}

//打印返回报文
- (void)printResponse:(id)response withUrl:(NSString*)urlString {
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = response;
        id description = [dict description];
        if (description) {
            NSLog(@"%@返回报文：%@",urlString,description);
        }
        else {
            NSLog(@"%@返回报文：%@",urlString,dict);
        }
    }
    else {
        NSLog(@"返回报文：%@",response);
    }
}

- (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
    NSURL* parsedURL = [NSURL URLWithString:baseURL];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator])
    {
        if (([[params objectForKey:key] isKindOfClass:[UIImage class]])
            ||([[params objectForKey:key] isKindOfClass:[NSData class]])){
            continue;
        }
        NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL, /* allocator */
                                                                                                        (CFStringRef)[params objectForKey:key],
                                                                                                        NULL, /* charactersToLeaveUnescaped */
                                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                        kCFStringEncodingUTF8));
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

//构建公共报文头
- (NSDictionary*)constructPostHeader {
    NSString *sessionID = @"";
    NSString *uid = @"";
//    NSString *userId = @"";
//    LoginInstance *instance = [LoginInstance shareInstance];
//    if (instance.isLogin) {
//        sessionID = [@"JSESSIONID=" stringByAppendingString:instance.userInfo.sessionid];
//        uid = instance.userInfo.uid;
////        userId = instance.userInfo.userID;
//    }
    NSDictionary *formatRequestHeader = @{@"Tel":@"13900000000",
                                          @"uid":uid,
                                          @"cookie":sessionID
                                          };
    
    return formatRequestHeader;
}

- (NSDictionary*)translateErrorMsg:(NSError*)error {
    if (error.code == -1) {//业务逻辑错误信息
        if (error.userInfo) {
            return error.userInfo;
        }
    }
    
    NSNumber *code = [NSNumber numberWithInteger:error.code];
    NSString *errorCode = [code stringValue];
    NSString *errorMessage = [error localizedDescription];
    
    if ([errorMessage isEqualToString:@"Could not connect to the server."]) {
        errorMessage = @"无法连接服务器!";
    }else if([errorMessage isEqualToString:@"The request timed out."])
    {
        errorMessage = @"连接服务器超时!";
    }else if ([errorMessage isEqualToString:@"The Internet connection appears to be offline."])
    {
        errorMessage = @"网络链接失败，请检查网络";
    }else if ([errorMessage isEqualToString:@"The network connection was lost."])
    {
        errorMessage = @"网络链接失败，请检查网络";
    }
    
    return @{KErrorCode:errorCode,KErrorMessage:errorMessage};
}

- (void)cancelAllDataTasks {
    NSArray *dataTasks = self.sessionManager.dataTasks;
    for (NSURLSessionTask *task in dataTasks) {
        [task cancel];
    }
}

- (void)cancelLastDataTask {
    NSArray *dataTasks = self.sessionManager.dataTasks;
    NSURLSessionTask *task = dataTasks.lastObject;
    [task cancel];
}

@end
