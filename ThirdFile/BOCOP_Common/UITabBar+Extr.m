//
//  UITabBar+Extr.m
//  PBPS-MA
//
//  Created by tk on 2017/1/13.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import "UITabBar+Extr.h"

#define kViewId 1000

@implementation UITabBar(UITabBar_Extr)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showBadgeAtIndex:(NSInteger)index {
    NSArray *barButtons = [self barButtons];
    if (index >= barButtons.count) {
        return;
    }
    UIView *barButton = barButtons[index];
    UIView *badgeView = [barButton viewWithTag:kViewId + index];
//    NSLog(@"index:%d w:%f",(int)index,barButton.width);
    if (badgeView) {
        badgeView.hidden = NO;
    }
    else {
        badgeView = [self createBadgeViewWithCenterX:barButton.width * 0.5];
        badgeView.tag = kViewId + index;
        [barButton addSubview:badgeView];
    }
}

- (UIView*)createBadgeViewWithCenterX:(CGFloat)x {
    UIView *badgeView = [[UIView alloc] init];
    badgeView.frame = CGRectMake(x + 10, 10, 8, 8);
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.layer.cornerRadius = 4;
    badgeView.clipsToBounds = YES;
    return badgeView;
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    NSArray *barButtons = [self barButtons];
    if (index >= barButtons.count) {
        return;
    }
    UIView *barButton = barButtons[index];
    UIView *badgeView = [barButton viewWithTag:kViewId + index];
    if (badgeView) {
        badgeView.hidden = YES;
    }
}

- (NSArray*)barButtons {
    NSMutableArray *barBtns = [[NSMutableArray alloc] init];
    for (UIView *view in self.subviews) {
        if ([view.className isEqualToString:@"UITabBarButton"]) {
            [barBtns addObject:view];
        }
    }
    return barBtns;
}

@end
