//
//  BaseViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createEmptyView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    // Do any additional setup after loading the view.
}

-(void)createEmptyView
{
    self.emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.emptyView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.view addSubview:self.emptyView];
    self.emptyView.hidden = YES;
    UIImageView *emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-267)/2, 37+50, 267, 245)];
    emptyImageView.image = [UIImage imageNamed:@"bg_empty"];
    [self.emptyView addSubview:emptyImageView];
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

- (void)configLeftItem
{
    UIBarButtonItem *spaceItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
//    item.imageInsets = UIEdgeInsetsMake(10,0,-10,0);
    
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


//返回前面几个界面
- (void)popVC:(int)vcNum
{
    NSInteger viewControllerCount = [self.navigationController.viewControllers count];
    if(viewControllerCount >= vcNum+1){
        UIViewController *previousVC = [self.navigationController.viewControllers objectAtIndex:viewControllerCount-vcNum-1];
        [self.navigationController popToViewController:previousVC animated:YES];
    }
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
