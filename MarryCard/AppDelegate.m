//
//  AppDelegate.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "AppDelegate.h"
#import "Base_PBPS_HDU.h"
#import "LaunchIntroductionView.h"
#import "MainTabBarController.h"


static AppDelegate *_delegate = nil;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([self checkDeviceIsJailBroken] == YES) {
        NSString * JailBroken = [[NSUserDefaults standardUserDefaults]objectForKey:@"JailBroken"];
        if (![JailBroken isEqualToString:@"dontShowAlert"]) {
            [self showJailBrokenAlertMessage];
        }
    }

    MainTabBarController *mainCtrl = [[MainTabBarController alloc]init];
    self.window.rootViewController = mainCtrl;
    
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [LaunchIntroductionView sharedWithImages:@[@"launch1.jpg",@"launch2.jpg",@"launch3.jpg"] buttonImage:@"" buttonFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    return YES;
}


#pragma mark - appDelegate

+ (BOOL)closeKeyWindow
{
    return [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - Show Progress
- (void)showProgressView
{
    [self ShowHUB];
}

- (void)hideProgressView
{
    [self HiddenHUB];
}

-(BOOL)checkDeviceIsJailBroken{
    BOOL isJailBroken = NO;
    NSString * cydiaPath = @"/Applications/Cydia.app";
    NSString * aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]||[[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        isJailBroken = YES;
    }
    return isJailBroken;
}

-(void)showJailBrokenAlertMessage{
    UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"确认信息" message:@"您的手机已越狱，处于不安全不稳定的环境中，应用可能会出现闪退、崩溃等不可预知的错误。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alertV.tag = 20160727;
    [alertV show];
}
+ (AppDelegate*)appDelegate
{
    return _delegate;
}
- (void)ShowHUB{
    [Base_PBPS_HDU showHUDWithCancelButton:^{
//        [[NFGHTTPManager manager] cancelAllDataTasks];
    }];
}
- (void)HiddenHUB{
    [Base_PBPS_HDU hideHUD];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
