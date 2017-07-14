//
//  StarLevelView.m
//  PBPS-MA
//
//  Created by tk on 16/12/28.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import "StarLevelView.h"

#define kStarWidth 16
#define kStarHeigth 17
#define kSpace 5

@interface StarLevelView()

@property (nonatomic,strong) NSArray *normalStars;
@property (nonatomic,strong) NSArray *lightStars;

@end

@implementation StarLevelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addNormalStars];
    [self addLightStars];
}

- (void)addNormalStars {
    for (UIView *star in self.normalStars) {
        [self addSubview:star];
    }
}

- (void)addLightStars {
    for (UIView *star in self.lightStars) {
        [self addSubview:star];
    }
}

- (NSArray*)normalStars {
    if (!_normalStars) {
        NSMutableArray *stars = [[NSMutableArray alloc] init];
        for (int i = 0;i < 5;i++) {
            UIImageView *starView = [[UIImageView alloc] init];
            starView.image = [UIImage imageNamed:@"Icon_star"];
            starView.frame = CGRectMake(i * (kStarWidth + kSpace), 0, kStarWidth, kStarHeigth);
            [stars addObject:starView];
        }
        _normalStars = stars;
    }
    
    return _normalStars;
}

- (NSArray*)lightStars {
    if (!_lightStars) {
        NSMutableArray *stars = [[NSMutableArray alloc] init];
        for (int i = 0;i < 5;i++) {
            UIImageView *starView = [[UIImageView alloc] init];
            starView.image = [UIImage imageNamed:@"Icon_star_select"];
            starView.frame = CGRectMake(i * (kStarWidth + kSpace), 0, kStarWidth, kStarHeigth);
            starView.hidden = YES;
            [stars addObject:starView];
        }
        _lightStars = stars;
    }
    
    return _lightStars;
}

- (void)hideLightStars {
    for (UIView *star in self.lightStars) {
        star.hidden = YES;
    }
}

- (void)setStarLevel:(int)level {
    [self hideLightStars];
    for (int i = 0; (i < level && i < 5); i++) {
        UIView *star = self.lightStars[i];
        star.hidden = NO;
    }
}

@end
