//
//  NSString+ITTAdditions.m
//
//  Created by Jack on 11-9-19.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
//#import "UIFont+ITTAdditions.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSString (ITTAdditions)

//- (NSInteger)numberOfLinesWithFont:(UIFont*)font
//                     withLineWidth:(NSInteger)lineWidth{
//    CGSize size = [self sizeWithFont:font
//                   constrainedToSize:CGSizeMake(lineWidth, CGFLOAT_MAX)
//                       lineBreakMode:UILineBreakModeTailTruncation];
//	NSInteger lines = size.height / [font ittLineHeight];
//	return lines;
//}
//- (CGFloat)heightWithFont:(UIFont*)font
//            withLineWidth:(NSInteger)lineWidth{
//    CGSize size = [self sizeWithFont:font
//                   constrainedToSize:CGSizeMake(lineWidth, CGFLOAT_MAX)
//                       lineBreakMode:UILineBreakModeTailTruncation];
//	return size.height;
//	
//}

- (BOOL) contains:(NSString*) str {
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

- (NSString *)md5{
	const char *concat_str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < 16; i++){
		[hash appendFormat:@"%02X", result[i]];
	}
	return [hash lowercaseString];        
}

- (BOOL)isStartWithString:(NSString*)start
{
    BOOL result = FALSE;
    NSRange found = [self rangeOfString:start options:NSCaseInsensitiveSearch];
    if (found.location == 0)
    {
        result = TRUE;
    }
    return result;
}

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement {
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (BOOL)isEndWithString:(NSString*)end
{
    NSInteger endLen = [end length];
    NSInteger len = [self length];
    BOOL result = TRUE;
    if (endLen <= len) {
        NSInteger index = len - 1;
        for (NSInteger i = endLen - 1; i >= 0; i--) {
            if ([end characterAtIndex:i] != [self characterAtIndex:index]) {
                result = FALSE;
                break;
            }
            index--;
        }
    }
    else {
        result = FALSE;
    }
    return result;
}

/** 00011 转成 正常值*/
+(NSString*)changeStr:(NSString *)str
{
    str = [str substringFromIndex:1];  
    str = [NSString stringWithFormat:@"%f",[str doubleValue]/100];
    if ([str hasPrefix:@"0.00"]) {
        return @"0.00";
    }
    
    NSString *formattedNumberString;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    [numberFormatter release];
    return formattedNumberString;
}

/** 金额变成, */
+ (NSString*)strmethodComma:(NSString*)string
{
    string = [NSString strmethod:string];
    NSString *sign = nil;
    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
        sign = [string substringToIndex:1];
        string = [string substringFromIndex:1];
    }
    NSString *pointLast = [string substringFromIndex:[string length]-3];
    NSString *pointFront = [string substringToIndex:[string length]-3];
    
    NSInteger commaNum = ([pointFront length]-1)/3;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < commaNum+1; i++) {
        NSInteger index = [pointFront length] - (i+1)*3;
        NSInteger leng = 3;
        if(index < 0)
        {
            leng = 3+index;
            index = 0;
            
        }
        NSRange range = NSMakeRange(index, leng);
        NSString *stq = [pointFront substringWithRange:range];
        [arr addObject:stq];
    }
    NSMutableArray *arr2 = [NSMutableArray array];
    for (NSInteger i = [arr count]-1; i>=0; i--) {
        
        [arr2 addObject:arr[i]];
    }
    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
    if (sign) {
        commaString = [sign stringByAppendingString:commaString];
    }
    return commaString;
}

+ (NSString *)strmethod:(NSString*)string
{
    if ([string hasPrefix:@"+"] || [string hasPrefix:@"-"]) {
        double completeStr = [string doubleValue]/100;
        return [NSString stringWithFormat:@"%.2f",completeStr];
    }else
    {
        NSString *preStr = [[string substringToIndex:[string length] - 2] isEqualToString:@""] ?@"0":[string substringToIndex:[string length] - 2];
        NSString *backStr = [string substringFromIndex:[string length] - 2];
        
        for (int index = 0; index < [preStr length]; index++) {
            if ([[preStr substringToIndex:1] compare:@"0"] == NSOrderedSame) {
                preStr = [preStr substringFromIndex:1];
                index = 0;
            }
            else
                break;
        }
        
        NSString *completeStr = [NSString stringWithFormat:@"%@.%@",preStr,backStr];
        return completeStr;
    }
}

