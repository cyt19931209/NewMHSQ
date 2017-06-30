//
//  PersonalSettingsViewController.h
//  奢易购3.0
//
//  Created by CYT on 2017/1/6.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalSettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *logoButton;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageV;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *WXHTextField;

@end
