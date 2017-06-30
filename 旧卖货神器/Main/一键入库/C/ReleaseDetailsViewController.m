//
//  ReleaseDetailsViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/5.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ReleaseDetailsViewController.h"
#import "StockCellectionCell.h"
#import "MBProgressHUD.h"
#import "SharedItem.h"
#import "AppDelegate.h"
#import "RepertoryPublishViewController.h"
#import "OneButtonPublishingViewController.h"
#import "PlatformAccountViewController.h"


@interface ReleaseDetailsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIActionSheetDelegate>{
    
    UIView *bgView;
    
    UIView *editView;
    
    UIView *addView;
    
    BOOL isSPMS;
    
    BOOL isWXWB;

    
}


@property (nonatomic,strong) NSDictionary *dataDic;

@property (weak, nonatomic) IBOutlet UICollectionView *stockCollectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageC;


@property (nonatomic,strong) UIView *barImageView;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,copy) NSString *gradeId;
@property (nonatomic,copy) NSString *expectedId;
@property (nonatomic,copy) NSString *WDSortId;
@property (nonatomic,copy) NSString *addressId;


@property (nonatomic,strong) UIButton *selectSPMSButton;

@property (nonatomic,strong) UIButton *selectfriendButton;

@property (nonatomic,strong) UIImageView *selectSPMSImageV;

@property (nonatomic,strong) UIImageView *selectfriendImageV;



@end

@implementation ReleaseDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _gradeId = @"";
    _expectedId = @"";
    _WDSortId = @"";
    _addressId = @"";
    
    
    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataNotification) name:@"UpDataNotification" object:nil];


    
    

    self.navigationController.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [NSMutableArray array];

    [_stockCollectionView registerNib:[UINib nibWithNibName:@"StockCellectionCell" bundle:nil] forCellWithReuseIdentifier:@"StockCellectionCell"];

    [self loadData];
    
    _barImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    _barImageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_barImageView];
    
    
    UIView *bgBarV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    bgBarV.backgroundColor = [UIColor whiteColor];
    
    bgBarV.alpha = 0;
    
    bgBarV.tag = 100;
    
    [_barImageView addSubview:bgBarV];
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(9, 32, 28, 28);
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"bkny"] forState:UIControlStateNormal];
    leftButton.tag = 101;
    
    [leftButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_barImageView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(kScreenWidth - 24 - 15, 32, 28, 28);
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"moreny"] forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];

    rightButton.tag = 102;
    
    [_barImageView addSubview:rightButton];
    
    
    if (_isGoods) {
        
        UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        rightButton1.frame = CGRectMake(kScreenWidth - 24 - 15 - 38, 32, 28, 28);
        
        [rightButton1 setBackgroundImage:[UIImage imageNamed:@"shareny"] forState:UIControlStateNormal];
        
        [rightButton1 addTarget:self action:@selector(rightBtn1Action) forControlEvents:UIControlEventTouchUpInside];
        
        rightButton1.tag = 103;
        
        [_barImageView addSubview:rightButton1];
 
        UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        rightButton2.frame = CGRectMake(kScreenWidth - 24 - 15 - 76, 32, 28, 28);
        
        [rightButton2 setBackgroundImage:[UIImage imageNamed:@"fabuny"] forState:UIControlStateNormal];
        
        [rightButton2 addTarget:self action:@selector(rightBtn2Action) forControlEvents:UIControlEventTouchUpInside];
        
        rightButton2.tag = 104;
        
        [_barImageView addSubview:rightButton2];
        
    }else{
    
        [rightButton setBackgroundImage:[UIImage imageNamed:@"shareny"] forState:UIControlStateNormal];

    }
    
    
//    addView = [[UIView alloc]initWithFrame:CGRectMake(40, 250, kScreenWidth - 80, 136)];
//    
//    addView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
//    
//    addView.layer.cornerRadius = 4;
//    
//    addView.layer.masksToBounds = YES;
//    
//    addView.hidden = YES;
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:addView];
//    
//    
//    _selectfriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    _selectfriendButton.frame = CGRectMake(0, 16, kScreenWidth - 80, 20);
//    
//    [_selectfriendButton setTitle:@"朋友圈文字" forState:UIControlStateNormal];
//    
//    [_selectfriendButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
//    
//    _selectfriendButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    
//    _selectfriendButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    
//    _selectSPMSButton.selected = YES;
//    
//    [_selectfriendButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [addView addSubview:_selectfriendButton];
//    
//    
//    _selectfriendImageV = [[UIImageView alloc]initWithFrame:CGRectMake(_selectfriendButton.width - 32, 4, 12, 12)];
//    
//    _selectfriendImageV.image = [UIImage imageNamed:@"chs11@2x"];
//    
//    [_selectfriendButton addSubview:_selectfriendImageV];
//    
//    
//    
//    _selectSPMSButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    _selectSPMSButton.frame = CGRectMake(0, 52, kScreenWidth - 80, 20);
//    
//    [_selectSPMSButton setTitle:@"商品描述" forState:UIControlStateNormal];
//    
//    [_selectSPMSButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
//    
//    _selectSPMSButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    
//    _selectSPMSButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    
//    [_selectSPMSButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [addView addSubview:_selectSPMSButton];
//    
//    _selectSPMSImageV = [[UIImageView alloc]initWithFrame:CGRectMake(_selectSPMSButton.width - 32, 4, 12, 12)];
//    
//    _selectSPMSImageV.image = [UIImage imageNamed:@"nochs11@2x"];
//    
//    
//    [_selectSPMSButton addSubview:_selectSPMSImageV];
//    
//    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    tureButton.frame = CGRectMake(0, 100, kScreenWidth - 80, 20);
//    
//    [tureButton setTitle:@"发布" forState:UIControlStateNormal];
//    
//    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
//    
//    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
//    
//    [tureButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [addView addSubview:tureButton];
//
    
