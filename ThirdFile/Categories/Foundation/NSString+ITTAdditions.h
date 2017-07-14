//
//  NSString+ITTAdditions.h
//
//  Created by Jack on 11-9-19.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (ITTAdditions)

//- (NSInteger)numberOfLinesWithFont:(UIFont*)font
//                     withLineWidth:(NSInteger)lineWidth;
//- (CGFloat)heightWithFont:(UIFont*)font
//            withLineWidth:(NSInteger)lineWidth;
- (BOOL) contains:(NSString*) str;
- (NSString *)md5;

- (BOOL)isStartWithString:(NSString*)start;

- (BOOL)isEndWithString:(NSString*)end;
+(NSString*)changeStr:(NSString *)str;
+(NSString *)strmethodComma:(NSString *)string;
+(NSString *)strmethod:(NSString*)string;
+(NSString*)normalNumToBankNum:(NSString*)normalString;
+(NSString*)limitStrMethod:(NSString*)string;
+(NSMutableString*)phoneChange:(NSString*)phoneNum;
+(NSString *)formatMoney:(NSString *)strMoney;
- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement ;

+(BOOL)isChristmas;

+(BOOL)isNewYear;
+(BOOL)isFestival;
+(BOOL)isHongBaoDay;
@end

