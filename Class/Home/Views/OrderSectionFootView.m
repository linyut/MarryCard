//
//  OrderSectionFootView.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/11.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderSectionFootView.h"

@implementation OrderSectionFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)finishAddressBtnClick:(UIButton *)sender {
    if (self.finishAddressBtnBlock) {
        self.finishAddressBtnBlock();
    }
}

- (IBAction)selectDistanceAndTimeBtnClick:(UIButton *)sender {
    if (self.selectDistanceAndTimeBtnBlock) {
        self.selectDistanceAndTimeBtnBlock();
    }
}

@end
