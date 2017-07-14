//
//  MyCardRanksViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "MyCardRanksViewController.h"
#import "MyFriendCell.h"


@interface MyCardRanksViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *rankListTableView;

@end

@implementation MyCardRanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"我的车队" showLeftButton:YES andrightBtnTitle:nil];
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI
{
    self.rankListTableView.delegate = self;
    self.rankListTableView.dataSource = self;
    self.rankListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rankListTableView.estimatedRowHeight = 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.questionListArray.count;
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFriendCell *cell = [[NSBundle mainBundle] loadNibNamed:@"MyFriendCell" owner:nil options:nil].lastObject;
//    cell.questionLabel.text = self.questionListArray[indexPath.row];
//    cell.answerLabel.text = self.answerListArray[indexPath.row];
    
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