//    isSPMS = YES;
    
}


//选择描述
- (void)selectButtonAction:(UIButton*)bt{
    
    if (bt == _selectfriendButton) {
        
        isSPMS = YES;
        
        _selectfriendImageV.image = [UIImage imageNamed:@"chs11@2x"];
        
        _selectSPMSImageV.image = [UIImage imageNamed:@"nochs11@2x"];
        
        
    }else{
        
        isSPMS = NO;
        
        _selectfriendImageV.image = [UIImage imageNamed:@"nochs11@2x"];
        
        _selectSPMSImageV.image = [UIImage imageNamed:@"chs11@2x"];
        
    }
    
    
}

//发布
- (void)addAction{
    
    addView.hidden = YES;
    
    bgView.hidden = YES;
    
    
    if (![_dataDic[@"goods_description"] isEqualToString:@""]) {
        
        isSPMS = YES;
        _selectfriendImageV.image = [UIImage imageNamed:@"chs11@2x"];
        _selectSPMSImageV.image = [UIImage imageNamed:@"nochs11@2x"];
        
    }else{
        isSPMS = NO;
        _selectfriendImageV.image = [UIImage imageNamed:@"nochs11@2x"];
        _selectSPMSImageV.image = [UIImage imageNamed:@"chs11@2x"];
        
    }
    

    if (isWXWB) {
        
        [self WXAction];
        
    }else{
        
        [self WBAction];
        
        
    }
    
}

- (void)rightBtn1Action{

    bgView.hidden = NO;
    editView.hidden = NO;
    
    
    editView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 160, kScreenWidth, 160)];
    editView.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:editView];
    
    UILabel *FXDLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 16)];
    
    FXDLabel.text = @"分享到...";
    
    FXDLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    FXDLabel.font = [UIFont systemFontOfSize:14];
    
    [editView addSubview:FXDLabel];
    
    
    UIButton *WXButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    WXButton.frame = CGRectMake(51, 54, 34, 34);
    
    [WXButton setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    
    [WXButton addTarget:self action:@selector(WXWBButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    WXButton.tag = 100;
    
    [editView addSubview:WXButton];
    
    UILabel *WXLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 93, 100, 14)];
    
    WXLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    WXLabel.text = @"发送到朋友圈";
    
    WXLabel.font = [UIFont systemFontOfSize:12];
    
    WXLabel.textAlignment = NSTextAlignmentCenter;
    
    [editView addSubview:WXLabel];
    
    UIButton *WBButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    WBButton.frame = CGRectMake(164, 54, 34, 34);
    
    [WBButton setImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
    
    [WBButton addTarget:self action:@selector(WXWBButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    WBButton.tag = 101;
    [editView addSubview:WBButton];
    
    UILabel *WBLabel = [[UILabel alloc]initWithFrame:CGRectMake(131, 93, 100, 14)];
    
    WBLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    WBLabel.text = @"发送到微博";
    
    WBLabel.font = [UIFont systemFontOfSize:12];
    
    WBLabel.textAlignment = NSTextAlignmentCenter;
    
    [editView addSubview:WBLabel];

}

- (void)WXWBButtonAction:(UIButton*)bt{
    
//    bgView.hidden = NO;
//    addView.hidden = NO;
//    
    if (bt.tag == 100) {
        
        isWXWB = YES;
        [self WXAction];

    }else{
        
        isWXWB = NO;
        [self WBAction];

    }
    
//    if (isWXWB) {
//        
//        
//    }else{
//        
//        
//        
//    }
    

    
    
}



- (void)rightBtn2Action{
    

    
    NSArray *typeArr = _dataDic[@"unstatus"];
    
    
    [self pushOne:typeArr];



    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)rightBtnAction{
    
    if (_isGoods) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"编辑" otherButtonTitles:@"发布历史",@"保存原图",@"删除",nil];
        
        [actionSheet showInView:self.view];
        
        
    }else{
        
        bgView.hidden = NO;
        editView.hidden = NO;
        
        editView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 160, kScreenWidth, 160)];
        editView.backgroundColor = [UIColor whiteColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:editView];
        
        UILabel *FXDLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 16)];
        
        FXDLabel.text = @"分享到...";
        
        FXDLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        FXDLabel.font = [UIFont systemFontOfSize:14];
        
        [editView addSubview:FXDLabel];
        
        
        UIButton *WXButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        WXButton.frame = CGRectMake(51, 54, 34, 34);
        
        [WXButton setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        
        [WXButton addTarget:self action:@selector(WXAction) forControlEvents:UIControlEventTouchUpInside];
        
        [editView addSubview:WXButton];
        
        UILabel *WXLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 93, 100, 14)];
        
        WXLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        WXLabel.text = @"发送到朋友圈";
        
        WXLabel.font = [UIFont systemFontOfSize:12];
        
        WXLabel.textAlignment = NSTextAlignmentCenter;
        
        [editView addSubview:WXLabel];
        
        UIButton *WBButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        WBButton.frame = CGRectMake(164, 54, 34, 34);
        
        [WBButton setImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
        
        [WBButton addTarget:self action:@selector(WBAction) forControlEvents:UIControlEventTouchUpInside];
        
        [editView addSubview:WBButton];
        
        UILabel *WBLabel = [[UILabel alloc]initWithFrame:CGRectMake(131, 93, 100, 14)];
        
        WBLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        WBLabel.text = @"发送到微博";
        
        WBLabel.font = [UIFont systemFontOfSize:12];
        
        WBLabel.textAlignment = NSTextAlignmentCenter;
        
        [editView addSubview:WBLabel];

    }
    
}

