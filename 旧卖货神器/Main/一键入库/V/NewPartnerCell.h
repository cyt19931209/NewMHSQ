//
//  NewPartnerCell.h
//  奢易购3.0
//
//  Created by CYT on 2017/1/5.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPartnerCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *HLLabel;
@property (weak, nonatomic) IBOutlet UIButton *TYButton;
@property (weak, nonatomic) IBOutlet UIButton *HLButton;

@end
