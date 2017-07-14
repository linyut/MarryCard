//
//  SelectMenuView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/28.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "SelectMenuView.h"

@interface SelectMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *menuTableView;

@end

@implementation SelectMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)showWithMenuViewFrame:(CGRect)menuFrame andListFrame:(CGRect)listFrame
{
    [self setFrame:menuFrame];
    self.backgroundColor = [UIColor clearColor];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    
//    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 144,6, 140, 300)];
//    secondView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
//    secondView.layer.cornerRadius = 6;
//    secondView.clipsToBounds = YES;
//    [self addSubview:secondView];
    
    self.menuTableView = [[UITableView alloc] initWithFrame:listFrame];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.showsVerticalScrollIndicator = NO;
    self.menuTableView.showsHorizontalScrollIndicator = NO;
    self.menuTableView.bounces = NO;
    self.menuTableView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self addSubview:self.menuTableView];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds= YES;
        [self creatViews];
    }
    return self;
}

-(void)creatViews
{
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];

    self.menuTableView = [[UITableView alloc] initWithFrame:self.frame];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.showsVerticalScrollIndicator = NO;
    self.menuTableView.showsHorizontalScrollIndicator = NO;
    self.menuTableView.bounces = NO;
    self.menuTableView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    
}

-(void)show
{
    //    self.frame = CGRectMake(0, 54, SCREEN_WIDTH, 0);
    //    [KAPPDELEGATE.window addSubview:self];
    //    [UIView animateWithDuration:0.3 animations:^{
    //        self.frame = CGRectMake(0, 54, SCREEN_WIDTH, SCREEN_HEIGHT-54);
    //    }];
    
    self.frame = CGRectMake(0, 58, SCREEN_WIDTH, SCREEN_HEIGHT-58);
    [KAPPDELEGATE.window addSubview:self];
}

-(void)hide{
    //    [UIView animateWithDuration:0.3 animations:^{
    //        self.frame = CGRectMake(0, 54, SCREEN_WIDTH, 0);
    //
    //    } completion:^(BOOL finished) {
    //        [self removeFromSuperview];
    //
    //    }];
    [self removeFromSuperview];
}

-(void)showOrHidden:(BOOL)isSHow
{
    if (isSHow) {
        [self show];
    }else{
        
        [self hide];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
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
    if (self.selectBtnClick) {
        self.selectBtnClick(indexPath.row);
    }
}


//-(UIView *)showMenuViewWith:(NSArray *)titleArray andFrame:(CGRect)frame
//{
//    UIView *backView = [[UIView alloc] initWithFrame:frame];
//    [backView setHeight:40*titleArray.count];
//    
//    return backView;
//}



@end
