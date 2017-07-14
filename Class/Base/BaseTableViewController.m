//
//  BaseTableViewController.m
//  VitalityBOC
//
//  Created by xiaowei on 16/11/23.
//  Copyright © 2016年 BOC_ezdb. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "IQKeyboardManager.h"
//#import "MyTabBarButton.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)formatAlertControllerWithTitle:(NSString *)titile message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click AlertController Cancel");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Click AlertController Default");
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)formatAlertControllerWithTitle:(NSString *)titile message:(NSString *)message handler:(void (^)(UIAlertAction * _Nullable))handle
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消1" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click AlertController Cancel");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Click AlertController Default");
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//返回前面几个界面
- (void)popVC:(int)vcNum
{
    NSInteger viewControllerCount = [self.navigationController.viewControllers count];
    if(viewControllerCount >= vcNum+1){
        UIViewController *previousVC = [self.navigationController.viewControllers objectAtIndex:viewControllerCount-vcNum-1];
        [self.navigationController popToViewController:previousVC animated:YES];
    }
}

//返回首页
- (void)popHomeVC
{
    UIViewController *previousVC = [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:previousVC animated:YES];
}

//返回上一个界面
- (void)popLastVC
{
    [self popVC:1];
}


#pragma mark - ShowToast
- (void)showToast:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KAPPDELEGATE.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.alpha = 0.6;
    hud.margin = 10.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}

- (void)hideToast
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (void)configTitle:(NSString *)title showLeftButton:(BOOL)isShow andrightBtnTitle:(NSString*)rightTitle
{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 40)];
    [titleLabel setText:title];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:titleLabel];
    
    if ([title isEqualToString:@"firstLogin"]) {
        UIImageView *bgView = [[UIImageView alloc] init];
        [bgView setFrame:self.navigationController.navigationBar.bounds];
        [bgView setImage:IMGNAMEED(@"First_navbar_image")];
        [self.navigationItem setTitleView:bgView];
    }
    
    
    if (isShow) {
        [self configLeftItem];
    }
    if (rightTitle.length> 0) {
        [self configRightItemWithType:rightTitle];
    }
}

- (void)configRightItemWithType:(NSString *) buttonType
{
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0.0, 0.0, 80, 40)];
    rightButton.tag=521;
    if ([buttonType isEqualToString:@"branchRightImage"]) {
        rightButton.width = 30;
        rightButton.height = 30;
        [rightButton setImage:[UIImage imageNamed:@"branchRightImage"] forState:UIControlStateNormal];
        rightButton.adjustsImageWhenHighlighted = NO;
    }else{
        [rightButton setTitle:buttonType forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton.titleLabel setFont:[UIFont fontWithName:TEXT_FONTNAME size:13]];
    
    
	rightButton.imageEdgeInsets = UIEdgeInsetsMake(10,-20,-10,20);

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightAction:(UIButton *)sender
{
    
}


- (void)configLeftItem
{
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 30, 30);
//    [backBtn setBackgroundImage:[UIImage  imageNamed:@"BackUpImage.png"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage  imageNamed:@"BackDownImage"] forState:UIControlStateHighlighted];
//    backBtn.tag = 520;
//    [backBtn addTarget:self action:@selector(leftAction:)
//      forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *spaceItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackUpImage"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
}

- (void)leftAction:(UIButton *)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [AppDelegate closeKeyWindow];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
