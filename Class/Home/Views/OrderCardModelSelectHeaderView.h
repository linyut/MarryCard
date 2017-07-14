//
//  OrderCardModelSelectHeaderView.h
//  MarryCard
//
//  Created by 方寸山 on 2017/7/12.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCardModelSelectHeaderView : UIView

@property (assign, nonatomic) NSInteger cardModelSelectIndex;

@property (copy, nonatomic) void (^typeBtnBlock)(NSString *cardType);
@property (copy, nonatomic) void (^colorBtnBlock)(NSString *cardColor);
@property (copy, nonatomic) void (^numberBtnBlock)(NSString *cardNumber);


@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberBtn;

-(void)showTableViewWithIndex:(NSInteger)cardModelSelectIndex;

@end
