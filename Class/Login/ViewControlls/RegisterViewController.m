//
//  RegisterViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/10.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTrueInfoViewController.h"
#import "LoginAndRegisterViewModel.h"



@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeNumBtn;


@property (strong, nonatomic) LoginAndRegisterViewModel *viewModel;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"" showLeftButton:YES andrightBtnTitle:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)codeNumBtnClick:(UIButton *)sender {
    LoginAndRegisterViewModel *viewModel = [[LoginAndRegisterViewModel alloc] init];
    
    NSDictionary *param = @{@"Tel":@"13900000000", @"Password":@"12341234", @"NewPassword":@"12341234"};
    [viewModel registerWithParam:param success:^(NSDictionary *responseObject) {
        
    } failure:^(NSDictionary *error) {
        
    }];

}

- (IBAction)nextBtnClick:(UIButton *)sender {
    RegisterTrueInfoViewController *trueVC = [[RegisterTrueInfoViewController alloc] init];
    [self.navigationController pushViewController:trueVC animated:YES];
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
