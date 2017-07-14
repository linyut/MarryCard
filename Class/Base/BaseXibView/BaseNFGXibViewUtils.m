//
//  BaseNFGXibViewUtils.m
//  PensionTreasure
//
//  Created by Simon on 16/7/4.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseNFGXibViewUtils.h"

@implementation BaseNFGXibViewUtils

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}

+ (id)loadViewFromXibNamed:(NSString*)xibName {
    return [BaseNFGXibViewUtils loadViewFromXibNamed:xibName withFileOwner:self];
}

@end
