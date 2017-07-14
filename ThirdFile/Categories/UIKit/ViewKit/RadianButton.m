//
//  RadianButton.m
//  PensionTreasure
//
//  Created by xiaowei on 16/7/1.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "RadianButton.h"

@implementation RadianButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

-(void)awakeFromNib{

    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds =YES;
}

@end
