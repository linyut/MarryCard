//
//  PersonSettingViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "PersonSettingViewController.h"
#import "PersonModifyPasswordViewController.h"

@interface PersonSettingViewController ()

@end

@implementation PersonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"设置" showLeftButton:YES andrightBtnTitle:nil];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)modifyPasswordBtnClick:(UIButton *)sender {
    PersonModifyPasswordViewController *vc = [[PersonModifyPasswordViewController alloc] init];
    vc.viewTitle = @"修改密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)leavingBtnClick:(UIButton *)sender {
    MESSAGE(@"wait");
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
