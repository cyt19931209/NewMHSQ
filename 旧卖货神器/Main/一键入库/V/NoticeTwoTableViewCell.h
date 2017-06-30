//
//  NoticeTwoTableViewCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/12/13.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeTwoTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *MCLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bcdImageV;

@property (weak, nonatomic) IBOutlet UILabel *readLabel;

@end

