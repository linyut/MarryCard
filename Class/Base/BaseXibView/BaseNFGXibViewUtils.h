//
//  BaseNFGXibViewUtils.h
//  PensionTreasure
//
//  Created by Simon on 16/7/4.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseIBObject.h"

@interface BaseNFGXibViewUtils : BaseIBObject

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner;

//  the view must not have any connecting to the file owner
+ (id)loadViewFromXibNamed:(NSString*)xibName;
@end
