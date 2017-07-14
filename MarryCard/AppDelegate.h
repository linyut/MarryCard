//
//  AppDelegate.h
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showProgressView;
- (void)hideProgressView;
+ (BOOL)closeKeyWindow;
+ (AppDelegate*)appDelegate;
- (void)ShowHUB;
- (void)HiddenHUB;

@end

