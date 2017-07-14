//
//  BaseTableViewController.h
//  VitalityBOC
//
//  Created by xiaowei on 16/11/23.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

- (void)formatAlertControllerWithTitle:(nullable NSString *)titile message:(nullable NSString *)message;

- (void)formatAlertControllerWithTitle:(NSString * _Nullable)titile message:(NSString * _Nullable)message handler:(nullable void(^)(UIAlertAction * _Nullable action))handle;

- (void)popVC:(int)vcNum;
- (void)popHomeVC;
- (void)popLastVC;

- (void)showToast:(NSString *_Nullable)msg;
- (void)hideToast;
- (void)configTitle:(NSString *_Nullable)title showLeftButton:(BOOL)isShow andrightBtnTitle:(NSString*_Nullable)rightTitle;

- (void)rightAction:(UIButton *_Nullable)sender;
- (void)leftAction:(UIButton *_Nullable)sender;

@end
