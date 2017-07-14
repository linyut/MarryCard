//
//  OrderSectionFootView.h
//  MarryCard
//
//  Created by 方寸山 on 2017/7/11.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSectionFootView : UIView

@property (weak, nonatomic) IBOutlet UILabel *finishAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *generalDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectDistanceAndTimeLabel;


@property (copy, nonatomic) void (^finishAddressBtnBlock)();
@property (copy, nonatomic) void (^selectDistanceAndTimeBtnBlock)();


@end
