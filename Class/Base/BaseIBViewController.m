//
//  BaseIBViewController.m
//  InternetBanking
//
//  Created by Simon on 16/6/12.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseIBViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import "MenuView.h"
#import "MainTabbarController.h"
#import "UIAlertController+Extend.h"
#import "UINavigationController+Function.h"
#import "HomeViewController.h"
#import "CultureHomeViewController1.h"
#import "VitailityHomeViewController.h"
#import "VitailityPersonalViewController.h"
#import "MainHomeViewModel.h"
@interface BaseIBViewController ()<clickActionDelegate>

@property (nonatomic, strong) MainHomeViewModel *mainViewModel;

@end

@implementation BaseIBViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.view setBackgroundColor:[UIColor colorWithHexString:@"EFEFF4"]];
    if([self automaticallyAdjustsScrollViewInsets]){
        self.automaticallyAdjustsScrollViewInsets=NO;

    }
    /*
       1、 //cell禁止自适应，导航栏不透明，空出导航栏位置开始布局，根据改变NO值查看不同效果
        self.navigationController.navigationBar.translucent=NO;
        self.extendedLayoutIncludesOpaqueBars=NO;
     
     */
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside =YES;

}

-(void)creatMenuViewWithArr:(NSArray *)arr{

    _menuView =[[MenuView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) adnTitleArr:arr];
    _menuView.delegate =self;
}

#pragma mark  menuview 代理
-(void)btnClickWithTag:(NSString *)tag{
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_menuView showOrHidden:NO];
}


- (void)formatAlertControllerWithTitle:(NSString *)titile message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click AlertController Cancel");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Click AlertController Default");
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)formatAlertControllerWithTitle:(NSString *)titile message:(NSString *)message hand:( void (^)(NSString *str) )mBlocks
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click AlertController Cancel");
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        mBlocks(@"确定");
        NSLog(@"Click AlertController Default");
    }]];
    
//    [self presentViewController:alertController animated:YES completion:nil];
    [self presentViewController:alertController animated:YES completion:^{
        ;
    }];
}

