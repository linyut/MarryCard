//
//  CheckListView.h
//  EZDB
//
//  Created by mark on 15/11/13.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLbl;
@property (nonatomic,strong) UIImageView *checkFlag;

- (void)setCheckStatus:(NSString*)checkedStatus;//字符串 0-未选中，1-选中

@end

//------------------------------------

@protocol CheckListViewDelegate <NSObject>

- (void)onConfirm:(NSArray*)checkedItems withTitile:(NSString*)listTitle;

@end

@interface CheckListView : UIView

@property (nonatomic,assign) id<CheckListViewDelegate> delegate;

- (id)initWithDelegate:(id<CheckListViewDelegate>)delegate withListTitle:(NSString*)title withAllCheckItems:(NSArray*)items;
- (void)showInView:(UIView*)view;
- (void)hideView;

@end
