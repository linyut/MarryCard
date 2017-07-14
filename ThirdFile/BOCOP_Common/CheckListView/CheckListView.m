//
//  CheckListView.m
//  EZDB
//
//  Created by mark on 15/11/13.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#define RGBAColor(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBColor(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight    [UIScreen mainScreen].bounds.size.height
#define kViewBackGroudColor   [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]

#import "CheckListView.h"

#define CheckCellHeight 42.0
#define TopBarHeight 45.0
#define NaviHeight 64.0

@implementation CheckCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CheckCellHeight)];
        self.titleLbl.font = [UIFont systemFontOfSize:14];
        self.titleLbl.textAlignment = NSTextAlignmentCenter;
        self.titleLbl.backgroundColor = [UIColor whiteColor];//kViewBackGroudColor;
        self.titleLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLbl];
        
        UIImage *image = [UIImage imageNamed:@"ico_ok.png"];
        self.checkFlag = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40,(CheckCellHeight - image
                                                                                           .size.height * 0.5) * 0.5, image.size.width * 0.5, image.size.height * 0.5)];
        _checkFlag.image = image;
        [self.contentView addSubview:_checkFlag];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CheckCellHeight - 1, kScreenWidth, 1)];
        line.backgroundColor = RGBColor(228, 230, 230);
        [self.contentView addSubview:line];
    }
    
    return self;
}

- (void)setCheckStatus:(NSString*)checkedStatus {
    if ([checkedStatus isEqualToString:@"1"]) {
//        _titleLbl.backgroundColor =kViewBackGroudColor;
//        _checkFlag.hidden = NO;
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
//        _titleLbl.backgroundColor =[UIColor whiteColor];
//        _checkFlag.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end


//------------------------------------

@interface CheckListView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *animateView;
@property (nonatomic,copy) NSString* titleText;
@property (nonatomic,copy) NSArray *allItems;
@property (nonatomic,strong) NSMutableArray *itemStatus;//保存列表中每一行的选择状态，用字符做标示：0-未选中，1-选中

@end

@implementation CheckListView

- (id)initWithDelegate:(id<CheckListViewDelegate>)delegate withListTitle:(NSString*)title withAllCheckItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = RGBAColor(0, 0, 0, 0.4);
        self.delegate = delegate;
        
        self.titleText = title;
        self.allItems = items;
        if (items) [self initListStatusWithItemsCount:[items count]];
        
        CGFloat halfScreenHeight = kScreenHeight * 0.5;
        CGFloat tHeight = [items count] * CheckCellHeight + TopBarHeight;
        tHeight = (tHeight > halfScreenHeight)?halfScreenHeight:tHeight;
        
        self.animateView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - NaviHeight,kScreenWidth,tHeight)];
        
        UIView *topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, TopBarHeight)];
        [topBar setBackgroundColor:[UIColor colorWithRed:0.7052 green:0.7052 blue:0.7052 alpha:1.0]];
        [_animateView addSubview:topBar];
        
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, TopBarHeight)];
        [titleLbl setBackgroundColor:[UIColor clearColor]];
        [titleLbl setTextColor:[UIColor darkGrayColor]];
        [titleLbl setText:title];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [topBar addSubview:titleLbl];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 80, 45)];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [topBar addSubview:button];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(kScreenWidth-80, 0, 80, 45)];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [topBar addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 1)];
        line.backgroundColor = RGBColor(228, 230, 230);
        [topBar addSubview:line];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topBar.frame.size.height, kScreenWidth, _animateView.frame.size.height-topBar.frame.size.height) style:UITableViewStylePlain];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        [tableView setRowHeight:42];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = kViewBackGroudColor;
        
        [self addSubview:_animateView];
        [_animateView addSubview:tableView];
    }
    
    return self;
}

- (void)initListStatusWithItemsCount:(NSInteger)count {
    self.itemStatus = [[NSMutableArray alloc] init];
    for (int i = 0;i < count;i++) {
        [_itemStatus addObject:@"0"];
    }
}

- (void)changeStatusInRow:(NSInteger)row {
    NSString *status = _itemStatus[row];
    if ([status isEqualToString:@"0"]) {
        [_itemStatus replaceObjectAtIndex:row withObject:@"1"];
    }
    else {
        [_itemStatus replaceObjectAtIndex:row withObject:@"0"];
    }
}

- (NSArray *)getCheckedItems {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0;i < [_itemStatus count];i++) {
        NSString *status = _itemStatus[i];
        if ([status isEqualToString:@"1"]) {
            [result addObject:[_allItems objectAtIndex:i]];
        }
    }
    
    return result;
}

- (void)cancelClick:(UIButton*)sender {
    [self hideView];
}

- (void)confirmClick:(UIButton*)sender {
    NSArray *checkItems = [self getCheckedItems];
    
    [UIView animateWithDuration:0.3 animations:^{
        [_animateView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, _animateView.frame.size.height)];
    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(onConfirm:withTitile:)]) {
            [_delegate onConfirm:checkItems withTitile:[_titleText copy]];
        }
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView*)view {
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [_animateView setFrame:CGRectMake(0, kScreenHeight-_animateView.frame.size.height - NaviHeight, kScreenWidth, _animateView.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_allItems) return 0;
    return _allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identer = @"checkCell";
    
    CheckCell *cell = [tableView dequeueReusableCellWithIdentifier:identer];
    if (!cell) {
        cell = [[CheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titleLbl.text = _allItems[indexPath.row];
    [cell setCheckStatus:[_itemStatus objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeStatusInRow:indexPath.row];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)hideView {
    [UIView animateWithDuration:0.3 animations:^{
        [_animateView setFrame:CGRectMake(0, kScreenHeight - NaviHeight, kScreenWidth, _animateView.frame.size.height)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    if (location.y < _animateView.frame.origin.y) {
        [self hideView];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
