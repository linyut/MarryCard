//
//  MenuTableView.h
//  MarryCard
//
//  Created by linyut on 2017/6/28.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableView : UITableView

-(void)showWithTitleArray:(NSArray *)titleArray andCoverFrame:(CGRect)coverFrame andClickAction:(void (^)(NSInteger selectIndex))clickAction;

-(void)showOrHidden:(BOOL)isSHow;


@end
