//
//  BreakHeartAnimationView.m
//  TestProject
//
//  Created by mark on 2017/5/3.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "BreakHeartAnimationView.h"

@interface BreakHeartAnimationView()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;

@end

@implementation BreakHeartAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImageView*)imageView  {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        NSString *imageName = _isBreak?@"icon_details_heart_gray":@"icon_details_heart_red";
        _imageView.image = [UIImage imageNamed:imageName];
        if (_isLarge) {
            _imageView.frame = CGRectMake(0, 0, 24, 21);
        }
        else {
            _imageView.frame = CGRectMake(0, 0, 12, 11);
        }
    }
    
    return _imageView;
}

- (UIImageView*)leftImageView  {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"like_left"];
        if (_isLarge) {
            _leftImageView.frame = CGRectMake(0, 0, 12, 19);
        }
        else {
            _leftImageView.frame = CGRectMake(0, 0, 6, 6);
        }
    }
    
    return _leftImageView;
}

- (UIImageView*)rightImageView  {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"like_right"];
        if (_isLarge) {
            _rightImageView.frame = CGRectMake(10, 0, 13, 19);
        }
        else {
            _rightImageView.frame = CGRectMake(5, 0, 6, 6);
        }
    }
    
    return _rightImageView;
}

- (void)createSubViews {
    self.userInteractionEnabled = NO;
    if (_isBreak) {
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];
    }
    else {
        [self addSubview:self.imageView];
    }
}

- (void)startAnimation {
    if (_isBreak) {
        [UIView animateWithDuration:1.4 animations:^{
            CGFloat hLenght = _isLarge?5:3;
            CGFloat vLenght = _isLarge?50:20;
            CGFloat angle = _isLarge?40:20;
            _leftImageView.left = _leftImageView.left - hLenght;
            _rightImageView.left = _rightImageView.left + hLenght;
            _leftImageView.transform = CGAffineTransformMakeRotation(-angle * M_PI /180.0);
            _leftImageView.transform = CGAffineTransformMakeTranslation(0, vLenght);
            
            _rightImageView.transform = CGAffineTransformMakeRotation(angle * M_PI /180.0);
            _rightImageView.transform = CGAffineTransformMakeTranslation(0, vLenght);
            
            _leftImageView.alpha = 0.;
            _rightImageView.alpha = 0.;
            
        }
        completion:^(BOOL finished)
        {
            [self removeFromSuperview];
             
        }];
    }
    else {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
}

@end
