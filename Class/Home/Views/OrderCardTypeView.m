//
//  OrderCardTypeView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/13.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderCardTypeView.h"
#import "OrderCardTypeLeftCell.h"
#import "OrderCardTypeRightCell.h"


#define kLeftCellID   @"OrderCardTypeLeftCell"
#define kRightCellID   @"OrderCardTypeRightCell"


@interface OrderCardTypeView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *typeLeftTableView;
@property (weak, nonatomic) IBOutlet UITableView *typeRightTableView;

@property (assign, nonatomic) NSInteger leftSelectIndex;
@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) NSMutableArray *selectIndexArray;

@property (strong, nonatomic) NSArray *cardImageArray;
@property (strong, nonatomic) NSArray *cardNameArray;
@property (strong, nonatomic) NSMutableArray *cardNameDetailArray;


@end

@implementation OrderCardTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 54, kScreenWidth, 264);
    
    self.leftSelectIndex = 0;
    self.selectIndexArray = [[NSMutableArray alloc] initWithArray:@[@0, @0, @0, @0, @0, @0]];
    self.cardImageArray = @[@"logo 宝马", @"logo 奔驰", @"logo 奥迪", @"logo 布加迪", @"logo 特斯拉", @"logo 保时捷"];
    self.cardNameArray = @[@"宝马", @"奔驰", @"奥迪", @"布加迪", @"特斯拉", @"保时捷"];
    self.cardNameDetailArray = [[NSMutableArray alloc] initWithArray:@[@[@"1系", @"2系", @"3系", @"4系", @"5系", @"6系"], @[@"1系", @"3系", @"4系", @"5系", @"6系"], @[@"1系", @"2系", @"6系"], @[@"1系", @"2系", @"3系", @"4系",@"6系"], @[@"2系", @"3系", @"4系", @"5系", @"6系"], @[@"1系", @"2系", @"4系", @"5系", @"6系"]]];
    
    self.typeLeftTableView.delegate = self;
    self.typeLeftTableView.dataSource = self;
    [self.typeLeftTableView registerNib:[UINib nibWithNibName:@"OrderCardTypeLeftCell" bundle:nil] forCellReuseIdentifier:kLeftCellID];

    self.typeRightTableView.delegate = self;
    self.typeRightTableView.dataSource = self;
    [self.typeRightTableView registerNib:[UINib nibWithNibName:@"OrderCardTypeRightCell" bundle:nil] forCellReuseIdentifier:kRightCellID];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.typeLeftTableView) {
        return self.cardNameArray.count;
    }else if (tableView == self.typeRightTableView){
        NSArray *subArray = self.cardNameDetailArray[self.leftSelectIndex];
        return [subArray count];
    }else{
        return 6;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.typeLeftTableView) {
        OrderCardTypeLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftCellID];
        cell.cardImageView.image = [UIImage imageNamed:self.cardImageArray[indexPath.row]];
        cell.cardNameLabel.text = self.cardNameArray[indexPath.row];
        if (self.leftSelectIndex == indexPath.row) {
            cell.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
        }else{
            cell.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        }
        return cell;
    }else if (tableView == self.typeRightTableView){
        OrderCardTypeRightCell *cell = [tableView dequeueReusableCellWithIdentifier:kRightCellID];
        NSArray *subArray = self.cardNameDetailArray[self.leftSelectIndex];
        cell.detailLabel.text = subArray[indexPath.row];
        
        NSNumber *index = self.selectIndexArray[self.leftSelectIndex];
        if ([index integerValue] == indexPath.row) {
            cell.selectImageView.hidden = NO;
        }else{
            cell.selectImageView.hidden = YES;
        }

        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.typeLeftTableView) {
        self.leftSelectIndex = indexPath.row;
    }else if (tableView == self.typeRightTableView){
        self.selectIndex = indexPath.row;
        [self.selectIndexArray setObject:[NSNumber numberWithInteger:indexPath.row] atIndexedSubscript:self.leftSelectIndex];
    }else{
        
    }
    [self.typeLeftTableView reloadData];
    [self.typeRightTableView reloadData];
}



@end
