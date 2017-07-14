//
//  NSString+BuyAirTicketURL.h
//  AbroadTourism
//
//  Created by dede on 16/3/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BuyAirTicketURL)

- (NSString *)encodeURIComponentRewrite;

- (NSString *)URLEncodingRewrite;

- (NSString *)URLDecodingRewrite;

@end
