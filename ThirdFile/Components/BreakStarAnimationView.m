//
//  BreakStarAnimationView.m
//  TestProject
//
//  Created by mark on 2017/5/3.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "BreakStarAnimationView.h"

@interface BreakStarAnimationView()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *pieces;

@end

@implementation BreakStarAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray*)pieces {
    if (!_pieces) {
        _pieces = [[NSMutableArray alloc] init];
        CGFloat lenght = _isLarge?5.:3.;
        
        for (int i = 0;i < 8;i++) {
            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lenght, lenght)];
            circle.backgroundColor = [UIColor orangeColor];
            circle.layer.cornerRadius = lenght / 2.;
            [circle setClipsToBounds:YES];
            [_pieces addObject:circle];
        }
    }
    
    return _pieces;
}

- (UIImageView*)imageView  {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        NSString *imageName = _isBreak?@"Icon_collect":@"Icon_collect_orange";
        _imageView.image = [UIImage imageNamed:imageName];
        if (_isLarge) {
            _imageView.frame = CGRectMake(0, 0, 22, 22);
        }
        else {
            _imageView.frame = CGRectMake(0, 0, 11, 11);
        }
    }
    
    return _imageView;
}

- (void)addPieces {
    for (UIView *piece in self.pieces) {
        piece.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        [self addSubview:piece];
    }
}

- (void)createSubViews {
    self.userInteractionEnabled = NO;
    if (_isBreak) {
        [self addPieces];
    }
    else {
        [self addSubview:self.imageView];
    }
}

- (void)startAnimation {
    if (_isBreak) {
        [UIView animateWithDuration:0.6 animations:^{
            CGFloat distance = _isLarge?35:20;
            int i = 0;
            CGPoint points[8] = {CGPointMake(-distance, 0),
                                 CGPointMake(-distance * 0.71, -distance * 0.71),
                                 CGPointMake(0, -distance),
                                 CGPointMake(distance * 0.71, -distance * 0.71),
                                 CGPointMake(distance, 0),
                                 CGPointMake(distance * 0.71, distance * 0.71),
                                 CGPointMake(0, distance),
                                 CGPointMake(-distance * 0.71, distance * 0.71)};
            for (UIView *piece in self.pieces) {
                CGPoint point = points[i];
                piece.center = CGPointMake(piece.center.x + point.x, piece.center.y + point.y);
                piece.alpha = 0.;
                i++;
            }
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
