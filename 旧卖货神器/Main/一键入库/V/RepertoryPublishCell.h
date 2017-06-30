//
//  RepertoryPublishCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RepertoryPublishCell : UITableViewCell<UIAlertViewDelegate>{

    UIView *bgView;
    
    UIView *editView;
    
    UIView *addView;
    
    BOOL isSPMS;
    
    BOOL isWXWB;
    
    NSString *SPMSStr;

}

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *DLLabel;

@property (nonatomic,strong) NSDictionary *dic;

@property (nonatomic,assign) BOOL isFriend;

@property (weak, nonatomic) IBOutlet UILabel *goods_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goods_descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *add_timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *agentPriceLabel;


@property (nonatomic,strong) UIButton *selectSPMSButton;

@property (nonatomic,strong) UIButton *selectfriendButton;

@property (nonatomic,strong) UIImageView *selectSPMSImageV;

@property (nonatomic,strong) UIImageView *selectfriendImageV;






@end
