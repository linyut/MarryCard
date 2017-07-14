//
//  BaseNFGXibView.m
//  PensionTreasure
//
//  Created by Simon on 16/7/4.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseNFGXibView.h"
#import "BaseNFGXibViewUtils.h"
@implementation BaseNFGXibView


+ (id)loadFromXib
{
    return [BaseNFGXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

+ (id)loadFromXibI5
{
    return [BaseNFGXibViewUtils loadViewFromXibNamed:[NSString stringWithFormat:@"%@_I5",NSStringFromClass([self class])]];
}

- (UIView*)keyboardView
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator])
    {
        for (UIView *view in [window subviews])
        {
            // UIPeripheralHostView is used from iOS 4.0, UIKeyboard was used in previous versions:
            if (!strcmp(object_getClassName(view), "UIPeripheralHostView") || !strcmp(object_getClassName(view), "UIKeyboard"))
            {
                return view;
            }
        }
    }
    return nil;
}

- (UIView*)viewForView:(UIView *)view
{
    UIView *keyboardView = [self keyboardView];
    if (keyboardView)
        view = keyboardView.superview;
    return view;
}

@end