- (void)WXAction{
    
    bgView.hidden = YES;
    editView.hidden = YES;
    
    bgView = nil;
    
    
    
    
    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
    
    for (NSDictionary *dic1 in _dataDic[@"img"]) {
        
        [urlStr addObject:dic1[@"image_url"]];
        
        [imageArr addObject:@""];
        
    }
    
    __block NSInteger item1 = 0;
    
    for (int i = 0 ; i < urlStr.count; i++) {
        
        //        NSLog(@"%@",urlStr[i]);
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"");
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            item1++;
            [hud hide:YES];
            
            if (item1 == urlStr.count) {
                
                __block NSInteger item2 = 0;
                
                for (int j = 0 ; j < urlStr.count; j++) {
                    
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[j]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        NSLog(@"");
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                        item2++;
                        
                        NSLog(@"%d",j);
                        
                        if (error) {
                            
                            
                        }
                        if (image) {
                            
                            [imageArr replaceObjectAtIndex:j withObject:image];
                            
                            if (item2 == urlStr.count) {
                                
                                [self WXpush:imageArr];
                                
                            }
                        }
                    }];
                }
            }
        }];
    }
    
}

- (void)WXpush:(NSArray*)imageArr{
    
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    hud.labelText = @"商品描述已复制到系统剪切板";
    hud.mode = MBProgressHUDModeText;
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];
    
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_share_id forKey:@"goods_id"];
    
    [params setObject:@"wechat" forKey:@"type"];
    
    [DataSeviece requestUrl:add_share_loghtml params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = _dataDic[@"goods_description"];

//    if (isSPMS) {
//        
//        
//    }else{
//        
//        pasteboard.string = SPMSStr;
//    }

    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    NSLog(@"%@",imageArr);
    
    for (int i = 0; i < imageArr.count; i++) {
        
        UIImage *imagerang = imageArr[i];
        
        //        imagerang = [self scaleFromImage:imagerang scaledToSize:CGSizeMake(500, 500)];
        
        
        //        NSLog(@"%lf %lf",imagerang.size.width,imagerang.size.height);
        
        NSString *path_sandox = NSHomeDirectory();
        
        NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/ShareWX%d.jpg",i]];
        [UIImagePNGRepresentation(imagerang) writeToFile:imagePath atomically:YES];
        
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        
        /** 这里做个解释 imagerang : UIimage 对象  shareobj:NSURL 对象 这个方法的实际作用就是 在吊起微信的分享的时候 传递给他 UIimage对象,在分享的时候 实际传递的是 NSURL对象 达到我们分享九宫格的目的 */
        
        SharedItem *item = [[SharedItem alloc] initWithData:imagerang andFile:shareobj];
        
        [array addObject:item];
        
    }
    
    
    NSLog(@"%@",array);
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:array
                                                                                        applicationActivities:nil];
    
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypeAirDrop];
    
    [self presentViewController:activityViewController animated:TRUE completion:nil];
    
    
}


- (void)WBAction{
    
    bgView.hidden = YES;
    editView.hidden = YES;
    
    editView = nil;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_share_id forKey:@"goods_id"];
    
    [params setObject:@"weibo" forKey:@"type"];
    
    [DataSeviece requestUrl:add_share_loghtml params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imgStr = [NSMutableArray array];
    
    for (NSDictionary *dic1 in _dataDic[@"img"]) {
        
        [urlStr addObject:dic1[@"image_url"]];
        
        [imgStr addObject:@""];
    }
    
    __block NSInteger item1 = 0;
    
    for (int i = 0 ; i < urlStr.count; i++) {
        NSLog(@"%@",urlStr[i]);
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"");
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [hud hide:YES];
            
            if (error) {
                
            }
            if (image) {
                item1++;
                [imgStr replaceObjectAtIndex:i withObject:image];
                
                if (item1 == urlStr.count) {
                    
                    [self addImage:imgStr];
                }
            }
        }];
    }
    
    
}

