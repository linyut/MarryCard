//
//  BaseIBViewController.h
//  InternetBanking
//
//  Created by Simon on 16/6/12.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseIBObject.h"
#import "MenuView.h"
#import "UIImage+Extensions.h"

#define CellHeight 50.f

@interface BaseIBViewController : UIViewController

@property (nonatomic,strong) NSDictionary *_Nullable param;

- (void)formatAlertControllerWithTitle:(nullable NSString *)titile message:(nullable NSString *)message;

//- (void)formatAlertControllerWithTitle:(NSString * _Nullable)titile message:(NSString * _Nullable)message handler:(nullable void(^)(UIAlertAction * _Nullable action))handle;

- (void)formatAlertControllerWithTitle:( NSString * _Nullable)titile message:( NSString * _Nullable)message hand:(nullable void (^)(NSString *_Nullable str) )mBlocks;

- (void)formatAlertControllerWithTitle:(NSString *_Nullable)titile message:(NSString *_Nullable)message andBtnTitleArr:(NSArray*_Nullable)arr hand:(nullable void (^)(NSString *_Nullable str) )mBlocks;

- (void)formatAlertControllerWithTitle:(NSString *_Nullable)titile message:(NSString *_Nullable)message andBtnTitleArr:(NSArray*_Nullable)arr withBtnStyles:(NSArray*_Nonnull)styles hand:(nullable void (^)(NSString *_Nullable str) )mBlocks;

- (void)popVC:(int)vcNum;
- (void)popHomeVC;
- (void)popToNetOrganizeHomeVC;
- (void)popLastVC;
- (void)popToCulturalHomeVC;

- (void)showToast:(NSString *_Nullable)msg;
- (void)hideToast;
- (void)configTitle:(NSString *_Nullable)title showLeftButton:(BOOL)isShow andrightBtnTitle:(NSString*_Nullable)rightTitle;

- (void)configRightItemWithType:(NSString *_Nullable) buttonType;
///创建或替换导航栏右按钮
- (void)createNavigationRightButtonWithTitle:(NSString*_Nullable)title;
- (void)createNavigationRightButtonWithImageNamed:(NSString*_Nullable)imageNamed;

- (void)rightAction:(UIButton *_Nullable)sender;
- (void)leftAction:(UIButton *_Nullable)sender;
-(void)shouldHiddenRedPoint;
-(void)creatMenuViewWithArr:(NSArray *_Nullable)arr;

//- (void)checkForcedLogout:(NSString *_Nullable)errorCode;

-(void)login;
- (void)loginWithForceLoutFlag:(BOOL)forceLogout;
- (void)loginAndLoginSuccessBackHomePage;
//- (void)storyBoradAutoLay:(UIView *_Nullable)allView;

- (UIViewController *_Nullable) loadViewControllerWithstoryboardName:(NSString *_Nullable)sbName withIdentifier:(NSString*_Nullable)identifier;


@property(strong,nonatomic) MenuView * _Nullable menuView;


@end
