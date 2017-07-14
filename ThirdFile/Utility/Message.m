//
//  Message.m
//  text
//
//  Created by DL on 13-9-26.
//  Copyright (c) 2013年 issuser. All rights reserved.
//

#import "Message.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ITTMessageView.h"
@interface Message()
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer;
@end
@implementation Message


#pragma mark - private methods
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    [self hide];
}
+(void)message:(NSString*) msg time:(float)time
{
    if (!msg || [msg stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return;
    }
    NSString *lastMsg = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"kMessage"]];
    
    if ([lastMsg isEqualToString:msg]) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"kMessage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    ITTMessageView *msgView = [ITTMessageView loadFromXib];
    msgView.messageLbl.numberOfLines = 0;
    msgView.messageLbl.font = [UIFont systemFontOfSize:15];

    msgView.bottom = 0;
    msgView.tag = 112233;
    msgView.left = ([UIScreen mainScreen].bounds.size.width - msgView.width)/2;
    msgView.messageLbl.text = msg;
    
    msgView.messageLbl.numberOfLines = 0;
    msgView.alpha = 0.0;
    
    if ([[UIApplication sharedApplication].delegate.window viewWithTag:112233]) {
        return;
    }
    else{
        [[UIApplication sharedApplication].delegate.window addSubview:msgView];
        [UIView animateWithDuration:0.5
                         animations:^{
                             msgView.alpha = 1;
                             msgView.top = 100;
                         }
                         completion:^(BOOL finished) {
                             [msgView performSelector:@selector(hide) withObject:nil afterDelay:time];
                         }];
        }

}
- (void)hide
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alpha = 0.0;
                         self.bottom = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"kMessage"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                     }];
}

-(void)hideAlertView
{
    if (self.superview) {
        [self removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"kMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGestureRecognizer];
    _disappearTime = 3;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    
}

@end