- (void)addImage:(NSArray*)imageArr{
    
    NSInteger height = 0;
    
    for (int i = 0; i < imageArr.count; i++) {
        
        UIImage *image = imageArr[i];
        
        height = height +image.size.height;
    }
    
    UIImage *image1 = imageArr[0];
    
    UIGraphicsBeginImageContext(CGSizeMake(image1.size.width, height));
    
    
    NSInteger height1 = 0;
    
    for (int i = 0; i < imageArr.count; i++) {
        
        UIImage *image = imageArr[i];
        
        image = [self scaleFromImage:image scaledToSize:CGSizeMake(image.size.width, image.size.height)];
        
        [image drawInRect:CGRectMake(0, height1, image.size.width,  image.size.height)];
        
        
        height1 = height1 +image.size.height;
        
    }
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    [self WBPush:resultingImage];
    
    //    return resultingImage;
}

- (void)WBPush:(UIImage*)image1{
    
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    
    
    NSData *data = UIImageJPEGRepresentation(image1, .5);
    
    NSLog(@"%f",data.length/1024.0/1024.0);
    
    image.imageData = data;
    
    message.imageObject = image;
    
    message.text = NSLocalizedString(_dataDic[@"goods_description"], nil);

//    if (isSPMS) {
//        
//        
//    }else{
//    
//        message.text = SPMSStr;
//    }
    
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
    
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
    
}



- (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= newSize.width && height <= newSize.height){
        return image;
    }
    
    if (width == 0 || height == 0){
        return image;
    }
    
    CGFloat widthFactor = newSize.width / width;
    CGFloat heightFactor = newSize.height / height;
    CGFloat scaleFactor = (widthFactor<heightFactor?widthFactor:heightFactor);
    
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth,scaledHeight);
    
    UIGraphicsBeginImageContext(targetSize);
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}




- (void)bgButtonAction{
    
    bgView.hidden = YES;
    editView.hidden = YES;
    
    editView = nil;
    bgView = nil;
    
    
}


- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData{
    
    [_dataArr removeAllObjects];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    NSString *url = @"";
    
    if (_isGoods) {
        
        url = get_goods_detailshtml;
        
        [params setObject:_share_id forKey:@"goods_id"];

    }else if (_isFriend){
    
        url = get_friend_goods_detailhtml;
        
        [params setObject:_share_id forKey:@"goods_id"];

    }else{
        
        url = get_share_detailshtml;
        
        [params setObject:_share_id forKey:@"id"];

    }
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
    
        _dataDic = result[@"result"][@"data"];
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"img"]) {
            
            [_dataArr addObject:dic];
        }
        _pageC.numberOfPages = _dataArr.count;
        
        if (result[@"result"][@"data"][@"goods_name"]) {
            _SPMCLabel.text = result[@"result"][@"data"][@"goods_name"];

        }
        
        if (result[@"result"][@"data"][@"goods_description"]) {
            
            _SPMSLabel.text = result[@"result"][@"data"][@"goods_description"];
            
        }

        if (result[@"result"][@"data"][@"price"]) {
            _SPJGLabel.text = result[@"result"][@"data"][@"price"];
        }
        if (result[@"result"][@"data"][@"agency_price"]) {
            
            _agentPriceLabel.text = [NSString stringWithFormat:@"%ld",[result[@"result"][@"data"][@"agency_price"] integerValue]];
            
            if ([result[@"result"][@"data"][@"agency_price"] isEqualToString:@"***"]) {
                
                _DLLabel.hidden = YES;
                _agentPriceLabel.hidden = YES;
                
            }else{
                
                _DLLabel.hidden = NO;
                _agentPriceLabel.hidden = NO;
                
            }

        }
        
        
        if (result[@"result"][@"data"][@"add_time"]) {
            
            _SJLabel.text = result[@"result"][@"data"][@"add_time"];
        }
        
        if (result[@"result"][@"data"][@"price"]) {
            _SPSJLabel.text = result[@"result"][@"data"][@"price"];
            
        }
        if (result[@"result"][@"data"][@"market_price"]) {
            _SPGJLabel.text = result[@"result"][@"data"][@"market_price"];
            
        }
        
        if (result[@"result"][@"data"][@"brands_name"]) {
            _PPLabel.text = result[@"result"][@"data"][@"brands_name"];
            
        }
        if (result[@"result"][@"data"][@"category_name"]) {
            _LBLabel.text = result[@"result"][@"data"][@"category_name"];
            
        }
        
        if (result[@"result"][@"data"][@"size"]) {
            _CCLabel.text = result[@"result"][@"data"][@"size"];
            
        }
        
        if (result[@"result"][@"data"][@"bagsize"]) {
            _CCLabel.text = result[@"result"][@"data"][@"bagsize"];

        }
        
        if (result[@"result"][@"data"][@"watchsize"]) {
            _CCLabel.text = result[@"result"][@"data"][@"watchsize"];
            
        }
        
        if (result[@"result"][@"data"][@"expected_delivery_type"]) {
            _expectedId = result[@"result"][@"data"][@"expected_delivery_type"];
            
        }
        if (result[@"result"][@"data"][@"grade"]) {
            
            _gradeId = result[@"result"][@"data"][@"grade"];
        }

        if (result[@"result"][@"data"][@"cate_id"]) {
            _WDSortId = result[@"result"][@"data"][@"cate_id"];
            
        }

        if (result[@"result"][@"data"][@"returnAddressId"]) {
            _addressId = result[@"result"][@"data"][@"returnAddressId"];
            
        }
        
        if (result[@"result"][@"data"][@"material_name"]) {
            _CZLabel.text = result[@"result"][@"data"][@"material_name"];
            
        }
        
        if (result[@"result"][@"data"][@"function_name"]) {
            _GNLabel.text = result[@"result"][@"data"][@"function_name"];
            
        }
        if (result[@"result"][@"data"][@"series_name"]) {
            _XLLabel.text = result[@"result"][@"data"][@"series_name"];
            
        }
        if (result[@"result"][@"data"][@"adjunct_name"]) {
            
            _FJLabel.text = result[@"result"][@"data"][@"adjunct_name"];
            
        }
        if (result[@"result"][@"data"][@"model"]) {
            _XHLabel.text = result[@"result"][@"data"][@"model"];
            
        }
        
        if (result[@"result"][@"data"][@"goodssn"]) {
            _BHLabel.text = result[@"result"][@"data"][@"goodssn"];
            
        }

        SPMSStr = @"";
        
        
        if (![_dataDic[@"brand_name"] isEqualToString:@""]&&_dataDic[@"brand_name"] ) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  %@",SPMSStr,_dataDic[@"brand_name"]];
        }
        
        if (![_dataDic[@"series_name"] isEqualToString:@""]&&_dataDic[@"series_name"] ) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  %@",SPMSStr,_dataDic[@"series_name"]];
        }
        
        if (![_dataDic[@"model"] isEqualToString:@""]&&_dataDic[@"model"]) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  型号:%@",SPMSStr,_dataDic[@"model"]];
        }
        
        if (![_dataDic[@"size"] isEqualToString:@""]&&_dataDic[@"size"]) {
            
            if ([_dataDic[@"category_pid"] isEqualToString:@"30"]) {
                SPMSStr  = [NSString stringWithFormat:@"%@,  表径:%@",SPMSStr,_dataDic[@"size"]];
            }else{
                SPMSStr  = [NSString stringWithFormat:@"%@,  尺寸:%@",SPMSStr,_dataDic[@"size"]];
            }
        }
        
        if (![_dataDic[@"material_name"] isEqualToString:@""]&&_dataDic[@"material_name"]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  材质:%@",SPMSStr,[_dataDic[@"material_name"] stringByReplacingOccurrencesOfString:@"," withString:@"✨"]];
        }
        
        if (![_dataDic[@"function_name"] isEqualToString:@""]&&_dataDic[@"function_name"]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  功能:%@",SPMSStr,[_dataDic[@"function_name"] stringByReplacingOccurrencesOfString:@"," withString:@"⌚️"]];
        }

    
   
        
        if (![_gradeId isEqualToString:@""]&&_gradeId) {
            
            if ([_gradeId isEqualToString:@"1"]) {
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"全新(未使用)"];

            }else if ([_gradeId isEqualToString:@"2"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"98成新(未使用，成列品)"];

            }else if ([_gradeId isEqualToString:@"3"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"95成新(几乎未使用)"];

            }else if ([_gradeId isEqualToString:@"4"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"9成新(偶尔使用)"];

            }else if ([_gradeId isEqualToString:@"5"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"85成新(正常使用)"];

            }else if ([_gradeId isEqualToString:@"6"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"8成新(长期使用)"];
            }
        }
        
        
        if (![_dataDic[@"adjunct_name"] isEqualToString:@""]&&_dataDic[@"adjunct_name"]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  功能:%@",SPMSStr,[_dataDic[@"adjunct_name"] stringByReplacingOccurrencesOfString:@"," withString:@"有"]];
        }
        
        if (![_dataDic[@"market_price"] isEqualToString:@""]&&_dataDic[@"market_price"]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰公价:%@",SPMSStr,_dataDic[@"market_price"]];
        }
        
        if (![_dataDic[@"price"] isEqualToString:@""]&&_dataDic[@"price"]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰售价:%@",SPMSStr,_dataDic[@"price"]];
        }

        if (SPMSStr.length > 3) {
            SPMSStr =  [SPMSStr substringFromIndex:3];
            
        }
        

        NSLog(@"%@",SPMSStr);
        
        
        NSArray *statusArr = result[@"result"][@"data"][@"status"];
        
        for (int i = 0; i < statusArr.count; i++) {
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i * 26), 27, 16, 16)];
            
            if ([statusArr[i][@"type"] isEqualToString:@"ponhu"]) {
                imageV.image = [UIImage imageNamed:@"胖虎50@2x"];

            }
            if ([statusArr[i][@"type"] isEqualToString:@"aidingmao"]) {
                imageV.image = [UIImage imageNamed:@"爱丁猫50@2x"];
                
            }
            if ([statusArr[i][@"type"] isEqualToString:@"vdian"]) {
                imageV.image = [UIImage imageNamed:@"微店34x34@2x"];
                
            }
            if ([statusArr[i][@"type"] isEqualToString:@"newshang"]) {
                imageV.image = [UIImage imageNamed:@"心上50@2x"];
                
            }
            if ([statusArr[i][@"type"] isEqualToString:@"shopuu"]) {
                imageV.image = [UIImage imageNamed:@"少铺50@2x"];
            }
            if ([statusArr[i][@"type"] isEqualToString:@"aidingmaopro"]) {
                imageV.image = [UIImage imageNamed:@"爱丁猫专业版50@2x"];
            }
            if ([statusArr[i][@"type"] isEqualToString:@"aidingmaomer"]) {
                imageV.image = [UIImage imageNamed:@"爱丁猫商家版50@2x"];
            }
            if ([statusArr[i][@"type"] isEqualToString:@"jiuai"]) {
                imageV.image = [UIImage imageNamed:@"旧爱50@2x"];
            }
            if ([statusArr[i][@"type"] isEqualToString:@"xiaohongshu"]) {
                imageV.image = [UIImage imageNamed:@"小红书50@2x"];
            }
            
            if ([statusArr[i][@"type"] isEqualToString:@"liequ"]) {
                imageV.image = [UIImage imageNamed:@"猎趣50@2x"];
            }

            [_PTCell addSubview:imageV];
        }
        
        NSArray *typeArr = _dataDic[@"unstatus"];
        
        if (typeArr.count == 0) {
            
            UIButton *rightButton2 = [_barImageView viewWithTag:104];
            rightButton2.hidden = YES;
        }
        

        [self detailedData];
        
        [_stockCollectionView reloadData];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

