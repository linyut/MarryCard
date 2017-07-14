//
//  BaseNavgationViewController.m
//  PensionTreasure
//
//  Created by xiaowei on 16/7/1.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseNavgationViewController.h"

@interface BaseNavgationViewController ()

@end

@implementation BaseNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBarImage"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏的文字颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.translucent=NO;
    [self.navigationBar setTintColor:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//修改状态栏的样式
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    //隐藏底部bar
//    viewController.hidesBottomBarWhenPushed = YES;
////    self.tabBarController.tabBar.hidden = YES;
//    [super pushViewController:viewController animated:animated];
//
//}



@end
