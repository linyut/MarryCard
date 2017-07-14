//
//  HomeCell.h
//  MarryCard
//
//  Created by 方寸山 on 2017/6/22.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bandView;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardPriceLabel;

@end
