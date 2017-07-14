//
//  UITextField+Forbidden.m
//  PBPS-MA
//
//  Created by BOCOP-0018 on 17/4/11.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import "UITextField+Forbidden.h"

@implementation UITextField (Forbidden)


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.tag == Forbiddens)
    {
        if (action == @selector(copy:)) {
            return NO;
        }
        else if (action == @selector(paste:))
        {
            return NO;
        }
        else if (action == @selector(selectAll:))
        {
            return NO;
        }
        else if (action == @selector(delete:)){
            return NO;
        }
        else
        {
            return NO;
        }
    }else{
        if (action == @selector(copy:)) {
            return YES;
        }
        else if (action == @selector(paste:))
        {
            return YES;
        }
        else if (action == @selector(selectAll:))
        {
            return YES;
        }
        else{
            return NO;
        }
    }
}

@end
