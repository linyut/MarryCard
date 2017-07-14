//
//  LoginAndRegisterViewModel.h
//  MarryCard
//
//  Created by linyut on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginAndRegisterViewModel : NSObject

//登陆
- (void)loginWithParam:(NSDictionary*)param success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSDictionary *error))failure;

//注册
- (void)registerWithParam:(NSDictionary*)param success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSDictionary *error))failure;

//修改密码
- (void)modifyPasswordWithParam:(NSDictionary*)param success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSDictionary *error))failure;


@end
