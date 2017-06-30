//
//  PeerHeaderView.h
//  奢易购3.0
//
//  Created by CYT on 2017/6/6.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeerHeaderView : UIView<UIAlertViewDelegate>

@property (nonatomic,strong) NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *WXLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *DYLabel;
@property (weak, nonatomic) IBOutlet UIButton *DYButton;


@property (nonatomic,assign) BOOL isMyFriend;

@end
