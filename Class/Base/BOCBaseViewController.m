//
//  BOCBaseViewController.m
//  boc_ios
//
//  Created by scs on 2016/11/19.
//  Copyright © 2016年 中行. All rights reserved.
//

#import "BOCBaseViewController.h"

@interface BOCBaseViewController ()

@end

@implementation BOCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configLeftItem];
}

/**
 设置导航栏标题文字（固定字号和颜色值，字号为18）
 
 @param title 标题文字
 */
- (void)setNavigationTitle:(NSString *)title {
    // 标题
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textColor = RGBACOLOR(255, 255, 255, 1);
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
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

@end
