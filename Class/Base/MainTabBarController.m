//
//  MainTabBarController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "OrderViewController.h"
#import "ChatViewController.h"
#import "PersonViewController.h"



@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI
{
    NSArray *titleArray = @[@"首页",@"订单",@"聊天",@"个人"];
    NSArray *unSelectImageNameArray = @[@"首页_normal",@"订单_normal",@"聊天_normal",@"个人_normal"];
    NSArray *selectImageNameArray = @[@"首页_selected",@"订单_selected",@"聊天_selected",@"个人_selected"];
    NSArray *ctrlArray = @[@"HomeViewController",@"OrderViewController",@"ChatViewController",@"PersonViewController"];
    NSMutableArray *array = [NSMutableArray array];
    self.tabBar.barStyle = UIBarStyleBlack;
    self.tabBar.barTintColor = [UIColor colorWithHexString:@"FFFFFF"];
    for (int i = 0; i<titleArray.count; i++)
    {
        Class cls = NSClassFromString(ctrlArray[i]);
        UIViewController *ctrl = [[cls alloc]init];
        ctrl.view.backgroundColor = [UIColor whiteColor];
        ctrl.tabBarItem.title = titleArray[i];
        //        UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
        //        UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
        //        UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息
        ctrl.tabBarItem.image = [[UIImage imageNamed:unSelectImageNameArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageNameArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        BaseNavigationController *navCtrl = [[BaseNavigationController alloc]initWithRootViewController:ctrl];
        UIImage *navImage = [DrawView drawRectangleWith:CGRectMake(0, 0, kScreenWidth, 64) startColor:[UIColor colorWithHexString:@"D355E2"] endColor:[UIColor colorWithHexString:@"F74956"]];
        [navCtrl.navigationBar setBackgroundImage:[navImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch]forBarMetrics:UIBarMetricsDefault];
        [ctrl.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];//[UIColor colorWithHexString:@"4A4A4A"]
        [ctrl.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"F66652"]} forState:UIControlStateSelected];//B21521
        
        [ctrl.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];

        [array addObject:navCtrl];
    }
    
    self.viewControllers = array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
