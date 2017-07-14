//
//  StatusImageView.m
//  PBPS-MA
//
//  Created by tk on 2017/1/19.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import "StatusImageView.h"

@implementation StatusImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        UIImage *image = [UIImage imageNamed:@"icon_triangle_down"];
        self.image = image;
    }
    else {
        UIImage *image = [UIImage imageNamed:@"icon_triangle_up"];
        self.image = image;
    }
}

@end
