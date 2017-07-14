//
//  UserInfoModel.h
//  VitalityBOC
//
//  Created by tk on 16/12/22.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : BaseIBObject<NSSecureCoding>

@property (nonatomic,copy) NSString *birthDay;//生日
@property (nonatomic,copy) NSString *businessTel;//办公电话
@property (nonatomic,copy) NSString *emailAddress;//电子邮件
@property (nonatomic,copy) NSString *headPortrait;//
@property (nonatomic,copy) NSString *IDCardNo;//身份证号
@property (nonatomic,copy) NSString *mobilePhone;//手机号
@property (nonatomic,copy) NSString *nation;//国家
@property (nonatomic,copy) NSString *nativePlace;//本地地址
@property (nonatomic,copy) NSString *organizationName;//组织名称
@property (nonatomic,copy) NSString *politicsStatus;//政治面貌
@property (nonatomic,copy) NSString *sex;//性别
@property (nonatomic,copy) NSString *userName;//用户名
@property (nonatomic,copy) NSString *uid;//EHR号
@property (nonatomic,copy) NSString *sessionid;//sessionid
@property (nonatomic,copy) NSString *content;//首次登陆返回的提示语
@property (nonatomic,copy) NSString *userID;//userid

@end