- (void)formatAlertControllerWithTitle:(NSString *)titile message:(NSString *)message andBtnTitleArr:(NSArray*)arr hand:( void (^)(NSString *str) )mBlocks
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (!arr) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            mBlocks(@"确定");
            NSLog(@"Click AlertController Default");
        }]];
    }
    else {
        for (NSString *title in arr) {
            UIAlertAction *actionItem = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (mBlocks) mBlocks(action.title);
                NSLog(@"click action title:%@",action.title);
            }];
            [alertController addAction:actionItem];
        }
    }

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)formatAlertControllerWithTitle:(NSString *)titile message:(NSString *)message andBtnTitleArr:(NSArray*)arr withBtnStyles:(NSArray*)styles hand:( void (^)(NSString * str) )mBlocks {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (!arr) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            mBlocks(@"确定");
            NSLog(@"Click AlertController Default");
        }]];
    }
    else {
        NSInteger index = 0;
        for (NSString *title in arr) {
            NSNumber *style = styles[index];
            UIAlertAction *actionItem = [UIAlertAction actionWithTitle:title style:[style integerValue] handler:^(UIAlertAction * _Nonnull action) {
                if (mBlocks) mBlocks(action.title);
                NSLog(@"click action title:%@",action.title);
            }];
            [alertController addAction:actionItem];
            index++;
        }
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//返回前面几个界面
- (void)popVC:(int)vcNum
{
    NSInteger viewControllerCount = [self.navigationController.viewControllers count];
    if(viewControllerCount >= vcNum+1){
        UIViewController *previousVC = [self.navigationController.viewControllers objectAtIndex:viewControllerCount-vcNum-1];
        [self.navigationController popToViewController:previousVC animated:YES];
    }
}

//返回首页
- (void)popHomeVC
{
    UITabBarController *tabbar = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabbar.selectedIndex = 0;
    UINavigationController *nav = tabbar.childViewControllers[0];
    if (nav) {
        [nav popToRootViewControllerAnimated:YES];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//返回网络党支部首页
- (void)popToNetOrganizeHomeVC {
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
//        self.mainViewModel = [[MainHomeViewModel alloc] init];
//        [self.mainViewModel queryMyCloudInfoWithParam:nil success:^(NSDictionary *result) {
//            
//        } failure:^(NSDictionary *error) {
//            
//        }];
//        
        if ([vc isKindOfClass:[VitailityHomeViewController class]]) {
        
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}
//返回文化中行首页
- (void)popToCulturalHomeVC {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[CultureHomeViewController1 class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}


//返回上一个界面
- (void)popLastVC
{
    [self popVC:1];
}


#pragma mark - ShowToast
- (void)showToast:(NSString *)msg
{
    MESSAGE(msg);
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KAPPDELEGATE.window animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = msg;
//    hud.alpha = 0.6;
//    hud.margin = 10.f;
//    hud.yOffset = 0.f;
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:3];
}

- (void)hideToast
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (void)configTitle:(NSString *)title showLeftButton:(BOOL)isShow andrightBtnTitle:(NSString*)rightTitle
{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 40)];
    [titleLabel setText:title];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:titleLabel];
    
    if ([title isEqualToString:@"firstLogin"]) {
        UIImageView *bgView = [[UIImageView alloc] init];
        [bgView setFrame:self.navigationController.navigationBar.bounds];
        [bgView setImage:IMGNAMEED(@"First_navbar_image")];
        [self.navigationItem setTitleView:bgView];
    }
    
    
    if (isShow) {
        [self configLeftItem];
    }
    if (rightTitle.length> 0) {
        [self configRightItemWithType:rightTitle];
    }
}

- (void)configRightItemWithType:(NSString *) buttonType
{
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0.0, 0.0, 80, 40)];
    rightButton.tag=521;
    if ([buttonType isEqualToString:@"branchRightImage"]) {
        rightButton.width = 30;
        rightButton.height = 30;
        [rightButton setImage:[UIImage imageNamed:@"branchRightImage"] forState:UIControlStateNormal];
        rightButton.adjustsImageWhenHighlighted = NO;
    }else{
        [rightButton setTitle:buttonType forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton.titleLabel setFont:[UIFont fontWithName:TEXT_FONTNAME size:13]];
    
	rightButton.imageEdgeInsets = UIEdgeInsetsMake(10,0,-10,0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

///创建或替换导航栏右按钮
- (void)createNavigationRightButtonWithTitle:(NSString*_Nullable)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
	item.imageInsets = UIEdgeInsetsMake(10,-15,-10,15);

    self.navigationItem.rightBarButtonItems = @[item];
}

- (void)createNavigationRightButtonWithImageNamed:(NSString*_Nullable)imageNamed {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
	item.imageInsets = UIEdgeInsetsMake(10,-15,-10,15);
    self.navigationItem.rightBarButtonItems = @[item];
}

- (void)rightAction:(UIButton *)sender
{
    if (self.menuView) {
        UIButton *rightBtn = [self.navigationController.navigationBar viewWithTag:521];
        rightBtn.selected = ! rightBtn.selected;
        [self.menuView showOrHidden:rightBtn.selected];
    }
    
}


- (void)configLeftItem
{
    UIBarButtonItem *spaceItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
	item.imageInsets = UIEdgeInsetsMake(10,0,-10,0);

    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
}

- (void)leftAction:(UIButton *)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)login{
    [self loginWithForceLoutFlag:NO];
}

//- (void)loginWithForceLoutFlag:(BOOL)forceLogout {
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    LoginViewController * fvc = [sb instantiateInitialViewController];
//    fvc.isForceLogout = forceLogout;
//    [self.navigationController hideTabbarPushViewController:fvc animated:NO];
//}
//
//- (void)loginAndLoginSuccessBackHomePage {
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    LoginViewController * fvc = [sb instantiateInitialViewController];
//    fvc.isForceLogout = NO;
//    fvc.onlySuccessBackHome = YES;
//    [self.navigationController hideTabbarPushViewController:fvc animated:NO];
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [AppDelegate closeKeyWindow];
}

-(void)shouldHiddenRedPoint{
    

    
}

//自定义一个方法从sb里加载控制器
- (UIViewController *) loadViewControllerWithstoryboardName:(NSString *)sbName withIdentifier:(NSString*)identifier
{
    //1.加载sb文件
    UIStoryboard * sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
    
    
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
