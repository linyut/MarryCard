//
//  selectAddressCell.m
//  MarryCard
//
//  Created by linyut on 2017/7/10.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "IssueOrderCell.h"

@implementation IssueOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deleteBtnClick:(UIButton *)sender {
    if (self.deleteBtnBlock) {
        self.deleteBtnBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
