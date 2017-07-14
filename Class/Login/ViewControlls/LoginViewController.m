//
//  LoginViewController.m
//  MarryCard
//
//  Created by linyut on 2017/7/7.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "PersonModifyPasswordViewController.h"
#import "LoginAndRegisterViewModel.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)prepareData
{

//    self.questionListArray = @[@"如何下单？", @"如何注册？"];
//    self.answerListArray = @[@"一个算法执行所耗费的时间，从理论上是不能算出来的，必须上机运行测试才能知道。但我们不可能也没有必要对每个算法都上机测试，只需知道哪个算法花费的时间多，哪个算法花费的时间少就可以了。并且一个算法花费的时间与算法中语句的执行次数成正比例", @"同一问题可用不同算法解决，而一个算法的质量优劣将影响到算法乃至程序的效率。算法分析的目的在于选择合适算法和改进算法。一个算法的评价主要从时间复杂度和空间复杂度来考虑"];
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView *nameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手机"]];
    nameImageView.frame = CGRectMake(10, 4, 16, 22);
    [nameView addSubview:nameImageView];
    UIView * separateView1 = [[UIView alloc] initWithFrame:CGRectMake(36, 5, 1, 20)];
    separateView1.backgroundColor = [UIColor colorWithHexString:@"F1F1F1"];
    [nameView addSubview:separateView1];
    self.nameTextField.leftView = nameView;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
    passwordImageView.frame = CGRectMake(10, 4, 16, 22);
    [passwordView addSubview:passwordImageView];
    UIView * separateView2 = [[UIView alloc] initWithFrame:CGRectMake(36, 5, 1, 20)];
    separateView2.backgroundColor = [UIColor colorWithHexString:@"F1F1F1"];
    [passwordView addSubview:separateView2];
    self.passwordTextField.leftView = passwordView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.nameTextField setValue:@11 forKey:@"limit"];
    [self.passwordTextField setValue:@20 forKey:@"limit"];
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)regeditBtnClick:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)forgetPasswordBtnClick:(UIButton *)sender {
    PersonModifyPasswordViewController *vc = [[PersonModifyPasswordViewController alloc] init];
    vc.viewTitle = @"找回密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    if (self.nameTextField.text.length == 0) {
        MESSAGE(@"请输入手机号码");
    }else if (![CommonMethod isMobileNumer:self.nameTextField.text]){
        MESSAGE(@"请输入正确的手机号码");
    }else if (self.passwordTextField.text.length == 0){
        MESSAGE(@"请输入密码");
    }else if (self.passwordTextField.text.length < 8){
        MESSAGE(@"请输入正确的密码");
    }else{
        
        LoginAndRegisterViewModel *viewModel = [[LoginAndRegisterViewModel alloc] init];
        
        NSDictionary *param = @{@"Tel":@"13900000000", @"Password":@"12341234"};
        [viewModel loginWithParam:param success:^(NSDictionary *responseObject) {
            
        } failure:^(NSDictionary *error) {
            
        }];
        
//        [self formatAlertControllerWithTitle:nil message:@"电话号或密码不正确" andBtnTitleArr:@[@"确定", @"找回密码"] hand:^(NSString * _Nullable str) {
//            if ([str isEqualToString:@"确定"]) {
//                
//            }else if ([str isEqualToString:@"找回密码"]){
//                PersonModifyPasswordViewController *vc = [[PersonModifyPasswordViewController alloc] init];
//                vc.viewTitle = @"找回密码";
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }];
    }
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
