//
//  OrderCardDetailInfoViewController.m
//  MarryCard
//
//  Created by linyut on 2017/7/13.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "OrderCardDetailInfoViewController.h"
#import "IssueOrderViewController.h"
#import "SJAvatarBrowser.h"

@interface OrderCardDetailInfoViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;



@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *basePriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointOutsidePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *realityOutsidePriceLabel;






@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallScrollViewContentWidth;
@property (weak, nonatomic) IBOutlet UILabel *pageNumberLabel;



@end

@implementation OrderCardDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:self.cardName showLeftButton:YES andrightBtnTitle:nil];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI
{
    self.smallScrollViewContentWidth.constant = 6*kScreenWidth;
    self.pageNumberLabel.layer.masksToBounds = YES;
    self.pageNumberLabel.layer.cornerRadius = 9;
    
    self.bigScrollView.delegate = self;
    self.smallScrollView.delegate = self;
    
    
    for (int i = 0; i<6; i++) {
        UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, 280)];
        cardImageView.image = [UIImage imageNamed:@"奥迪A6"];
        cardImageView.userInteractionEnabled = YES;
        [self.smallScrollView addSubview:cardImageView];
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
        [cardImageView addGestureRecognizer:tap];
    }
}

- (void)magnifyImage:(UIGestureRecognizer *)sender
{
    UIImageView *imageView = (UIImageView *)sender.view;
    [SJAvatarBrowser showImage:imageView];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    NSInteger index = point.x/(kScreenWidth-1);
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%ld/6",index+1];
}



- (IBAction)issueBtnClick:(UIButton *)sender {
    IssueOrderViewController *orderVC = [[IssueOrderViewController alloc] init];
    
    [self.navigationController hideTabbarPushViewController:orderVC animated:YES];
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
