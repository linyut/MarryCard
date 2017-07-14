//
//  OrderSelectAddressViewController.h
//  MarryCard
//
//  Created by 方寸山 on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderSelectAddressViewController : BaseViewController

@property (copy, nonatomic) void (^addressBlock)(NSString *address);

@end
