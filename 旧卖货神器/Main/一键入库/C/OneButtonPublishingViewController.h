//
//  OneButtonPublishingViewController.h
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneButtonPublishingViewController : UITableViewController



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@property (weak, nonatomic) IBOutlet UIButton *PHButton;
@property (weak, nonatomic) IBOutlet UIImageView *PHImageV;
@property (weak, nonatomic) IBOutlet UILabel *PHLabel;

@property (weak, nonatomic) IBOutlet UIButton *ADMButton;
@property (weak, nonatomic) IBOutlet UIImageView *ADMImageV;
@property (weak, nonatomic) IBOutlet UILabel *ADMLabel;

@property (weak, nonatomic) IBOutlet UIButton *WBButton;
@property (weak, nonatomic) IBOutlet UIImageView *WBImageV;
@property (weak, nonatomic) IBOutlet UILabel *WBLabel;

@property (weak, nonatomic) IBOutlet UIButton *LPHButton;
@property (weak, nonatomic) IBOutlet UIImageView *LPHImageV;
@property (weak, nonatomic) IBOutlet UILabel *LPHLabel;

@property (weak, nonatomic) IBOutlet UIButton *XSButton;
@property (weak, nonatomic) IBOutlet UIImageView *XSImageV;
@property (weak, nonatomic) IBOutlet UILabel *XSLabel;

@property (weak, nonatomic) IBOutlet UIButton *SPButton;
@property (weak, nonatomic) IBOutlet UIImageView *SPImageV;
@property (weak, nonatomic) IBOutlet UILabel *SPLabel;

@property (weak, nonatomic) IBOutlet UIButton *ZDButton;
@property (weak, nonatomic) IBOutlet UIImageView *ZDImageV;
@property (weak, nonatomic) IBOutlet UILabel *ZDLabel;

@property (weak, nonatomic) IBOutlet UIButton *ADMZYButton;
@property (weak, nonatomic) IBOutlet UIImageView *ADMZYImageV;
@property (weak, nonatomic) IBOutlet UILabel *ADMZYLabel;

@property (weak, nonatomic) IBOutlet UIButton *ADMSJButton;
@property (weak, nonatomic) IBOutlet UIImageView *ADMSJImageV;
@property (weak, nonatomic) IBOutlet UILabel *ADMSJLabel;

@property (weak, nonatomic) IBOutlet UIButton *JAButton;
@property (weak, nonatomic) IBOutlet UIImageView *JAImageV;
@property (weak, nonatomic) IBOutlet UILabel *JALabel;



@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *sortTextField;
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;
@property (weak, nonatomic) IBOutlet UITextField *expectedTextField;
@property (weak, nonatomic) IBOutlet UITextField *bagsizeTextField;
@property (weak, nonatomic) IBOutlet UITextField *size_yTextField;
@property (weak, nonatomic) IBOutlet UITextField *size_zTextField;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel2;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel3;

@property (weak, nonatomic) IBOutlet UITextField *WDSordTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *agentPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *KWDZTextField1;
@property (weak, nonatomic) IBOutlet UITextField *KWDZTextField2;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *publicPriceTextField;
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *tureButton;


@property (nonatomic,assign) BOOL isUpData;

@property (nonatomic,assign) BOOL isCopy;

@property (nonatomic,assign) BOOL isOnePush;

@property (nonatomic,copy) NSString *goods_id;


@property (nonatomic,strong) NSDictionary *recordDic;

@property (nonatomic,strong) NSDictionary *selectDic;

@property (nonatomic,strong) NSArray *typeArr;

@property (nonatomic,strong) NSArray *selectTypeArr;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WDBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LPHBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *XSBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SPBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZDBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMZYBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ADMSJBLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JABLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *KKHBLeft;




@property (weak, nonatomic) IBOutlet UIButton *JMButton;

@property (weak, nonatomic) IBOutlet UIButton *HSButton;

//多平台上货
@property (weak, nonatomic) IBOutlet UITextField *CBJTF;

@property (weak, nonatomic) IBOutlet UITextField *KHTF;
@property (weak, nonatomic) IBOutlet UITextField *KHDSJTF;
@property (weak, nonatomic) IBOutlet UITextField *HHTF;
@property (weak, nonatomic) IBOutlet UITextField *BSTF;
@property (weak, nonatomic) IBOutlet UITextField *SNDTF;
@property (weak, nonatomic) IBOutlet UITextField *YSTF;
@property (weak, nonatomic) IBOutlet UITextField *JDTF;
@property (weak, nonatomic) IBOutlet UITextField *QGTF;
@property (weak, nonatomic) IBOutlet UITextField *PGTF;
@property (weak, nonatomic) IBOutlet UITextField *DCXTF;
@property (weak, nonatomic) IBOutlet UITextField *YGXTF;
@property (weak, nonatomic) IBOutlet UITextField *ZLTF;
@property (weak, nonatomic) IBOutlet UITextField *KYTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sizeWidth;


//闲货
@property (weak, nonatomic) IBOutlet UIButton *XHButton;


@end
