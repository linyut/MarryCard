//
//  BOCBaseViewController.h
//  boc_ios
//
//  Created by scs on 2016/11/19.
//  Copyright © 2016年 中行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseIBViewController.h"
@interface BOCBaseViewController : BaseIBViewController


/**
 设置导航栏标题文字（固定字号和颜色值，字号为18）

 @param title 标题文字
 */
- (void)setNavigationTitle:(NSString *)title;

- (void)leftAction:(UIButton *)sender;

@end
