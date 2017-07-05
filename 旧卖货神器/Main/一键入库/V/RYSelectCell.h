//
//  RYSelectCell.h
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYSelectCell : UITableViewCell



@property (nonatomic,strong) NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageV;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLeft;

@end
