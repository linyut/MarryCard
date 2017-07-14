//
//  MenuView.m
//  VitalityBOC
//
//  Created by xiaowei on 16/11/23.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame adnTitleArr:(NSArray*)titleArr{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _titleArr = titleArr;
        self.clipsToBounds= YES;
        
        [self creatViews];
    }
    return self;
}

-(void)creatViews{
//    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
//    backView.backgroundColor = [UIColor blackColor];
//    backView.alpha= 0.4;
//    backView.tag = 0;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
    [self addGestureRecognizer:tap];
    
    
//    [self addSubview:backView];
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-35, 0, 8, 6)];
    iv.image = IMGNAMEED(@"Icon_Triangle");
    [self addSubview:iv];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 144,6, 140, 300)];
    secondView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    secondView.layer.cornerRadius = 6;
    secondView.clipsToBounds = YES;
    [self addSubview:secondView];
    
    secondView.height = 40*_titleArr.count;
    for (int i =0; i<_titleArr.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 40*i, secondView.width, 40)];
        view.tag = i +1 ;
        view.backgroundColor = [UIColor clearColor];
        if (i < _titleArr.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 39, view.frame.size.width - 20, 0.5)];
            line.backgroundColor = RGBACOLOR(255, 255, 255, 0.2);//[UIColor whiteColor];
            [view addSubview:line];
        }
        [secondView addSubview:view];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [view addGestureRecognizer:tap];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, view.frame.size.width, 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = RGBACOLOR(255, 255, 255, 0.9);//[UIColor whiteColor];
        lable.text = _titleArr[i];
        lable.font = [UIFont systemFontOfSize:14.0];
        lable.backgroundColor = [UIColor clearColor];
        [view addSubview:lable];
        
    }
    
    
}

-(void)clickAction:(UITapGestureRecognizer*)tap{
    
    NSLog(@"%ld",(long)tap.view.tag);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnClickWithTag:)]) {
        NSString *title = tap.view.tag > 0 ? _titleArr[tap.view.tag-1] : @"";
        [self.delegate btnClickWithTag:title];
    }
}

-(void)show{
    
//    self.frame = CGRectMake(0, 54, SCREEN_WIDTH, 0);
//    [KAPPDELEGATE.window addSubview:self];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = CGRectMake(0, 54, SCREEN_WIDTH, SCREEN_HEIGHT-54);
//    }];
    
    self.frame = CGRectMake(0, 58, SCREEN_WIDTH, SCREEN_HEIGHT-58);
    [KAPPDELEGATE.window addSubview:self];
}

-(void)hide{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = CGRectMake(0, 54, SCREEN_WIDTH, 0);
//        
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        
//    }];
    [self removeFromSuperview];
}

-(void)showOrHidden:(BOOL)isSHow{

    if (isSHow) {
        [self show];
    }else{
    
        [self hide];
    }
}


@end
