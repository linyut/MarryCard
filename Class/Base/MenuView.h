//
//  MenuView.h
//  VitalityBOC
//
//  Created by xiaowei on 16/11/23.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickActionDelegate <NSObject>

-(void)btnClickWithTag:(NSString*)tag;

@end

@interface MenuView : UIView

- (id)initWithFrame:(CGRect)frame adnTitleArr:(NSArray*)titleArr;

@property(strong,nonatomic)NSArray *iconArr;
@property(strong,nonatomic)NSArray *titleArr;

@property(assign,nonatomic) id <clickActionDelegate> delegate;

-(void)showOrHidden:(BOOL)isSHow;

@end
