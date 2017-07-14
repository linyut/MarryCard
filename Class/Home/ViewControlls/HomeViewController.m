//
//  HomeViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "SDCycleScrollView.h"
#import "OptionalCardViewController.h"
#import "PackageCardViewController.h"
#import "OrderCardDetailInfoViewController.h"



@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
//@property (strong, nonatomic) SDCycleScrollView *headerScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *headerBackImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerAddressLabel;



@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (assign, nonatomic) CGFloat imageWidth;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController setNavigationBarHidden:YES];
//    [self configTitle:@"" showLeftButton:NO andrightBtnTitle:nil];
    [self createUI];
    [self createHeaderScrollView];
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

-(void)createUI
{
    [self.headerBackImageView setImage:[DrawView drawRectangleWith:self.headerBackImageView.frame startColor:[UIColor colorWithHexString:@"D355E2"] endColor:[UIColor colorWithHexString:@"F74956"]]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTableView.tableHeaderView = self.headerView;
    
}

-(void)createHeaderScrollView
{
    self.imageWidth = self.headerScrollView.size.width-30.0;
    
//    self.headerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 78, kScreenWidth, 130) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
//    self.headerScrollView.localizationImageNamesGroup = @[@"banner", @"banner", @"banner"];
//    self.headerScrollView.autoScrollTimeInterval = 5.0;
//    self.headerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    self.headerScrollView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.headerScrollView];
    
    
    self.headerScrollView.contentSize = CGSizeMake(self.imageWidth*3+20, 140);
    self.headerScrollView.backgroundColor = [UIColor clearColor];
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15+self.imageWidth*i, 0, self.imageWidth-15, 140)];
        imageView.image = [UIImage imageNamed:@"banner"];
        [self.headerScrollView addSubview:imageView];
    }
    self.headerScrollView.delegate = self;
//    self.headerScrollView.pagingEnabled = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGPoint pt = scrollView.contentOffset;
//    int currentPage = pt.x/self.imageWidth;
//    if (currentPage == 4)
//    {
//        [self.headerScrollView setContentOffset:CGPointMake(self.imageWidth, 0) animated:NO];
//    }
//    if (currentPage == 0)
//    {
//        [self.headerScrollView setContentOffset:CGPointMake(self.imageWidth*3, 0) animated:NO];
//    }
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"第%ld张",index);
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}

#pragma mark - 自选婚车
- (IBAction)optionalBtnClick:(UIButton *)sender {
    OptionalCardViewController *optionalVC = [[OptionalCardViewController alloc] init];
    [self.navigationController hideTabbarPushViewController:optionalVC animated:YES];
}
#pragma mark - 婚车套餐
- (IBAction)packageBtnClick:(UIButton *)sender {
    PackageCardViewController *packageVC = [[PackageCardViewController alloc] init];
    [self.navigationController hideTabbarPushViewController:packageVC animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCardDetailInfoViewController *orderVC = [[OrderCardDetailInfoViewController alloc] init];
    orderVC.cardName = @"奥迪A6L";
    [self.navigationController hideTabbarPushViewController:orderVC animated:YES];
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
