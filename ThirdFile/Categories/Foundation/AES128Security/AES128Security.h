//
//  AES128Security.h
//  AES128_EN_DE
//
//  Created by 柳宣泽 on 16/3/14.
//  Copyright © 2016年 柳宣泽 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128Security : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
+ (NSString*)encryptAESData:(NSString*)string app_key:(NSString*)key ;
+ (NSString*)decryptAESData:(NSData*)data app_key:(NSString*)key ;

@end
