//
//  IssueOrderViewController.m
//  MarryCard
//
//  Created by linyut on 2017/7/10.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "IssueOrderViewController.h"
#import "IssueOrderCell.h"
#import "OrderSectionHeaderView.h"
#import "OrderSectionFootView.h"
#import "XHDatePickerView.h"
#import "NSDate+Extension.h"
#import "OrderSelectAddressViewController.h"
#import "OrderCardModelSelectHeaderView.h"
#import "OrderConnectInfoViewController.h"


#define MAXDISTANCE 2000
#define MAXHOURS 24


@interface IssueOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *bigTabelView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;




@property (strong, nonatomic) IBOutlet UIView *footView;

@property (strong, nonatomic) IBOutlet UIView *distanceAndTimeSelectView;
@property (weak, nonatomic) IBOutlet UIView *distanceBackView;

@property (weak, nonatomic) IBOutlet UIPickerView *distanceAndTimeSelectPickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceBottomConstraint;



@property (strong, nonatomic) NSMutableArray *distanceArray;
@property (strong, nonatomic) NSMutableArray *hoursArray;

@property (strong, nonatomic) NSMutableDictionary *distanceAndTimeDict;




@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@property (strong, nonatomic) NSMutableArray *allDataArray;
@property (strong, nonatomic) NSMutableArray *subArray;
@property (strong, nonatomic) NSMutableArray *tempArray;

@property (strong, nonatomic) NSMutableDictionary *subDict;
@property (strong, nonatomic) NSMutableDictionary *tempDict;



@property (assign, nonatomic) NSInteger selectSection;

@property (strong, nonatomic) OrderCardModelSelectHeaderView *modelHeaderView;


@end

@implementation IssueOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"发布订单" showLeftButton:YES andrightBtnTitle:nil];
    [self prepareData];
    [self createUI];
    [self createDistanceAndTimeSelectView];
    // Do any additional setup after loading the view from its nib.
}

-(void)prepareData
{
    self.selectSection = 0;
    self.allDataArray = [NSMutableArray array];
    self.subArray = [NSMutableArray array];
    self.tempArray = [NSMutableArray array];
    self.subDict = [NSMutableDictionary dictionary];
    self.tempDict = [NSMutableDictionary dictionary];
    self.distanceAndTimeDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"distance":@"", @"hours":@""}];

    self.subDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"cardType":@"", @"cardColor":@"", @"cardNum":@"", @"basePrice":@"", @"timePrice":@"", @"distancePrice":@"", @"startAddress":@"", @"finishAddress":@"", @"passAddress":@[], @"selectDistanceIndex":@"0", @"selectHoursIndex":@"0"}];
    
    self.tempDict = [self.subDict mutableCopy];
    [self.allDataArray addObject:self.tempDict];
    
    
    self.distanceArray = [NSMutableArray array];
    for (int i = 1; i<MAXDISTANCE; i++) {
        if (i%5 == 0) {
            [self.distanceArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    self.hoursArray = [NSMutableArray array];
    for (int i = 1; i<MAXHOURS; i++) {
        [self.hoursArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
}

-(void)createUI
{
    self.bigTabelView.delegate = self;
    self.bigTabelView.dataSource = self;
    self.bigTabelView.tableHeaderView = self.headerView;
    self.bigTabelView.tableFooterView = self.footView;
    self.bigTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.modelHeaderView = [[NSBundle mainBundle] loadNibNamed:@"OrderCardModelSelectHeaderView" owner:nil options:nil].lastObject;
    [self.view addSubview:self.modelHeaderView];
    [self.view bringSubviewToFront:self.modelHeaderView];
    self.modelHeaderView.hidden = YES;
    
}


-(void)createDistanceAndTimeSelectView
{
    self.distanceAndTimeSelectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.distanceBackView.layer.masksToBounds = YES;
    self.distanceBackView.layer.cornerRadius = 10;
    
    self.distanceAndTimeSelectPickerView.delegate = self;
    self.distanceAndTimeSelectPickerView.dataSource = self;
    
    
    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.distanceAndTimeSelectView addGestureRecognizer:tap];
    
    self.distanceBottomConstraint.constant = -235;
    self.distanceAndTimeSelectView.backgroundColor = RGBACOLOR(0, 0, 0, 0);

}

-(void)show {
    NSDictionary *dict = self.allDataArray[self.selectSection];
    NSString *selectDistanceIndex = dict[@"selectDistanceIndex"];
    NSInteger distanceIndex = [selectDistanceIndex integerValue];
    NSString *selectHoursIndex = dict[@"selectHoursIndex"];
    NSInteger hoursIndex = [selectHoursIndex integerValue];
    
    [self.distanceAndTimeSelectPickerView selectRow:distanceIndex inComponent:0 animated:YES];
    [self.distanceAndTimeSelectPickerView selectRow:hoursIndex inComponent:1 animated:YES];

    [[UIApplication sharedApplication].keyWindow addSubview:self.distanceAndTimeSelectView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.distanceAndTimeSelectView];

    [UIView animateWithDuration:.3 animations:^{
        self.distanceBottomConstraint.constant = 10;
        self.distanceAndTimeSelectView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    }];
}
-(void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        self.distanceBottomConstraint.constant = -235;
        self.distanceAndTimeSelectView.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self.distanceAndTimeSelectView removeFromSuperview];
    }];
}


