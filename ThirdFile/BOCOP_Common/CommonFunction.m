//
//  CommonFunction.m
//  PBPS-MA
//
//  Created by mark on 2017/3/27.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

//pageNo加一
+ (NSString*)pageIncreaseByOne:(NSString*)pageNo {
    NSString *result;
    int number = [pageNo intValue];
    number++;
    result = [NSString stringWithFormat:@"%d",number];
    return result;
}

@end
