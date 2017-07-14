//
//  ChangePasswordAlterView.m
//  BOCOP
//
//  Created by zhangtao on 2016/12/13.
//
//

#import "ChangePasswordAlterView.h"

@implementation ChangePasswordAlterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
       {

       }
    
    return self;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];

    self.changeView.frame = CGRectMake((kScreenWidth-self.changeView.frame.size.width)/2, self.changeView.frame.origin.y, self.changeView.frame.size.width, self.changeView.size.height);
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight+64);
    self.titleTextfield.frame = CGRectMake(20, 24, self.titleTextfield.frame.size.width, 46) ;
    [self.titleTextfield addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingDidEnd];
    [self.titleTextfield addTarget:self action:@selector(beginChange:) forControlEvents:UIControlEventEditingDidBegin];
}
- (void)textChanged:(UITextField*)textField {
    
    if (textField.text.length > 4 ) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 4)];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)beginChange:(UITextField*)sender{
    [UIView animateWithDuration:0.5 animations:^{
         self.frame = CGRectMake(0, -100, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished) {
       
    }];
   
}
- (IBAction)cancelAction:(UIButton *)sender {
    if([_title.text isEqualToString:@"添加新标签"]){
        self.myBlock(@"");
    }else{
        self.myBlock(@"NO");
        
    }

    [self hideWithView:_bgView];
}
- (IBAction)pushToChangPasswordVC:(UIButton *)sender {
//    [_delegate agricultureTransferSucView];
    
   

    
    if([_title.text isEqualToString:@"添加新标签"]){

        NSString* alterSting = [self.titleTextfield.text replaceAll:@" " with:@"%%"];

        if(self.titleTextfield.text.length == 0){
            
            MESSAGE(@"标签名不能为空");
            return;
        }
        if(self.titleTextfield.text.length > 4){
            
            MESSAGE(@"标签名最多4个字");
            return;
        }
        
        NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z0-9]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if(![pred evaluateWithObject: _titleTextfield.text]||![pred evaluateWithObject: alterSting]){
            MESSAGE(@"标签名不能为特殊符号和空格");
            _titleTextfield.text = @"";
            return;
        }
        
        
        self.myBlock(self.titleTextfield.text);
    }else{
        self.myBlock(@"YES");

    }
    [self hideWithView:_bgView];
    


}

-(void)showInView:(UIView *)parentView setTitle:(NSString*)title message:(NSString*)message addButtonTitleArr:(NSArray*)buttonArr hande:(CreatBranceButtonBlock)state
{
//    self.frame=CGRectMake(0, 0, self.size.width, self.size.height);


    if([title isEqualToString:@"添加新标签"]){
        self.titleTextfield.hidden = NO;
        self.content.hidden = YES;
    }else{
        self.titleTextfield.hidden = YES;
        self.content.hidden = NO;

    }
    self.title.text = title;
    self.content.text = message;
    if(buttonArr.count>1){
        [self.cancelButton setTitle:buttonArr[0] forState:UIControlStateNormal];
        [self.actionButton setTitle:buttonArr[1] forState:UIControlStateNormal];
    }else{
        self.cancelButton.hidden = YES;
        [self.actionButton setTitle:buttonArr[0] forState:UIControlStateNormal];
        self.actionButton.frame = CGRectMake(0, self.actionButton.frame.origin.y, self.changeView.frame.size.width, self.actionButton.frame.size.height);

    }
   
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.cornerRadius = 10.0;
    self.myBlock = state;
//    self.changeView.layer.borderWidth = 1;
//    self.changeView.layer.borderColor = [UIColor grayColor].CGColor;
//    self.alpha = 0.7;
//    parentView.backgroundColor = [UIColor blackColor];
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.8;
//    animation.delegate =  self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale

                       (0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale

                       (1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale

                       (1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction
                                functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [parentView addSubview:self];
    [self.layer addAnimation:animation forKey:nil];

}

-(void)hideWithView:(UIView *)view
{

    [self removeFromSuperview];
    [_bgView removeFromSuperview];
}



@end
