//
//  OptionalCardViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/28.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OptionalCardViewController.h"
#import "OptionalCardCell.h"

@interface OptionalCardViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *brandBtn;
@property (weak, nonatomic) IBOutlet UIButton *modelBtn;

@property (strong, nonatomic) NSArray *brandTitleArray;
@property (strong, nonatomic) NSArray *modelTitleArray;

@property (strong, nonatomic) MenuTableView *brandMenu;
@property (strong, nonatomic) MenuTableView *modelMenu;


@end

@implementation OptionalCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTitle:@"自选婚车" showLeftButton:YES andrightBtnTitle:nil];
    [self loadData];
    [self createUI];
    [self createMenuView];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadData
{
    self.brandTitleArray = @[@"宝马", @"奔驰", @"奥迪", @"布加迪", @"特斯拉", @"保时捷"];
    self.modelTitleArray = @[@"1系", @"2系", @"3系", @"4系", @"5系", @"6系"];

}

-(void)createUI
{
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    
    
}

-(void)createMenuView
{
    self.brandMenu = [[MenuTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 40*self.brandTitleArray.count) style:UITableViewStylePlain];
    [self.brandMenu showWithTitleArray:self.brandTitleArray andCoverFrame:CGRectMake(0, 109, kScreenWidth, kScreenHeight) andClickAction:^(NSInteger selectIndex) {
        NSLog(@"index = %ld",selectIndex);
        self.brandBtn.selected = NO;
        self.modelBtn.enabled = YES;
    }];

    self.modelMenu = [[MenuTableView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 40*self.brandTitleArray.count) style:UITableViewStylePlain];
    [self.modelMenu showWithTitleArray:self.modelTitleArray andCoverFrame:CGRectMake(0, 109, kScreenWidth, kScreenHeight) andClickAction:^(NSInteger selectIndex) {
        NSLog(@"index = %ld",selectIndex);
        self.modelBtn.selected = NO;
        self.brandBtn.enabled = YES;
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [self.brandBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 14)];
    [self.brandBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, -30)];
    [self.modelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 14)];
    [self.modelBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, -30)];
    
    return self.headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionalCardCell *cell = [[NSBundle mainBundle] loadNibNamed:@"OptionalCardCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MESSAGE(@"wait");
    
}

- (IBAction)brandBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.brandMenu showOrHidden:sender.selected];
    if (sender.selected) {
        self.modelBtn.enabled = NO;
    }else{
        self.modelBtn.enabled = YES;
    }
}

- (IBAction)modelBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.modelMenu showOrHidden:sender.selected];
    if (sender.selected) {
        self.brandBtn.enabled = NO;
    }else{
        self.brandBtn.enabled = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.brandMenu showOrHidden:NO];
    [self.modelMenu showOrHidden:NO];
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