#pragma mark - UIPickerDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (0 == component) {
        return self.distanceArray.count;
    }
    else if (1 == component){
        return self.hoursArray.count;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
#pragma mark 填充文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        return self.distanceArray[row];
    }
    else if (1 == component) {
        return self.hoursArray[row];
    }
    return nil;
}

#pragma mark pickerView被选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component) {
        [self.distanceAndTimeDict setObject:[NSString stringWithFormat:@"%ld",row] forKey:@"distance"];
    }
    else if (1 == component){
        [self.distanceAndTimeDict setObject:[NSString stringWithFormat:@"%ld",row] forKey:@"hours"];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor colorWithRed:51.0/255
                                                green:51.0/255
                                                 blue:51.0/255
                                                alpha:1.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text = [self pickerView:pickerView
                            titleForRow:row
                           forComponent:component];
    return pickerLabel;
}




#pragma mark - UITableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 324;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 142;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderSectionHeaderView *sectionHeaderView = [[NSBundle mainBundle] loadNibNamed:@"OrderSectionHeaderView" owner:nil options:nil].lastObject;
    sectionHeaderView.addCardBtn.layer.borderWidth = 1;
    sectionHeaderView.addCardBtn.layer.borderColor = [UIColor colorWithHexString:@"FA5353"].CGColor;
    sectionHeaderView.addCardBtn.layer.masksToBounds = YES;
    sectionHeaderView.addCardBtn.layer.cornerRadius = 4;
    
    sectionHeaderView.addAddressBtn.layer.borderWidth = 1;
    sectionHeaderView.addAddressBtn.layer.borderColor = [UIColor colorWithHexString:@"FA5353"].CGColor;
    sectionHeaderView.addAddressBtn.layer.masksToBounds = YES;
    sectionHeaderView.addAddressBtn.layer.cornerRadius = 4;
    
    sectionHeaderView.sectionIndex = section;
    [sectionHeaderView showHeaderViewWith:self.allDataArray[section]];
    
    NSMutableDictionary *sectionDict = self.allDataArray[section];
    sectionHeaderView.deleteCardBtnBlock = ^{
        [self.allDataArray removeObjectAtIndex:section];
        [self.bigTabelView reloadData];
    };
    sectionHeaderView.addCardBtnBlock = ^{
        self.tempDict = [self.subDict mutableCopy];
        [self.allDataArray addObject:self.tempDict];
        [self.bigTabelView reloadData];
    };
    sectionHeaderView.typeBtnBlock = ^(NSInteger selectIndex){
        self.modelHeaderView.hidden = NO;
        [self.modelHeaderView showTableViewWithIndex:selectIndex];

    };
    sectionHeaderView.colorBtnBlock = ^(NSInteger selectIndex){
        self.modelHeaderView.hidden = NO;
        [self.modelHeaderView showTableViewWithIndex:selectIndex];

    };
    sectionHeaderView.numberBtnBlock = ^(NSInteger selectIndex){
        self.modelHeaderView.hidden = NO;
        [self.modelHeaderView showTableViewWithIndex:selectIndex];

    };
    sectionHeaderView.addAddressBtnBlock = ^{
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:sectionDict[@"passAddress"]];
        [array addObject:@"黄河"];
        [sectionDict setObject:array forKey:@"passAddress"];
        [self.bigTabelView reloadData];
    };
    sectionHeaderView.selectStartAddressBtnBlock = ^{
        OrderSelectAddressViewController *addressVC = [[OrderSelectAddressViewController alloc] init];
        addressVC.addressBlock = ^(NSString *address){
            
        };
        [self.navigationController pushViewController:addressVC animated:YES];
    };

    return sectionHeaderView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderSectionFootView *sectionFootView = [[NSBundle mainBundle] loadNibNamed:@"OrderSectionFootView" owner:nil options:nil].lastObject;
    NSDictionary *dict = self.allDataArray[section];
    NSString *selectDistanceIndex = dict[@"selectDistanceIndex"];
    NSInteger distanceIndex = [selectDistanceIndex integerValue];
    NSString *selectHoursIndex = dict[@"selectHoursIndex"];
    NSInteger hoursIndex = [selectHoursIndex integerValue];
    sectionFootView.selectDistanceAndTimeLabel.text = [NSString stringWithFormat:@"%@公里%@小时",self.distanceArray[distanceIndex],self.hoursArray[hoursIndex]];
    sectionFootView.finishAddressBtnBlock = ^{
        OrderSelectAddressViewController *addressVC = [[OrderSelectAddressViewController alloc] init];
        addressVC.addressBlock = ^(NSString *address){
            
        };
        [self.navigationController pushViewController:addressVC animated:YES];
    };
    sectionFootView.selectDistanceAndTimeBtnBlock = ^{
        self.selectSection = section;
        [self.distanceAndTimeDict setObject:selectDistanceIndex forKey:@"distance"];
        [self.distanceAndTimeDict setObject:selectHoursIndex forKey:@"hours"];
        [self show];
    };
    
    
    
    return sectionFootView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *subDict = self.allDataArray[section];
    NSArray *addressArray = subDict[@"passAddress"];
    return addressArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IssueOrderCell *cell = [[NSBundle mainBundle] loadNibNamed:@"IssueOrderCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addressTagLabel.text = [NSString stringWithFormat:@"经过地点%ld",indexPath.row+1];
    NSMutableDictionary *sectionDict = self.allDataArray[indexPath.section];
    cell.deleteBtnBlock = ^{
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:sectionDict[@"passAddress"]];
        [array removeObjectAtIndex:indexPath.row];
        [sectionDict setObject:array forKey:@"passAddress"];
        [self.bigTabelView reloadData];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSelectAddressViewController *addressVC = [[OrderSelectAddressViewController alloc] init];
    addressVC.addressBlock = ^(NSString *address){
        
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

#pragma mark - 选择日期
- (IBAction)dateBtnClick:(UIButton *)sender {
    [self createDatePickViewWithBtnTag:sender.tag];
}

-(void)createDatePickViewWithBtnTag:(NSInteger)btnTag
{
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
        
        NSDateFormatter *dateForm = [[NSDateFormatter alloc]init];
        dateForm.dateFormat = @"yyyy-MM-dd";
        NSString *selectDataStr = [dateForm stringFromDate:startDate];
        NSString *nowDateStr = [dateForm stringFromDate:[NSDate date]];
        if (selectDataStr.length > 0) {
            self.dateLabel.text = selectDataStr;
        }else{
            self.dateLabel.text = nowDateStr;
        }
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeStartDate;
    NSDateFormatter *dateForm = [[NSDateFormatter alloc]init];
    dateForm.dateFormat = @"yyyy-MM-dd HH:mm";
    
    datepicker.minLimitDate = [NSDate date];
    datepicker.maxLimitDate = [dateForm dateFromString:@"2222-2-2 00:00"];

    [datepicker show];
}


#pragma mark - 选择距离和时间确定按钮点击事件
- (IBAction)distanceAndTimeSelectSureBtnClick:(UIButton *)sender {
    [self dismiss];
    NSMutableDictionary *subDict = self.allDataArray[self.selectSection];
    [subDict setObject:self.distanceAndTimeDict[@"distance"] forKey:@"selectDistanceIndex"];
    [subDict setObject:self.distanceAndTimeDict[@"hours"] forKey:@"selectHoursIndex"];
    [self.bigTabelView reloadData];
}

#pragma mark - 发布按钮
- (IBAction)nextBtnClick:(UIButton *)sender {
    OrderConnectInfoViewController *infoVC = [[OrderConnectInfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoVC animated:YES];
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
