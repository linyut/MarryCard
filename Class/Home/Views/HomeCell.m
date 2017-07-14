//
//  HomeCell.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/22.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bandView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bandView.layer.shadowOffset = CGSizeMake(0, 1);
    self.bandView.layer.shadowOpacity = 0.5;   //阴影不透明度
    self.bandView.layer.shadowRadius = 1.0;//阴影半径
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