+ (NSString*)limitStrMethod:(NSString*)string
{
    NSString *preStr   = [string substringToIndex:[string length] - 2];
//    NSString *backStr       = [string substringFromIndex:[string length] - 2];
    
    for (int index = 0; index < [preStr length]; index++) {
        if ([[preStr substringToIndex:1] compare:@"0"] == NSOrderedSame) {
            preStr = [preStr substringFromIndex:1];
            index = 0;
        }
        else
            break;
    }
    
    NSString *completeStr   = [NSString stringWithFormat:@"%@",preStr];
    return completeStr;
}

+ (NSString*)normalNumToBankNum:(NSString*)normalString
{
    NSInteger size=(normalString.length/4);
    NSMutableArray *temStrArr=[[NSMutableArray alloc] init];
    
    for (int n=0; n<size; n++) {
        [temStrArr addObject:[normalString substringWithRange:NSMakeRange(n * 4,4)]];
    }
    
    [temStrArr addObject:[normalString substringWithRange:NSMakeRange(size * 4,
                                                                      (normalString.length % 4))]];
    normalString=[temStrArr componentsJoinedByString:@" "];
    [temStrArr release];
    return normalString;
}

+ (NSMutableString*)phoneChange:(NSString*)phoneNum
{
    NSMutableString *newPhone = [NSMutableString stringWithFormat:@"%@",phoneNum];
    
    [newPhone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return newPhone;
}

+ (NSString *)formatMoney:(NSString *)strMoney
{
    NSNumberFormatter *numFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    NSNumber *num = [NSNumber numberWithDouble:[strMoney doubleValue]];
    NSString *money = [numFormatter stringFromNumber:num];
    NSRange range = [money rangeOfString:@"."];

    return range.location == NSNotFound ? [money stringByAppendingString:@".00"]
                                        : range.location == money.length-3 ? money
                                        : [money stringByAppendingString:@"0"];
}


+(BOOL)isChristmas{
    NSDate *today = [NSDate date];
    
    NSDateFormatter *tFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [tFormatter setDateFormat:@"MMdd"];
    NSString *tNewString = [tFormatter stringFromDate:today];
    
    long long todayDate = [tNewString longLongValue];
    if( todayDate >= 1222 && todayDate <= 1225){
    
        return YES;
    }

    return NO;
}
+(BOOL)isNewYear{
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *tFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [tFormatter setDateFormat:@"MMdd"];
    NSString *tNewString = [tFormatter stringFromDate:today];
    
    long long todayDate = [tNewString longLongValue];
    if( todayDate == 1228 || todayDate == 1229 || todayDate == 1230|| todayDate == 1231|| todayDate == 101|| todayDate == 102|| todayDate == 103 ){
        
        return YES;
    }
    
    return NO;
}

+(BOOL)isFestival{
    NSDate *today = [NSDate date];
    
    NSDateFormatter *tFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [tFormatter setDateFormat:@"MMdd"];
    NSString *tNewString = [tFormatter stringFromDate:today];
    
    long long todayDate = [tNewString longLongValue];
    if( todayDate >= 201 && todayDate <= 221){
        
        return YES;
    }
    
    return NO;
}
+(BOOL)isHongBaoDay{
    NSDate *today = [NSDate date];
    
    NSDateFormatter *tFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [tFormatter setDateFormat:@"MMdd"];
    NSString *tNewString = [tFormatter stringFromDate:today];
    
    long long todayDate = [tNewString longLongValue];
    if( todayDate >= 517 && todayDate <= 818){
        
        return YES;
    }
    
    return NO;
}


@end

