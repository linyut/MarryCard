//
//  OrderSectionHeaderView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/11.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderSectionHeaderView.h"

@implementation OrderSectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)showHeaderViewWith:(NSDictionary *)cardInfoDict
{
    self.cardTagLabel.text = [NSString stringWithFormat:@"车型%ld",self.sectionIndex+1];
    if (self.sectionIndex == 0) {
        self.deleteCardBtn.hidden = YES;
        self.cardTypeLabelXConstraint.constant = 16.0f;
    }
    

}


//删除车辆类型
- (IBAction)deleteCardBtnClick:(UIButton *)sender {
    if (self.deleteCardBtnBlock) {
        self.deleteCardBtnBlock();
    }
}
//增加车辆类型
- (IBAction)addCardBtnClick:(UIButton *)sender {
    if (self.addCardBtnBlock) {
        self.addCardBtnBlock();
    }
}

- (IBAction)typeBtnClick:(UIButton *)sender {
    if (self.typeBtnBlock) {
        self.typeBtnBlock(0);
    }
    sender.selected = NO;
}

- (IBAction)colorBtnClick:(UIButton *)sender {
    if (self.colorBtnBlock) {
        self.colorBtnBlock(1);
    }
    sender.selected = NO;
}

- (IBAction)numberBtnClick:(UIButton *)sender {
    if (self.numberBtnBlock) {
        self.numberBtnBlock(2);
    }
    sender.selected = NO;
}
//添加经过地址
- (IBAction)addAddressBtnClick:(UIButton *)sender {
    if (self.addAddressBtnBlock) {
        self.addAddressBtnBlock();
    }
}
//选择出发地点
- (IBAction)selectStartAddressBtnClick:(UIButton *)sender {
    if (self.selectStartAddressBtnBlock) {
        self.selectStartAddressBtnBlock();
    }
}


@end
