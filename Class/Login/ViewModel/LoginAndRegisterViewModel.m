//
//  LoginAndRegisterViewModel.m
//  MarryCard
//
//  Created by linyut on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "LoginAndRegisterViewModel.h"

@implementation LoginAndRegisterViewModel

//登陆
- (void)loginWithParam:(NSDictionary*)param success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSDictionary *error))failure
{
    NFGHTTPManager *httpMan = [NFGHTTPManager manager];
    //发起我的消息查询
    [httpMan requestPOSTURL:URL_LOGIN header:nil parametersUrl:nil parametersBody:param success:^(id responseObject) {
        NSDictionary *result = (NSDictionary*)responseObject;
        
        if (success) {
            success(result[@"otherInfo"]);
        }
    } failure:^(NSError *error) {
        //查询我的消息失败
        if (failure) {
            failure([httpMan translateErrorMsg:error]);
        }
    }];
}

//注册
- (void)registerWithParam:(NSDictionary*)param success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSDictionary *error))failure
{
    NFGHTTPManager *httpMan = [NFGHTTPManager manager];
    //发起我的消息查询
    [httpMan requestPOSTURL:URL_REGISTER header:nil parametersUrl:nil parametersBody:param success:^(id responseObject) {
        NSDictionary *result = (NSDictionary*)responseObject;
        
        if (success) {
            success(result[@"otherInfo"]);
        }
    } failure:^(NSError *error) {
        //查询我的消息失败
        if (failure) {
            failure([httpMan translateErrorMsg:error]);
        }
    }];
}

//修改密码
- (void)modifyPasswordWithParam:(NSDictionary*)param success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSDictionary *error))failure
{
    NFGHTTPManager *httpMan = [NFGHTTPManager manager];
    //发起我的消息查询
    [httpMan requestPOSTURL:URL_MODIFYPWD header:nil parametersUrl:nil parametersBody:param success:^(id responseObject) {
        NSDictionary *result = (NSDictionary*)responseObject;
        
        if (success) {
            success(result[@"otherInfo"]);
        }
    } failure:^(NSError *error) {
        //查询我的消息失败
        if (failure) {
            failure([httpMan translateErrorMsg:error]);
        }
    }];
}


@end
