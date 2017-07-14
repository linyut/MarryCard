//
//  QuestionSubmitViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "QuestionSubmitViewController.h"

@interface QuestionSubmitViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *submitTextView;

@end

@implementation QuestionSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"意见反馈" showLeftButton:YES andrightBtnTitle:nil];
    self.submitTextView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入反馈意见"]) {
        self.submitTextView.text = @"";
        self.submitTextView.textColor = [UIColor colorWithHexString:@"4a4a4a"];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.submitTextView.text = @"请输入反馈意见";
        self.submitTextView.textColor = [UIColor colorWithHexString:@"818181"];
    }
}

- (IBAction)submitBtnClick:(UIButton *)sender {
    if ([self.submitTextView.text isEqualToString:@"请输入反馈意见"]||self.submitTextView.text.length == 0) {
        MESSAGE(@"请输入反馈意见");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.submitTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
