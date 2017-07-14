//
//  Message.h
//  text
//
//  Created by DL on 13-9-26.
//  Copyright (c) 2013年 issuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTXibView.h"

#ifndef NOTIFICATION_TOASTVIEW_COMPLETE
#define NOTIFICATION_TOASTVIEW_COMPLETE         @"ENotification_ToastView_Complete"
#endif

@interface Message : ITTXibView{
    int _disappearTime;
}
@property (assign, nonatomic) int disappearTime;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UIView *bgView;
+(void)message:(NSString*)message time:(float)time;
-(void)hide;
-(void)hideAlertView;
@end
