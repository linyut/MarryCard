//
//  NFGInterfaceConstantDefine.h
//  InternetBanking
//
//  Created by Simon on 16/6/23.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#ifndef NFGInterfaceConstantDefine_h
#define NFGInterfaceConstantDefine_h

#define BaseUrl ([EnvSetting baseUrl])
#define PUSHMESSAGEURL ([EnvSetting pushUrl])
//#define AppKey ([EnvSetting appKey])
//#define AppSecret ([EnvSetting secret])


/*************************婚车***************************/

//--------- 个人 --------------


//登录
#define URL_LOGIN [NSString stringWithFormat:@"%@%@",BaseUrl,@"Customer/Login"]

//注册
#define URL_REGISTER [NSString stringWithFormat:@"%@%@",BaseUrl,@"Customer/Register"]

//修改密码
#define URL_MODIFYPWD [NSString stringWithFormat:@"%@%@",BaseUrl,@"Customer/ModifyPwd"]



//--------- 首页 --------------





//--------- 订单 --------------





//--------- 聊天 --------------





/*************************婚车***************************/



#endif /* NFGInterfaceConstantDefine_h */
