//
//  NavigationBarForRoot.h
//  PBPS-MA
//
//  Created by mark on 2017/5/19.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarForRoot : UIView {
    UIView *_titleView;
}

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *titleView;

- (id)initWithBackgroundImageName:(NSString*)imageName;
- (void)setBackgroundAlpha:(CGFloat)alpha;

@end
