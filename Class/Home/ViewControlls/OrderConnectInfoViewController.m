//
//  OrderConnectInfoViewController.m
//  MarryCard
//
//  Created by linyut on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderConnectInfoViewController.h"

@interface OrderConnectInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *emergencyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emergencyPhoneTextField;


@property (weak, nonatomic) IBOutlet UIView *hasNameView;

@property (weak, nonatomic) IBOutlet UITextView *marryPersonNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *minorInfoTextField;



@property (weak, nonatomic) IBOutlet UIView *hasnotNameView;
@property (weak, nonatomic) IBOutlet UITextView *minorInfoTextView;


@property (weak, nonatomic) IBOutlet UIButton *selectAgreeBtn;



@end

@implementation OrderConnectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"联系信息" showLeftButton:YES andrightBtnTitle:nil];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)addressSelectBtnClick:(UIButton *)sender {
}


- (IBAction)selectAgreeBtnClick:(UIButton *)sender {
}

- (IBAction)agreementBtnClick:(UIButton *)sender {
}

- (IBAction)issueSuccessBtnClick:(UIButton *)sender {
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