//详细信息
- (void)detailedData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];

    
    //微店分类
    
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    [params2 setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params2 setObject:@"vdian" forKey:@"type"];
    
    [params2 setObject:@"category" forKey:@"param_name"];
    
    
    [DataSeviece requestUrl:get_platform_paramhtml params:params2 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSArray *idArr = [_WDSortId componentsSeparatedByString:@","];
        
        NSLog(@"%@",idArr);
        
        NSString *WDSortStr = @"";
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            
            for (NSString *str in idArr) {
                
                if ([str integerValue] == [dic[@"cate_id"] integerValue]) {
                    
                    WDSortStr = [NSString stringWithFormat:@"%@,%@",WDSortStr,dic[@"cate_name"]];
                }
            }
            
        }
        
        if (WDSortStr.length != 0) {
            WDSortStr = [WDSortStr substringFromIndex:1];
            
        }
        
        
        NSLog(@"%@",WDSortStr);
        
        _WDLBLabel.text = WDSortStr;
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    //寄回地址
    
    NSMutableDictionary *params3 = [NSMutableDictionary dictionary];
    
    [params3 setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params3 setObject:@"newshang" forKey:@"type"];
    
    [params3 setObject:@"address" forKey:@"param_name"];
    
    [DataSeviece requestUrl:get_platform_paramhtml params:params3 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            if ([dic[@"addressId"] integerValue] == [_addressId integerValue]) {
                
                _JHDZLabel.text = dic[@"city"];
            }
        }
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    if ([_expectedId isEqualToString:@"1"]) {
        _SHSJLabel.text = @"立即";
    }else if ([_expectedId isEqualToString:@"2"]){
        _SHSJLabel.text = @"1-3天";
    }else if ([_expectedId isEqualToString:@"3"]){
        _SHSJLabel.text = @"3-5天";
    }else if ([_expectedId isEqualToString:@"4"]){
        _SHSJLabel.text = @"5-10天";
    }else if ([_expectedId isEqualToString:@"5"]){
        _SHSJLabel.text = @"10天以上";
    }
    
    
    if ([_gradeId isEqualToString:@"1"]) {
        _CSLabel.text = @"全新(未使用)";
    }else if ([_gradeId isEqualToString:@"2"]){
        _CSLabel.text = @"98成新(未使用，成列品)";
    }else if ([_gradeId isEqualToString:@"3"]){
        _CSLabel.text = @"95成新(几乎未使用)";
    }else if ([_gradeId isEqualToString:@"4"]){
        _CSLabel.text = @"9成新(偶尔使用)";
    }else if ([_gradeId isEqualToString:@"5"]){
        _CSLabel.text = @"85成新(正常使用) ";
    }else if ([_gradeId isEqualToString:@"6"]){
        _CSLabel.text = @"8成新(长期使用)";
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint offset = scrollView.contentOffset;
    
    if (scrollView == _stockCollectionView) {
        
        //更新UIPageControl的当前页
        [_pageC setCurrentPage:offset.x / kScreenWidth];
        
        //        NSLog(@"%f",offset.x / bounds.size.width);
    }
    
    if (scrollView == self.tableView) {
        
        _barImageView.frame = CGRectMake(0, offset.y,kScreenWidth , 64);
        
        NSLog(@"%lf",offset.y);
        
        
        UIView *bgV = [_barImageView viewWithTag:100];
        
        UIButton *leftButton = [_barImageView viewWithTag:101];
        
        UIButton *rightButton = [_barImageView viewWithTag:102];
        
        UIButton *rightButton1 = [_barImageView viewWithTag:103];


        UIButton *rightButton2 = [_barImageView viewWithTag:104];

        if (offset.y > 270 - 64) {
            
            bgV.alpha = 1;
            leftButton.alpha = 1;
            rightButton.alpha = 1;
            rightButton1.alpha = 1;
            rightButton2.alpha = 1;

        }else if (offset.y < 0){
            
            bgV.alpha = 0;
            leftButton.alpha = 1;
            rightButton.alpha = 1;
            rightButton1.alpha = 1;
            rightButton2.alpha = 1;


        }else{
            
            bgV.alpha =  offset.y/206;
            
            
            if (103 > offset.y > 0) {
                [leftButton setBackgroundImage:[UIImage imageNamed:@"bkny"] forState:UIControlStateNormal];

                
                if (_isGoods) {
                    
                    [rightButton1 setBackgroundImage:[UIImage imageNamed:@"shareny"] forState:UIControlStateNormal];
                    [rightButton2 setBackgroundImage:[UIImage imageNamed:@"fabuny"] forState:UIControlStateNormal];
                    [rightButton setBackgroundImage:[UIImage imageNamed:@"moreny"] forState:UIControlStateNormal];
                }else{
                    [rightButton setBackgroundImage:[UIImage imageNamed:@"shareny"] forState:UIControlStateNormal];
                }
                
                leftButton.alpha = (103 - offset.y)/103;
                rightButton.alpha = (103 - offset.y)/103;
                rightButton1.alpha = (103 - offset.y)/103;
                rightButton2.alpha = (103 - offset.y)/103;

            }
            
            if (103 < offset.y && offset.y < 206) {
                
                [leftButton setBackgroundImage:[UIImage imageNamed:@"bknyblack"] forState:UIControlStateNormal];
                
                if (_isGoods) {
                    
                    [rightButton1 setBackgroundImage:[UIImage imageNamed:@"sharenyblack"] forState:UIControlStateNormal];
                    [rightButton2 setBackgroundImage:[UIImage imageNamed:@"fabunyblack"] forState:UIControlStateNormal];
                    [rightButton setBackgroundImage:[UIImage imageNamed:@"morenyblack"] forState:UIControlStateNormal];
                }else{
                
                    [rightButton setBackgroundImage:[UIImage imageNamed:@"sharenyblack"] forState:UIControlStateNormal];
                }
                
                leftButton.alpha = (offset.y - 103)/103;
                rightButton.alpha = (offset.y - 103)/103;
                rightButton1.alpha = (offset.y - 103)/103;
                rightButton2.alpha = (offset.y - 103)/103;
                
            }
        }
    }
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _dataArr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StockCellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StockCellectionCell" forIndexPath:indexPath];
    cell.url = _dataArr[indexPath.row][@"image_url"];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    return CGSizeMake(kScreenWidth, 270);
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 270;
    }else if (indexPath.row == 1){
        return 139;
    }else if (indexPath.row == 2){
        return 10;
    }else if (indexPath.row == 3){
        
        NSArray *statusArr = _dataDic[@"status"];

        if (statusArr.count == 0) {
            return 0;
        }
        
        return 50;
    }else if (indexPath.row == 4){
        
        NSArray *statusArr = _dataDic[@"status"];
        
        if (statusArr.count == 0) {
            return 0;
        }
        
        return 10;
    }else if (indexPath.row == 5){
        
        if (![_SPSJLabel.text isEqualToString:@""]) {
            return 44;
        }
        
    }else if (indexPath.row == 6){
        
        if (![_SPGJLabel.text isEqualToString:@""]) {
            return 44;
        }
        
    }else if (indexPath.row == 7){
        return 10;
    }else if (indexPath.row == 8){
        
        if (![_PPLabel.text isEqualToString:@""]) {
            return 44;
            
        }
        
    }else if (indexPath.row == 9){
        
        if (![_LBLabel.text isEqualToString:@""]) {
            return 44;
            
        }
        
    }else if (indexPath.row == 10){
        
        if (![_CCLabel.text isEqualToString:@""]) {
            return 44;
            
        }
        
    }else if (indexPath.row == 11){
        
        if (![_CSLabel.text isEqualToString:@""]) {
            return 44;
            
        }
        
    }else if (indexPath.row == 12){
        
        if (![_SHSJLabel.text isEqualToString:@""]) {
            return 44;
            
        }
        
    }else if (indexPath.row == 13){
        
        if (![_WDLBLabel.text isEqualToString:@""]) {
            return 44;
            
        }
        
    }else if (indexPath.row == 14){
        
        if (![_JHDZLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 14){
        
        if (![_JHDZLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 15){
        
        if (![_XLLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 16){
        
        if (![_XHLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 17){
        
        if (![_CZLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 18){
        
        if (![_GNLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 19){
        
        if (![_BHLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }else if (indexPath.row == 20){
        
        if (![_FJLabel.text isEqualToString:@""]) {
            return 44;
            
        }
    }
    
    
    return 0;
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    
    if (buttonIndex == 0) {
        
        if (![SYGData[@"type"] isEqualToString:@"2"]) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            
            [DataSeviece requestUrl:change_user_privilegehtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                
                if ([result[@"result"][@"data"][@"status"] isEqualToString:@"enable"]) {
                    
                    [self ModifyAction];
                    
                }else{
                    
                    alertV.message = @"没有权限修改";
                    [alertV show];
                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
            
            
        }else{
            
            NSLog(@"修改");
            
            
            [self ModifyAction];
            
        }
        
    }else if (buttonIndex == 1){
        NSLog(@"发布历史");
        
        RepertoryPublishViewController *RepertoryPublishVC = [[RepertoryPublishViewController alloc]init];
        
        RepertoryPublishVC.goods_id = _share_id;
        
        [self.navigationController pushViewController:RepertoryPublishVC animated:YES];
        
        
    }else if (buttonIndex == 2){
        
        NSLog(@"保存原图");
        
        NSMutableArray *urlStr = [NSMutableArray array];
        
        NSMutableArray *imageArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic1 in _dataDic[@"img"]) {
            
            [urlStr addObject:dic1[@"image_url"]];
            
            [imageArr addObject:@""];
            
        }
        
        __block NSInteger item1 = 0;
        
        for (int i = 0 ; i < urlStr.count; i++) {
            
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"");
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                item1++;
                [hud hide:YES];
                
                if (item1 == urlStr.count) {
                    
                    __block NSInteger item2 = 0;
                    
                    for (int j = 0 ; j < urlStr.count; j++) {
                        
                        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[j]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            NSLog(@"");
                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                            item2++;
                            
                            NSLog(@"%d",j);
                            
                            if (error) {
                                
                                
                            }
                            if (image) {
                                
                                [imageArr replaceObjectAtIndex:j withObject:image];
                                
                                if (item2 == urlStr.count) {
                                    
                                    imgArr = [imageArr copy];
                                    
                                    [self saveImageV];
                                }
                            }
                        }];
                    }
                }
            }];
        }
        
        
    }else if (buttonIndex == 3){
        
        if (![SYGData[@"type"] isEqualToString:@"2"]) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            
            [DataSeviece requestUrl:change_user_privilegehtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                
                if ([result[@"result"][@"data"][@"status"] isEqualToString:@"enable"]) {
                    
                    [self deleteAction];
                    
                }else{
                    
                    alertV.message = @"没有权限删除";
                    [alertV show];
                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
            
            
        }else{
            
            NSLog(@"删除");
            
            [self deleteAction];
            
        }
        
    }
    
}


//修改
- (void)ModifyAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];
    
    NSMutableArray *typeMutablbArr = [NSMutableArray arrayWithArray:typeArr];
    
    for (NSString *str in _dataDic[@"unstatus"]) {
        
        for (NSString *str1 in typeMutablbArr.reverseObjectEnumerator) {
            
            if ([str isEqualToString:str1]) {
                
                [typeMutablbArr removeObject:str1];
            }
        }
        
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_share_id forKey:@"goods_id"];
    
    [DataSeviece requestUrl:get_goods_detailshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:result[@"result"][@"data"]];
        
        [dic setObject:_share_id forKey:@"id"];
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
            
            OneButtonPublishingVC.recordDic = dic;
            
            OneButtonPublishingVC.isCopy = YES;
            
            OneButtonPublishingVC.typeArr = [typeMutablbArr copy];
            
            OneButtonPublishingVC.isUpData = YES;
            
            [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}

//删除
- (void)deleteAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_share_id forKey:@"id"];
    
    [DataSeviece requestUrl:delete_goodshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {

            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];

            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DelegateNotification" object:[NSString stringWithFormat:@"%ld",(long)_index]];

                        
        }else{
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


//存图片
- (void)saveImageV{
    
    
    UIImageWriteToSavedPhotosAlbum(imgArr[row], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}




// 图片保存完成
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"保存完成 %@",image);
    
    
    NSArray *imageArr = _dataDic[@"img"];
    
    row++;
    
    
    if (imageArr.count > row) {
        
        [self saveImageV];
    }
    
    if (row == imageArr.count) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存完成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertV show];
        
        row = 0;
        
    }
    
}

//跳转绑定账号页面
- (void)pushAccount{
    
    
    //    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    //    hud.labelText = @"您还有账号没绑定";
    //    hud.mode = MBProgressHUDModeCustomView;
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];
    //
    //    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    //    [hud showAnimated:YES whileExecutingBlock:^{
    //        sleep(1);
    //    } completionBlock:^{
    //        [hud removeFromSuperview];
    //    }];
    
    
    //绑定平台账号
    PlatformAccountViewController *storageVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"PlatformAccountViewController"];
    
    [self.navigationController pushViewController:storageVC animated:YES];
    
    
    
}

//跳转发布页面
- (void)pushOne:(NSArray*)typeArr{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_share_id forKey:@"goods_id"];
    
    [DataSeviece requestUrl:get_goods_detailshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:result[@"result"][@"data"]];
        
        [dic setObject:_share_id forKey:@"id"];
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
            
            OneButtonPublishingVC.recordDic = dic;
            
            OneButtonPublishingVC.isCopy = YES;
            
            OneButtonPublishingVC.typeArr = typeArr;
            
            OneButtonPublishingVC.selectTypeArr = typeArr;

            [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
            
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}



- (void)UpDataNotification{
    

    [self loadData];

 
}




- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}






@end
