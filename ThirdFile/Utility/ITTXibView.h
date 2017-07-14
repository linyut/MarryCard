//
//  ITTXibView.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/9/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITTXibView : UIView
+ (id)loadFromXib;

+ (id)loadFromXibI5;

- (UIView*)keyboardView;

- (UIView*)viewForView:(UIView *)view;

@end
