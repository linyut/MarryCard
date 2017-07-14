//
//  PersonViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/21.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonCell.h"
#import "PersonDetailViewController.h"
#import "PersonAccoundViewController.h"
#import "PersonDrawMoneyViewController.h"
#import "CompanyInfoViewController.h"
#import "MyCardRanksViewController.h"
#import "MyFriendsViewController.h"
#import "HelpCenterViewController.h"
#import "ContactPhoneViewController.h"
#import "QuestionSubmitViewController.h"
#import "PersonSettingViewController.h"


@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *personTableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;


@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (strong, nonatomic) NSArray *titleItemArray;
@property (strong, nonatomic) NSArray *imageItemArray;


@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"" showLeftButton:NO andrightBtnTitle:nil];
    [self prepareData];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)prepareData
{
    self.titleItemArray = @[@[@"企业认证", @"我的车队", @"我的好友"], @[@"帮助中心", @"联系我们", @"意见反馈"], @[@"设置"]];
    self.imageItemArray = @[@[@"个人 企业认证", @"个人 我的车队", @"个人 我的好友"], @[@"个人 帮助中心", @"个人 联系我们", @"个人 意见反馈"], @[@"个人 设置"]];
}

-(void)createUI
{
    self.personTableView.delegate = self;
    self.personTableView.dataSource = self;
    self.personTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (IBAction)codeNumberBtnClick:(UIButton *)sender {
    PersonDetailViewController *vc = [[PersonDetailViewController alloc] init];
    [self.navigationController hideTabbarPushViewController:vc animated:YES];
}

- (IBAction)moneyBtnClick:(UIButton *)sender {
    PersonAccoundViewController *vc = [[PersonAccoundViewController alloc] init];
    [self.navigationController hideTabbarPushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleItemArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleItemArray[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 179;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.headerView;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        headerView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        return headerView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = [[NSBundle mainBundle] loadNibNamed:@"PersonCell" owner:nil options:nil].lastObject;
    cell.titleLabel.text = self.titleItemArray[indexPath.section][indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:self.imageItemArray[indexPath.section][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    CompanyInfoViewController *vc = [[CompanyInfoViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }
                case 1:
                {
                    MyCardRanksViewController *vc = [[MyCardRanksViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    MyFriendsViewController *vc = [[MyFriendsViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }

                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    HelpCenterViewController *vc = [[HelpCenterViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }
                case 1:
                {
                    ContactPhoneViewController *vc = [[ContactPhoneViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    QuestionSubmitViewController *vc = [[QuestionSubmitViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    PersonSettingViewController *vc = [[PersonSettingViewController alloc] init];
                    [self.navigationController hideTabbarPushViewController:vc animated:YES];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }

        default:
            break;
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
