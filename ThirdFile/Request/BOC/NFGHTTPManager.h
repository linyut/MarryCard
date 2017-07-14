//
//  NFGHTTPManager.h
//  InternetBanking
//
//  Created by Mark on 16/6/30.
//  Copyright © 2016年 胡正好. All rights reserved.
//


#import "AFNetworking.h"

@interface NFGHTTPManager : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

+ (instancetype)manager;

- (NSURLSessionTask*)requestPOSTURL2:(NSString *)postUrl
                              header:(NSDictionary *)header
                       parametersUrl:(NSDictionary *)parametersUrl
                      parametersBody:(NSDictionary *)parametersBody
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

/*
    header          如果有需要自定义报文头则传入自定义报文头，如果使用公共报文头则传入nil
    postUrl         输入请求路径地址
    parametersUrl   新增用户授权信息（容器）接口调用时候传入参数，和postUrl拼接上送，如果不需要则传入nil
    parametersBody  接口上送报文体
    success         请求成功返回
    failure         请求失败返回
 */

- (NSURLSessionTask*)requestPOSTURL:(NSString *)postUrl
                header:(NSDictionary *)header
         parametersUrl:(NSDictionary *)parametersUrl
            parametersBody:(NSDictionary *)parametersBody
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

/*
 header          如果有需要自定义报文头则传入自定义报文头，如果使用公共报文头则传入nil
 postUrl         输入请求路径地址
 parametersBody  接口上送报文体
 success         请求成功返回
 failure         请求失败返回
 */

- (NSURLSessionTask*)requestPOSTURL:(NSString *)postUrl
                             header:(NSDictionary *)header
                     parametersBody:(NSDictionary *)parametersBody
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

- (NSDictionary*)translateErrorMsg:(NSError*)error;

- (NSDictionary*)constructPostHeader;

- (void)cancelAllDataTasks;
- (void)cancelLastDataTask;

@end
