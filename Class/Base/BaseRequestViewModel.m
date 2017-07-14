//
//  BaseRequestViewModel.m
//  PensionTreasure
//
//  Created by xiaowei on 16/7/25.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseRequestViewModel.h"

@implementation BaseRequestViewModel

- (void)onRequestSuccess:(void (^)(NSDictionary *))onRequestSuccess{
    _onRequestSuccess = nil;
    _onRequestSuccess = [onRequestSuccess copy];
    
}

- (void)onRequestFail:(void (^)(NSError *error))onRequestFail{
    _onRequestFail = nil;
    _onRequestFail = [onRequestFail copy];
    
}


@end
