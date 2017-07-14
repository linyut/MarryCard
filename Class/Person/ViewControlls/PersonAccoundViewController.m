//
//  PersonAccoundViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "PersonAccoundViewController.h"
#import "PersonDrawMoneyViewController.h"

@interface PersonAccoundViewController ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

@implementation PersonAccoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"钱包" showLeftButton:YES andrightBtnTitle:@"明细"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)drawBtnClick:(UIButton *)sender {
    PersonDrawMoneyViewController *vc = [[PersonDrawMoneyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
