//
//  OrderSectionHeaderView.h
//  MarryCard
//
//  Created by 方寸山 on 2017/7/11.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSectionHeaderView : UIView

@property (assign, nonatomic) NSInteger sectionIndex;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardTypeLabelXConstraint;

@property (weak, nonatomic) IBOutlet UIButton *deleteCardBtn;
@property (weak, nonatomic) IBOutlet UILabel *cardTagLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberBtn;
@property (weak, nonatomic) IBOutlet UILabel *basePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distancePriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addAddressBtn;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLabel;



@property (copy, nonatomic) void (^deleteCardBtnBlock)();
@property (copy, nonatomic) void (^addCardBtnBlock)();
@property (copy, nonatomic) void (^typeBtnBlock)(NSInteger selectIndex);
@property (copy, nonatomic) void (^colorBtnBlock)(NSInteger selectIndex);
@property (copy, nonatomic) void (^numberBtnBlock)(NSInteger selectIndex);
@property (copy, nonatomic) void (^addAddressBtnBlock)();
@property (copy, nonatomic) void (^selectStartAddressBtnBlock)();


-(void)showHeaderViewWith:(NSDictionary *)cardInfoDict;

@end
