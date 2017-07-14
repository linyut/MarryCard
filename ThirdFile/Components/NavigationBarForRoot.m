//
//  NavigationBarForRoot.m
//  PBPS-MA
//
//  Created by mark on 2017/5/19.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import "NavigationBarForRoot.h"

@implementation NavigationBarForRoot

- (id)initWithBackgroundImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 64.);
        self.backgroundColor = [UIColor clearColor];
        UIImage *bgImage = [UIImage imageNamed:imageName];
        bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        self.backImageView.image = bgImage;
        [self addSubview:self.backImageView];
    }
    
    return self;
}

- (UIImageView*)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.frame = self.bounds;
    }
    
    return _backImageView;
}

- (UIView*)titleView {
    if (!_titleView) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 20)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:16.];
        _titleView = titleLabel;
    }
    
    return _titleView;
}

- (void)setTitleView:(UIView *)titleView {
    [_titleView removeFromSuperview];
    _titleView = titleView;
    _titleView.frame = CGRectMake((kScreenWidth - _titleView.width) * 0.5, 20 + (40 - _titleView.height) * 0.5, _titleView.width, _titleView.height);
    [self addSubview:_titleView];
}

- (void)setBackgroundAlpha:(CGFloat)alpha {
    self.backImageView.alpha = alpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
