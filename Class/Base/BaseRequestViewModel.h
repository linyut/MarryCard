//
//  BaseRequestViewModel.h
//  PensionTreasure
//
//  Created by xiaowei on 16/7/25.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseIBObject.h"

@interface BaseRequestViewModel : BaseIBObject{
    
    void (^_onRequestSuccess)(NSDictionary *);
    void (^_onRequestFail)(NSError *);
}

//返回信息回调回去
- (void)onRequestSuccess:(void (^)(NSDictionary *))onRequestSuccess;

- (void)onRequestFail:(void (^)(NSError *))onRequestFail;

@end
