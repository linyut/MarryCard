//
//  UINavigationController+Function.m
//  PBPS-MA
//
//  Created by tk on 2017/3/14.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import "UINavigationController+Function.h"


@implementation UINavigationController(Function)

- (void)hideTabbarPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏底部bar
    viewController.hidesBottomBarWhenPushed = YES;
    [self pushViewController:viewController animated:animated];
    
}

@end
