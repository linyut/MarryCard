//
//  AES128Security.m
//  AES128_EN_DE
//
//  Created by 柳宣泽 on 16/3/14.
//  Copyright © 2016年 柳宣泽 All rights reserved.
//

#import "AES128Security.h"
#import "MyGTMBase64.h"
#import "NSData+AESCrypt_iOS.h"
@implementation AES128Security

+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [MyGTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}


+(NSString*)decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [MyGTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [MyGTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+(NSString*)decodeBase64Data:(NSData *)data {
    data = [MyGTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string app_key:(NSString*)key
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:key];
//    NSLog(@"加密后的字符串：%@",[encryptedData base64EncodedStringWithOptions:0]);
    return [encryptedData base64EncodedStringWithOptions:0];
}

#pragma mark - AES解密
//将带密码的data转成string
+ (NSString*)decryptAESData:(NSData*)data  app_key:(NSString*)key
{
    //使用密码对data进行解密
    NSData *decryData = [data AES128DecryptWithKey:key];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
//    NSLog(@"解密后的字符串 :%@",str);
    return str;
}

@end
