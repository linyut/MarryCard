//
//  OrderCardColorTableView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderCardColorTableView.h"
#import "OrderCardColorCell.h"



#define kCellID @"kOrderCardColorCellID"


@interface OrderCardColorTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger selectIndex;


@end

@implementation OrderCardColorTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self != nil) {
        
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        [self registerNib:[UINib nibWithNibName:@"OrderCardColorCell" bundle:nil] forCellReuseIdentifier:kCellID];
    }
    return self;
}


-(void)refreshTableView
{
    [self showTableView];
    [self reloadData];
}


-(void)showTableView
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCardColorCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    switch (indexPath.row) {
        case 0:
            [cell.colorImageView setImage:[UIImage imageNamed:@"颜色 随机"]];
            cell.colorLabel.text = @"随机/彩色";
            cell.colorLabel.textColor = [UIColor colorWithHexString:@"F1263E"];
            
            break;
        case 1:
            [cell.colorImageView setImage:[UIImage imageNamed:@"颜色 黑色"]];
            cell.colorLabel.text = @"黑色";
            cell.colorLabel.textColor = [UIColor colorWithHexString:@"333333"];
            
            break;
        case 2:
            [cell.colorImageView setImage:[UIImage imageNamed:@"颜色 白色"]];
            cell.colorLabel.text = @"白色";
            cell.colorLabel.textColor = [UIColor colorWithHexString:@"333333"];
            
            break;

        default:
            break;
    }
    
    
    if (self.selectIndex == indexPath.row) {
        cell.selectImageView.hidden = NO;
    }else{
        cell.selectImageView.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectIndex = indexPath.row;
    [tableView reloadData];
}


@end
