//
//  selectAddressCell.h
//  MarryCard
//
//  Created by linyut on 2017/7/10.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueOrderCell : UITableViewCell

@property (copy, nonatomic) void (^deleteBtnBlock)();

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
