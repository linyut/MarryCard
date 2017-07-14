//
//  ChangePasswordAlterView.h
//  BOCOP
//
//  Created by zhangtao on 2016/12/13.
//
//

#import "ITTXibView.h"

@protocol agricultureTransferSucDelegete <NSObject>

-(void)agricultureTransferSucView;

@end

typedef void(^CreatBranceButtonBlock)(NSString* state);

@interface ChangePasswordAlterView : ITTXibView
//@property(nonatomic,assign) id<agricultureTransferSucDelegete>delegate;

@property (retain, nonatomic) UIView *bgView;
@property (retain, nonatomic) IBOutlet UIView *passwordView;
@property (nonatomic ,copy)CreatBranceButtonBlock myBlock;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UILabel *content;

@property (retain, nonatomic) IBOutlet UIView *changeView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextfield;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UILabel *title;
-(void)showInView:(UIView *)parentView setTitle:(NSString*)title message:(NSString*)message addButtonTitleArr:(NSArray*)buttonArr hande:(CreatBranceButtonBlock)state ;
-(void)hideWithView:(UIView*)view;
@end
