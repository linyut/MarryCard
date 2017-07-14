//
//  NSString+BuyAirTicketURL.m
//  AbroadTourism
//
//  Created by 柳宣泽 on 16/3/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "NSString+BuyAirTicketURL.h"

@implementation NSString (BuyAirTicketURL)

- (NSString *)encodeURIComponentRewrite
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}


- (NSString *) URLEncodingRewrite {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR(
                                                                                                   ":/?#[]@!$&’()*+,;="),
                                                                                             kCFStringEncodingUTF8));
    
    return result;
}

- (NSString *) URLDecodingRewrite {
    NSString *result = ( NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                                              kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    
    return result;
}

@end
