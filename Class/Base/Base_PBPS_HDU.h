//
//  Base_PBPS_HDU.h
//  PBPS-MA
//
//  Created by BOCOP-0018 on 17/5/3.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface Base_PBPS_HDU : MBProgressHUD

+ (void)showHUD;

+ (void)showHUDWithCancelButton:(void(^)())cancelAction;

+ (void)hideHUD;
@end
