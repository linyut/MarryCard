//
//  OrderCardModelSelectHeaderView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderCardModelSelectHeaderView.h"
#import "OrderCardTypeView.h"
#import "OrderCardColorTableView.h"
#import "OrderCardNumberTableView.h"

#define HEADERSELECTCOLOR  @"F1263E"


@interface OrderCardModelSelectHeaderView ()

@property (strong, nonatomic) OrderCardTypeView *typeView;
@property (strong, nonatomic) OrderCardColorTableView *colorTableView;
@property (strong, nonatomic) OrderCardNumberTableView *numberTableView;



@end


@implementation OrderCardModelSelectHeaderView

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
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    self.backgroundColor = RGBACOLOR(0.5, 0.5, 0.5, 0.2);
    self.cardModelSelectIndex = 0;
    
    self.typeView = [[NSBundle mainBundle] loadNibNamed:@"OrderCardTypeView" owner:nil options:nil].lastObject;
    self.colorTableView = [[OrderCardColorTableView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, 132) style:UITableViewStylePlain];
    self.numberTableView = [[OrderCardNumberTableView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, 264) style:UITableViewStylePlain];
    self.typeView.hidden = YES;
    self.colorTableView.hidden = YES;
    self.numberTableView.hidden = YES;

    [self addSubview:self.typeView];
    [self addSubview:self.colorTableView];
    [self addSubview:self.numberTableView];

}

-(void)showTableViewWithIndex:(NSInteger)cardModelSelectIndex
{
    switch (cardModelSelectIndex) {
        case 0:
            self.typeView.hidden = NO;
            break;
        case 1:
            self.colorTableView.hidden = NO;
            break;
        case 2:
            self.numberTableView.hidden = NO;
            break;

        default:
            self.typeView.hidden = NO;
            break;
    }
}


- (IBAction)typeBtnClick:(UIButton *)sender {
    [self tableViewAllHidden];
    
    [sender setTitleColor:[UIColor colorWithHexString:HEADERSELECTCOLOR] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"下拉箭头 selected"] forState:UIControlStateNormal];
    self.typeView.hidden = NO;
}

- (IBAction)colorBtnClick:(UIButton *)sender {
    [self tableViewAllHidden];
    
    [sender setTitleColor:[UIColor colorWithHexString:HEADERSELECTCOLOR] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"下拉箭头 selected"] forState:UIControlStateNormal];
    self.colorTableView.hidden = NO;
}

- (IBAction)numberBtnClick:(UIButton *)sender {
    [self tableViewAllHidden];
    
    [sender setTitleColor:[UIColor colorWithHexString:HEADERSELECTCOLOR] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"下拉箭头 selected"] forState:UIControlStateNormal];
    self.numberTableView.hidden = NO;
}

-(void)tableViewAllHidden
{
    self.typeView.hidden = YES;
    self.colorTableView.hidden = YES;
    self.numberTableView.hidden = YES;
    
    [self.typeBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.colorBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.numberBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.typeBtn setImage:[UIImage imageNamed:@"下拉箭头"] forState:UIControlStateNormal];
    [self.colorBtn setImage:[UIImage imageNamed:@"下拉箭头"] forState:UIControlStateNormal];
    [self.numberBtn setImage:[UIImage imageNamed:@"下拉箭头"] forState:UIControlStateNormal];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self tableViewAllHidden];
    self.hidden = YES;
}


@end
