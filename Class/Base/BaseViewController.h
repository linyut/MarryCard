//
//  BaseViewController.h
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property (strong, nonatomic) UIView *_Nullable emptyView;

@property (strong, nonatomic)SelectMenuView *_Nullable selectMenuView;




- (void)configTitle:(NSString *_Nullable)title showLeftButton:(BOOL)isShow andrightBtnTitle:(NSString*_Nullable)rightTitle;



- (void)formatAlertControllerWithTitle:(nullable NSString *)titile message:(nullable NSString *)message;

- (void)formatAlertControllerWithTitle:( NSString * _Nullable)titile message:( NSString * _Nullable)message hand:(nullable void (^)(NSString *_Nullable str) )mBlocks;

- (void)formatAlertControllerWithTitle:(NSString *_Nullable)titile message:(NSString *_Nullable)message andBtnTitleArr:(NSArray*_Nullable)arr hand:(nullable void (^)(NSString *_Nullable str) )mBlocks;

- (void)formatAlertControllerWithTitle:(NSString *_Nullable)titile message:(NSString *_Nullable)message andBtnTitleArr:(NSArray*_Nullable)arr withBtnStyles:(NSArray*_Nonnull)styles hand:(nullable void (^)(NSString *_Nullable str) )mBlocks;


@end
