//
//  PackageCardViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/28.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "PackageCardViewController.h"
#import "PackageCardCell.h"

@interface PackageCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation PackageCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"婚车套餐" showLeftButton:YES andrightBtnTitle:nil];
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI
{
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PackageCardCell *cell = [[NSBundle mainBundle] loadNibNamed:@"PackageCardCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
