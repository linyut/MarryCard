//
//  EnvSetting.h
//  PBPS-MA
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define PUSHMESSAGEURL @"http://22.188.32.128:38080/"

@interface EnvSetting : NSObject

///type  0:生产环境  1:测试环境  2:开发环境 其他:开发四部
+ (void)setEventType:(int)type;
+ (NSString*)baseUrl;
+ (NSString*)pushUrl;

@end
