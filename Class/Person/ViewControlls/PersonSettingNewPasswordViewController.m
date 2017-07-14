//
//  PersonSettingNewPasswordViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "PersonSettingNewPasswordViewController.h"
#import "LoginAndRegisterViewModel.h"



@interface PersonSettingNewPasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;


@end

@implementation PersonSettingNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"修改密码" showLeftButton:YES andrightBtnTitle:nil];
    self.firstTextField.delegate = self;
    self.secondTextField.delegate = self;
    [self.firstTextField setValue:@20 forKey:@"limit"];
    [self.secondTextField setValue:@20 forKey:@"limit"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)successBtnClick:(UIButton *)sender {
    if (self.firstTextField.text.length==0) {
        MESSAGE(@"请输入新密码");
    }else if (self.firstTextField.text.length<8){
        MESSAGE(@"请输入8~20位新密码");
    }else if (self.secondTextField.text.length ==0){
        MESSAGE(@"请再次输入新密码");
    }else if (self.secondTextField.text.length<8){
        MESSAGE(@"请再次输入8~20位新密码");
    }else if (![self.secondTextField.text isEqualToString:self.firstTextField.text]){
        MESSAGE(@"请输入相同的密码");
    }else{
        LoginAndRegisterViewModel *viewModel = [[LoginAndRegisterViewModel alloc] init];
        
        NSDictionary *param = @{@"Password":@"12341235", @"NewPassword":@"12341235"};
        [viewModel modifyPasswordWithParam:param success:^(NSDictionary *responseObject) {
            
        } failure:^(NSDictionary *error) {
            
        }];

    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
