//
//  SelectMenuView.h
//  MarryCard
//
//  Created by 方寸山 on 2017/6/28.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectMenuView : UIView

@property (nonatomic, strong)NSArray *titleArray;

@property (nonatomic, copy)void (^selectBtnClick)(NSInteger selectIndex);

- (id)showWithMenuViewFrame:(CGRect)menuFrame andListFrame:(CGRect)listFrame;


@end
