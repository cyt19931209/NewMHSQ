//
//  SelectTheAddressCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/11/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTheAddressCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dic;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
