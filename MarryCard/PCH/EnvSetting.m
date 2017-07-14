//
//  EnvSetting.m
//  PBPS-MA
//
//  Created by Mac on 2017/1/12.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import "EnvSetting.h"

@implementation EnvSetting

static int _type =  1;

static NSString* baseUrlP = @"https://pbps.bank-of-china.com/pbpsma/";
static NSString* baseUrlT = @"http://mobile.kaixinjugou.com/";
static NSString* baseUrlD = @"http://22.188.14.44:8080/pbpsma/";
//static NSString* baseUrlD = @"http://22.11.82.65:8080/pbpsma/";
//static NSString* baseUrlD = @"http://22.188.14.44/pbpsma/";
//static NSString* baseUrlD = @"http://22.188.14.43:8080/pbpsma/";
//static NSString* baseUrlD = @"http://22.188.14.43/pbpsma/";

//开发四部开发环境url
//static NSString* baseUrlFour = @"http://22.11.97.80:8088/";
static NSString* baseUrlFour = @"http://22.188.14.44:8080/pbpsma/";


//消息推送地址
static NSString *pushUrlP = @"https://smsp.mbs.boc.cn/";
static NSString *pushUrlT = @"http://22.188.32.128:38080/";
static NSString *pushUrlD = @"http://22.188.32.128:38080/";

+ (void)setEventType:(int)type {
    _type = type;
}

+ (NSString*)baseUrl {
    if (_type == 0) {
        return baseUrlP;
    }
    else if (_type == 1) {
        return baseUrlT;
    }
    else if (_type == 2) {
        return baseUrlD;
    }
    else {
        return baseUrlFour;
    }
}

+ (NSString*)pushUrl {
    if (_type == 0) {
        return pushUrlP;
    }
    else if (_type == 1) {
        return pushUrlT;
    }
    else if (_type == 2) {
        return pushUrlD;
    }
    else {
        return pushUrlT;
    }
}

@end
