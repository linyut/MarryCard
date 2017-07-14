//
//  NSData+AESCrypt_iOS.h
//  AES128_EN_DE
//
//  Created by 柳宣泽 on 16/3/14.
//  Copyright © 2016年 柳宣泽 All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSString;

@interface NSData (AESCrypt_iOS)


- (NSData *)AES128EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key;   //解密

@end
