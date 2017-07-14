//
//  ITTXibView.m
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/9/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "ITTXibView.h"
#import "ITTXibViewUtils.h"


@implementation ITTXibView

+ (id)loadFromXib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

+ (id)loadFromXibI5
{
    return [ITTXibViewUtils loadViewFromXibNamed:[NSString stringWithFormat:@"%@_I5",NSStringFromClass([self class])]];
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
