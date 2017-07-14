//
//  BOCCustomTextField.m
//  Study
//
//  Created by scs on 2017/2/7.
//  Copyright © 2017年 scs. All rights reserved.
//

#import "BOCCustomTextField.h"

@implementation BOCCustomTextField

// 通过代码创建
- (instancetype)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

// 设置placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(42, 2.5, bounds.size.width, bounds.size.height);
    return inset;
}

@end
