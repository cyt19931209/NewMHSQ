//
//  ReleaseHistoryCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/11/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "RepertoryPublishViewController.h"
#import "RYSelectListView.h"
#import "BaseChatViewController.h"

@interface ReleaseHistoryCell : UITableViewCell<UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>{

    
    UIView *bgView;
    
    UIView *editView;
    
    UITextView *editTextView;
    
    NSInteger row;
    
    NSArray *imgArr;
    
    UIAlertView *alertV1;
    UIAlertView *alertV2;
    
    BOOL isSPMS;
    
    BOOL isWXWB;
    UIView *addView;
    
    NSString *SPMSStr;
    
    RYSelectListView *RYView;

    
    
}


@property (weak, nonatomic) IBOutlet UIButton *chatButton;

@property (nonatomic,strong) UIButton *selectSPMSButton;

@property (nonatomic,strong) UIButton *selectfriendButton;

@property (nonatomic,strong) UIImageView *selectSPMSImageV;

@property (nonatomic,strong) UIImageView *selectfriendImageV;


@property (weak, nonatomic) IBOutlet UIButton *logoButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageV;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAdressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editTextButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image1Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image2Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image3Top;

@property (nonatomic,copy) NSString *is_delete;

@property (nonatomic,assign) BOOL isFriend;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameTop;

@property (weak, nonatomic) IBOutlet UILabel *WXLabel;

@property (nonatomic,strong) NSDictionary *dic;

@property (nonatomic,strong) NSDictionary *dic1;


@property (nonatomic,assign) NSInteger index;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@property (weak, nonatomic) IBOutlet UILabel *goods_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goods_descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet UITextField *agentPriceTextField;

@property (weak, nonatomic) IBOutlet UILabel *DLLabel;


@property (weak, nonatomic) IBOutlet UILabel *PHLabel;
@property (weak, nonatomic) IBOutlet UILabel *ADMLabel;
@property (weak, nonatomic) IBOutlet UILabel *WDLabel;
@property (weak, nonatomic) IBOutlet UILabel *LPHLabel;
@property (weak, nonatomic) IBOutlet UILabel *XSLabel;
@property (weak, nonatomic) IBOutlet UILabel *SPLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZDLabel;
@property (weak, nonatomic) IBOutlet UILabel *ADMZYLabel;
@property (weak, nonatomic) IBOutlet UILabel *ADMSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *JALabel;



@property (weak, nonatomic) IBOutlet UIButton *PHButton;
@property (weak, nonatomic) IBOutlet UIButton *ADMButton;
@property (weak, nonatomic) IBOutlet UIButton *WDButton;
@property (weak, nonatomic) IBOutlet UIButton *LPHButton;
@property (weak, nonatomic) IBOutlet UIButton *XSButton;
@property (weak, nonatomic) IBOutlet UIButton *SPButton;
@property (weak, nonatomic) IBOutlet UIButton *ZDButton;
@property (weak, nonatomic) IBOutlet UIButton *ADMZYButton;
@property (weak, nonatomic) IBOutlet UIButton *ADMSJButton;
@property (weak, nonatomic) IBOutlet UIButton *JAButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WDBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WDLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LPHBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LPHLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *XSBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *XSLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SPBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SPLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZDBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZDLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMZYBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMZYLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMSJBLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMSJLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JABLeft;



@property (weak, nonatomic) IBOutlet UIButton *WXButton;
@property (weak, nonatomic) IBOutlet UIButton *WBButton;
@property (weak, nonatomic) IBOutlet UIButton *MoreButton;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
