//
//  NSDate+ITTAdditions.m
//
//  Created by guo hua on 11-9-19.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//

#import "NSDate+ITTAdditions.h"

@implementation NSDate(ITTAdditions)

+ (NSString *)timeStringFromNow:(NSDate*)lastDate;
{
    
    int distance = [[NSDate date] timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%d",distance];
}
+ (NSString *) timeStringWithInterval:(NSTimeInterval)time{
    
    int distance = [[NSDate date] timeIntervalSince1970] - time;
    NSString *string;
    if (distance < 1){//avoid 0 seconds
        string = @"刚刚";
    }
    else if (distance < 60) {
        string = [NSString stringWithFormat:@"%d秒前", (distance)];
    }
    else if (distance < 3600) {//60 * 60
        distance = distance / 60;
        string = [NSString stringWithFormat:@"%d分钟前", (distance)];
    }
    else if (distance < 86400) {//60 * 60 * 24
        distance = distance / 3600;
        string = [NSString stringWithFormat:@"%d小时前", (distance)];
    }
    else if (distance < 604800) {//60 * 60 * 24 * 7
        distance = distance / 86400;
        string = [NSString stringWithFormat:@"%d天前", (distance)];
    }
    else if (distance < 2419200) {//60 * 60 * 24 * 7 * 4
        distance = distance / 604800;
        string = [NSString stringWithFormat:@"%d周前", (distance)];
    }
    else {
        NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time)]];
        
    }
    return string;
}

- (NSString *)stringWithSeperator:(NSString *)seperator{
    return [self stringWithSeperator:seperator includeYear:YES];
}

// Return the formated string by a given date and seperator.
+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [formatter dateFromString:str];
    return date;
}

- (NSString *)stringWithFormat:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *string = [formatter stringFromDate:self];
    return string;
}

// Return the formated string by a given date and seperator, and specify whether want to include year.
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear{
    if( seperator==nil ){
        seperator = @"-";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if( includeYear ){
        [formatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd",seperator,seperator]];
    }else{
        [formatter setDateFormat:[NSString stringWithFormat:@"MM%@dd",seperator]];
    }
    NSString *dateStr = [formatter stringFromDate:self];
    
    return dateStr;
}

- (NSString *)dateFormatString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}


// return the date by given the interval day by today. interval can be positive, negtive or zero.
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval{
    return [NSDate dateWithTimeIntervalSinceNow:(24*60*60*interval)];
}

// return the date by given the interval day by given day. interval can be positive, negtive or zero.
- (NSDate *)relativedDateWithInterval:(NSInteger)interval{
    NSTimeInterval givenDateSecInterval = [self timeIntervalSinceDate:[NSDate relativedDateWithInterval:0]];
    return [NSDate dateWithTimeIntervalSinceNow:(24*60*60*interval+givenDateSecInterval)];
}

- (NSString *)weekday{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *weekdayStr = nil;
    [formatter setDateFormat:@"c"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSInteger weekday = [[formatter stringFromDate:self] integerValue];
    if( weekday==1 ){
        weekdayStr = @"星期日";
    }else if( weekday==2 ){
        weekdayStr = @"星期一";
    }else if( weekday==3 ){
        weekdayStr = @"星期二";
    }else if( weekday==4 ){
        weekdayStr = @"星期三";
    }else if( weekday==5 ){
        weekdayStr = @"星期四";
    }else if( weekday==6 ){
        weekdayStr = @"星期五";
    }else if( weekday==7 ){
        weekdayStr = @"星期六";
    }
    return weekdayStr;
}

-(NSString *)compareDate:(NSString *)targetTime{
    
    //目标时间
    NSDate *date = [NSDate dateWithString:targetTime formate:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //当前时间
    NSDate *today = [NSDate dateWithString:[self dateFormatString] formate:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *yesterday,*beforeOfYesterday,*beforeOfYesterday1,*beforeOfYesterday2,*beforeOfYesterday3,*beforeOfYesterday4;
    //今年
    NSString *toYears;
    toYears = [[today description] substringToIndex:4];
    yesterday          = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday  = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday1 = [beforeOfYesterday dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday2 = [beforeOfYesterday1 dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday3 = [beforeOfYesterday2 dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday4 = [beforeOfYesterday3 dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString              = [[today description] substringToIndex:10];
    NSString *yesterdayString          = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString  = [[beforeOfYesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString1 = [[beforeOfYesterday1 description] substringToIndex:10];
    NSString *beforeOfYesterdayString2 = [[beforeOfYesterday2 description] substringToIndex:10];
    NSString *beforeOfYesterdayString3 = [[beforeOfYesterday3 description] substringToIndex:10];
    NSString *beforeOfYesterdayString4 = [[beforeOfYesterday4 description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears =  [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        NSString *time = [[date description]substringWithRange:(NSRange){11,5}];
        if ([dateString isEqualToString:todayString]){
            NSString *tempTime = [time substringWithRange:(NSRange){0,2}];
            if ([tempTime integerValue]< 12) {
                tempTime = @"上午";
            }else{
                tempTime = @"下午";
            }
            dateContent = [NSString stringWithFormat:@"%@ %@",tempTime,time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]
                  || [dateString isEqualToString:beforeOfYesterdayString1]
                  || [dateString isEqualToString:beforeOfYesterdayString2]
                  || [dateString isEqualToString:beforeOfYesterdayString3]
                  || [dateString isEqualToString:beforeOfYesterdayString4]){
            dateContent = [NSString stringWithFormat:@"%@ %@",[date weekday],time];
            return dateContent;
        }else{
            return targetTime;
        }
    }else{
        return targetTime;
    }
}


-(NSString *)compareSingleDate:(NSString *)targetTime{
    
    //目标时间
    NSDate *date = [NSDate dateWithString:targetTime formate:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //当前时间
    NSDate *today = [NSDate dateWithString:[self dateFormatString] formate:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *yesterday;
    //今年
    NSString *toYears;
    toYears = [[today description] substringToIndex:4];
    yesterday          = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString              = [[today description] substringToIndex:10];
    NSString *yesterdayString          = [[yesterday description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears =  [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        NSString *time = [[date description]substringWithRange:(NSRange){11,9}];
        if ([dateString isEqualToString:todayString]){
            NSString *tempTime = [time substringWithRange:(NSRange){0,2}];
            NSString *morning;
            if ([tempTime integerValue]< 12) {
                morning = @"上午";
            }else{
                morning = @"下午";
            }
            dateContent = [NSString stringWithFormat:@"%@ %@",morning,[time substringWithRange:(NSRange){0,5}]];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            //            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return @"昨天";
        }else{
            return [[targetTime substringWithRange:(NSRange){2,9}] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        }
    }else{
        return [[targetTime substringWithRange:(NSRange){2,9}] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
}

- (NSDate *)localeDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    return [self dateByAddingTimeInterval:interval];
}
@end
