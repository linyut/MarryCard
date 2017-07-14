//
//  BaseNFGXibView.h
//  PensionTreasure
//
//  Created by Simon on 16/7/4.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNFGXibView : UIView
+ (id)loadFromXib;

+ (id)loadFromXibI5;

- (UIView*)keyboardView;

- (UIView*)viewForView:(UIView *)view;
@end
