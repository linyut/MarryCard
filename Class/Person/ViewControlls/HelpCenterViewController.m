//
//  HelpCenterViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpCenterCell.h"

@interface HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *helpListTableView;

@property (strong, nonatomic) NSArray *questionListArray;
@property (strong, nonatomic) NSArray *answerListArray;

@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"帮助中心" showLeftButton:YES andrightBtnTitle:nil];
    [self prepareData];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)prepareData
{
    self.questionListArray = @[@"如何下单？", @"如何注册？"];
    self.answerListArray = @[@"一个算法执行所耗费的时间，从理论上是不能算出来的，必须上机运行测试才能知道。但我们不可能也没有必要对每个算法都上机测试，只需知道哪个算法花费的时间多，哪个算法花费的时间少就可以了。并且一个算法花费的时间与算法中语句的执行次数成正比例", @"同一问题可用不同算法解决，而一个算法的质量优劣将影响到算法乃至程序的效率。算法分析的目的在于选择合适算法和改进算法。一个算法的评价主要从时间复杂度和空间复杂度来考虑"];
}

-(void)createUI
{
    self.helpListTableView.delegate = self;
    self.helpListTableView.dataSource = self;
    self.helpListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.helpListTableView.estimatedRowHeight = 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpCenterCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HelpCenterCell" owner:nil options:nil].lastObject;
    cell.questionLabel.text = self.questionListArray[indexPath.row];
    cell.answerLabel.text = self.answerListArray[indexPath.row];
    
    return cell;
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
