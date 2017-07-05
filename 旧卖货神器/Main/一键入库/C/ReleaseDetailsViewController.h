//
//  ReleaseDetailsViewController.h
//  奢易购3.0
//
//  Created by Andy on 2016/12/5.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseDetailsViewController : UITableViewController{

    NSInteger row;
    
    NSArray *imgArr;
    
    NSString *SPMSStr;
    
}

@property (weak, nonatomic) IBOutlet UILabel *DLLabel;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) BOOL isGoods;

@property (weak, nonatomic) IBOutlet UILabel *agentPriceLabel;

@property (nonatomic,assign) BOOL isFriend;

@property (nonatomic,copy) NSString *share_id;

@property (weak, nonatomic) IBOutlet UITableViewCell *PTCell;

@property (weak, nonatomic) IBOutlet UILabel *SPMCLabel;

@property (weak, nonatomic) IBOutlet UILabel *SPMSLabel;

@property (weak, nonatomic) IBOutlet UILabel *SPJGLabel;

@property (weak, nonatomic) IBOutlet UILabel *SJLabel;

@property (weak, nonatomic) IBOutlet UILabel *SPSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *SPGJLabel;

//@property (weak, nonatomic) IBOutlet UILabel *CCLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel3;

@property (weak, nonatomic) IBOutlet UITextField *siez_xLabel;
@property (weak, nonatomic) IBOutlet UITextField *size_yLabel;
@property (weak, nonatomic) IBOutlet UITextField *size_zLabel;

@property (weak, nonatomic) IBOutlet UILabel *PPLabel;
@property (weak, nonatomic) IBOutlet UILabel *LBLabel;
@property (weak, nonatomic) IBOutlet UILabel *CSLabel;
@property (weak, nonatomic) IBOutlet UILabel *SHSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *WDLBLabel;
@property (weak, nonatomic) IBOutlet UILabel *JHDZLabel;

@property (weak, nonatomic) IBOutlet UILabel *XLLabel;
@property (weak, nonatomic) IBOutlet UILabel *XHLabel;
@property (weak, nonatomic) IBOutlet UILabel *CZLabel;
@property (weak, nonatomic) IBOutlet UILabel *GNLabel;
@property (weak, nonatomic) IBOutlet UILabel *BHLabel;
@property (weak, nonatomic) IBOutlet UILabel *FJLabel;



@end
