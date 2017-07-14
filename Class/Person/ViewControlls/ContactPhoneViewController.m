//
//  ContactPhoneViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "ContactPhoneViewController.h"

@interface ContactPhoneViewController ()

@end

@implementation ContactPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"联系我们" showLeftButton:YES andrightBtnTitle:nil];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)phoneBtnClick:(UIButton *)sender {
    [self formatAlertControllerWithTitle:@"021-37898998" message:nil andBtnTitleArr:@[@"取消",@"呼叫"] hand:^(NSString * _Nullable str) {
        if ([str isEqualToString:@"呼叫"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"021-37898998"]]];
        }
    }];
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
