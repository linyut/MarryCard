//
//  CustomAlertView.h
//  PBPS-MA
//
//  Created by dede wang on 2017/2/15.
//  Copyright © 2017年 BOC_ezdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

- (void) show;

- (void) hide;



@end
