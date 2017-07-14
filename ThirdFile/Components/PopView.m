//
//  PopView.m
//  PBPS-MA
//
//  Created by tk on 2017/1/18.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import "PopView.h"

@interface PopView()

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation PopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.textLabel.text = text;
        [self.textLabel sizeToFit];
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];
        [self addSubview:self.textLabel];
        [self layoutSubviews];
    }
    
    return self;
}

- (UIImageView*)leftImageView {
    if (!_leftImageView) {
        UIImage *image = [UIImage imageNamed:@"bg_bubble_left"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 34, 0, 14) resizingMode:UIImageResizingModeStretch];
        _leftImageView = [[UIImageView alloc] initWithImage:image];
        _leftImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    return _leftImageView;
}

- (UIImageView*)rightImageView {
    if (!_rightImageView) {
        UIImage *image = [UIImage imageNamed:@"bg_bubble_right"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 34) resizingMode:UIImageResizingModeStretch];
        _rightImageView = [[UIImageView alloc] initWithImage:image];
        _rightImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    
    return _rightImageView;
}

- (UILabel*)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor whiteColor];
    }
    
    return _textLabel;
}

- (void)layoutSubviews {
    CGFloat space = 16;
    CGFloat w = self.textLabel.width + 2 * space;
    CGFloat h = self.leftImageView.height;
    self.frame = CGRectMake(0, 0, w, h);
    self.leftImageView.frame = CGRectMake(0, 0, w * 0.5, h);
    self.rightImageView.frame = CGRectMake(w * 0.5, 0, w * 0.5, h);
    self.textLabel.frame = CGRectMake(space, (h - self.textLabel.height) * 0.5 - 5, self.textLabel.width, self.textLabel.height);
}

- (UIImage*)getLayerImage {
    CGSize s = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
