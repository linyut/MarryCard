//
//  CustomAlertView.m
//  PBPS-MA
//
//  Created by dede wang on 2017/2/15.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,1)];
    self.contentLabel.attributedText = str;
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
}

- (void) show
{
    
    self.left = ([UIScreen mainScreen].bounds.size.width - self.width)/2;
    self.layer.cornerRadius = 6;
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alpha = 1;
                         self.top = 111;
                     }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(hide) withObject:nil afterDelay:3];
                     }];
}

- (void) hide
{

        [UIView animateWithDuration:0.5
                animations:^{
                    self.alpha = 0.0;
                    self.bottom = 0;
                         }
                completion:^(BOOL finished)
                {
                    [self removeFromSuperview];
                }
        ];
}


@end
