//
//  PersonModifyPasswordViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/6/29.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "PersonModifyPasswordViewController.h"
#import "PersonSettingNewPasswordViewController.h"

@interface PersonModifyPasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;


@property(nonatomic,strong)NSTimer *secondTimer;
@property(nonatomic,strong)NSDate *lastDate;
@property(nonatomic,assign)NSInteger currentInt;


@end

@implementation PersonModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:self.viewTitle showLeftButton:YES andrightBtnTitle:nil];
    [self.phoneTextField setValue:@11 forKey:@"limit"];
    [self.codeTextField setValue:@6 forKey:@"limit"];
    self.codeBtn.adjustsImageWhenDisabled = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];

    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)codeBtnClick:(UIButton *)sender {
    [self readSecondSetting];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    if (self.phoneTextField.text.length == 0) {
        MESSAGE(@"请输入手机号码");
    }else if (![CommonMethod isMobileNumer:self.phoneTextField.text]){
        MESSAGE(@"请输入正确的手机号码");
    }else if (self.codeTextField.text.length == 0){
        MESSAGE(@"请输入验证码");
    }else if (self.codeTextField.text.length < 6){
        MESSAGE(@"请输入6位验证码");
    }else{
        PersonSettingNewPasswordViewController *vc = [[PersonSettingNewPasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//短信验证读秒设置
-(void)readSecondSetting
{
    self.codeBtn.enabled = NO;
    _currentInt = 60;
    _secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

-(void)timeFireMethod
{
    _currentInt--;
    if (_currentInt>0)
    {
        self.codeBtn.enabled = NO;
        [self.codeBtn setTitle:[NSString stringWithFormat:@"再次发送 (%ld秒)", (long)_currentInt] forState:UIControlStateNormal];
        //        [self.codeBtn setBackgroundImage:[UIImage imageNamed:@"noteButton_uncheck"] forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:UIColorFromRGB(0xDFC9CA)];
        
    }
    else
    {
        [_secondTimer invalidate];
        self.codeBtn.enabled = YES;
        [self.codeBtn setTitle:@"再次发送" forState:UIControlStateNormal];
        //        [self.codeBtn setBackgroundImage:[UIImage imageNamed:@"noteButton_normal"] forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:UIColorFromRGB(0xBD2F34)];
        
    }
}

//进入后台时的处理方法
- (void)applicationDidEnterBackground:(NSNotification*)note
{
    if (self.secondTimer)
    {
        self.lastDate=[NSDate date];
        [self.secondTimer setFireDate:[NSDate distantFuture]];
    }
}

//进入前台时的处理方法
- (void)applicationWillEnterForeground:(NSNotification*)note
{
    if (self.secondTimer)
    {
        NSString *s=[NSDate timeStringFromNow:self.lastDate];
        if (_currentInt-[s integerValue]>0)
        {
            
            _currentInt = _currentInt - [s integerValue];//通过时间差，更新读秒数
            [self.secondTimer setFireDate:[NSDate date]];
            self.codeBtn.enabled = NO;
            [self.codeBtn setTitle:[NSString stringWithFormat:@"再次发送 (%ld秒)", (long)_currentInt] forState:UIControlStateNormal];
            //        [self.codeBtn setBackgroundImage:[UIImage imageNamed:@"noteButton_uncheck"] forState:UIControlStateNormal];
            [self.codeBtn setBackgroundColor:UIColorFromRGB(0xDFC9CA)];
        }
        else
        {
            [_secondTimer invalidate];
            self.codeBtn.enabled = YES;
            [self.codeBtn setTitle:@"再次发送" forState:UIControlStateNormal];
            //        [self.codeBtn setBackgroundImage:[UIImage imageNamed:@"noteButton_normal"] forState:UIControlStateNormal];
            [self.codeBtn setBackgroundColor:UIColorFromRGB(0xBD2F34)];
        }
    }
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
