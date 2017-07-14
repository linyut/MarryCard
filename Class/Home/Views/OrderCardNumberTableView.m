//
//  OrderCardNumberTableView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderCardNumberTableView.h"
#import "OrderCardNumberCell.h"



#define kCellID @"kOrderCardNumberCellID"


@interface OrderCardNumberTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger selectIndex;

@end

@implementation OrderCardNumberTableView

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
        self.selectIndex = 0;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.tableFooterView = [UIView new];
        [self registerNib:[UINib nibWithNibName:@"OrderCardNumberCell" bundle:nil] forCellReuseIdentifier:kCellID];
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
    return 99;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCardNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
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
