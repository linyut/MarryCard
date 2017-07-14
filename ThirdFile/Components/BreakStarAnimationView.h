//
//  BreakStarAnimationView.h
//  TestProject
//
//  Created by mark on 2017/5/3.
//  Copyright © 2017年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakStarAnimationView : UIView

@property (nonatomic,assign) BOOL isLarge;
@property (nonatomic,assign) BOOL isBreak;

- (void)createSubViews;
- (void)startAnimation;

@end
