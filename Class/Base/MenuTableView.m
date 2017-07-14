//
//  MenuTableView.m
//  MarryCard
//
//  Created by linyut on 2017/6/28.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "MenuTableView.h"


@interface MenuTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, copy)void (^selectBtnClick)(NSInteger selectIndex);
@property (nonatomic, strong)UIView *coverView;

@end

@implementation MenuTableView

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
        if (frame.size.height>kScreenHeight-64) {
            [self setHeight:kScreenHeight-64];
        }
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"SELECTMENUVIEWCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    if (self.selectBtnClick) {
        self.selectBtnClick(indexPath.row);
    }
}

-(void)showWithTitleArray:(NSArray *)titleArray andCoverFrame:(CGRect)coverFrame andClickAction:(void (^)(NSInteger selectIndex))clickAction
{
    self.titleArray = titleArray;
    self.selectBtnClick = clickAction;
    self.coverView = [[UIView alloc] init];
    if (!CGRectIsEmpty(coverFrame)) {
        [self.coverView setFrame:coverFrame];
    }else{
        [self.coverView setFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    }
    self.coverView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.4];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
    [self.coverView addGestureRecognizer:tapGes];
}

-(void)removeTap:(UITapGestureRecognizer *)sender
{
    [self hide];
    if (self.selectBtnClick) {
        self.selectBtnClick(10000);
    }
}


-(void)show
{
    //    self.frame = CGRectMake(0, 54, SCREEN_WIDTH, 0);
    //    [KAPPDELEGATE.window addSubview:self];
    //    [UIView animateWithDuration:0.3 animations:^{
    //        self.frame = CGRectMake(0, 54, SCREEN_WIDTH, SCREEN_HEIGHT-54);
    //    }];
    
//    self.frame = CGRectMake(0, 58, SCREEN_WIDTH, SCREEN_HEIGHT-58);
    [KAPPDELEGATE.window addSubview:self.coverView];
    [self.coverView addSubview:self];
}

-(void)hide{
    //    [UIView animateWithDuration:0.3 animations:^{
    //        self.frame = CGRectMake(0, 54, SCREEN_WIDTH, 0);
    //
    //    } completion:^(BOOL finished) {
    //        [self removeFromSuperview];
    //
    //    }];
    [self.coverView removeFromSuperview];
//    [self removeFromSuperview];
}

-(void)showOrHidden:(BOOL)isSHow
{
    if (isSHow) {
        [self show];
    }else{
        
        [self hide];
    }
}















@end
