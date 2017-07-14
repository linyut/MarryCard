//
//  RadianBorderButton.m
//  VitalityBOC
//
//  Created by xiaowei on 16/11/21.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import "RadianBorderButton.h"

@implementation RadianBorderButton

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
    self.layer.borderColor =[UIColor colorWithHexString:@"FFFFFF"].CGColor;
    self.layer.borderWidth  = 0.25f;
}

@end
