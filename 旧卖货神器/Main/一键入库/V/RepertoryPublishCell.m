//
//  RepertoryPublishCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "RepertoryPublishCell.h"
#import "OneButtonPublishingViewController.h"
#import "UIView+Controller.h"
#import "SharedItem.h"
#import "AppDelegate.h"
#import "ScanViewController.h"

@implementation RepertoryPublishCell




- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _goods_descriptionLabel.font = [UIFont systemFontOfSize:14];
    _goods_nameLabel.font = [UIFont systemFontOfSize:14];
    
    _goods_descriptionLabel.text = _dic[@"goods_description"];
    
    _goods_nameLabel.text = _dic[@"goods_name"];
    
    _priceLabel.text = _dic[@"price"];
    
    _add_timeLabel.text = [_dic[@"add_time"] substringToIndex:10];
    
    _add_timeLabel.hidden = YES;
    
    _agentPriceLabel.text = [NSString stringWithFormat:@"%ld",[_dic[@"agency_price"] integerValue]];
    
    if ([_dic[@"agency_price"] isEqualToString:@"***"]) {
        _DLLabel.hidden = YES;
        _agentPriceLabel.hidden = YES;
        
    }else{
        _DLLabel.hidden = NO;
        _agentPriceLabel.hidden = NO;
        
    }
    
    
    NSArray *imageArr = _dic[@"img"];
    
    
    if (_isFriend) {
        
        _shareButton.hidden = YES;
        
    }
    
    
    if (imageArr.count > 0 ) {
        
        [_imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[0][@"thumbnail"]]];

    }else{
    
        _imageV.image = nil;
    }
    

}



- (IBAction)buttonAction:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"id"] forKey:@"goods_id"];

    NSString *url = @"";
    
    if (_isFriend){
        
        url = get_friend_goods_detailhtml;
        
    }else{
        
        url = get_goods_detailshtml;
        
    }
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSDictionary *_dataDic = result[@"result"][@"data"];
        
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
        
        
        
        if (![_dataDic[@"grade"] isEqualToString:@""]&&_dataDic[@"grade"]) {
            
            if ([_dataDic[@"grade"] isEqualToString:@"1"]) {
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"全新(未使用)"];
                
            }else if ([_dataDic[@"grade"] isEqualToString:@"2"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"98成新(未使用，成列品)"];
                
            }else if ([_dataDic[@"grade"] isEqualToString:@"3"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"95成新(几乎未使用)"];
                
            }else if ([_dataDic[@"grade"] isEqualToString:@"4"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"9成新(偶尔使用)"];
                
            }else if ([_dataDic[@"grade"] isEqualToString:@"5"]){
                SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,@"85成新(正常使用)"];
                
            }else if ([_dataDic[@"grade"] isEqualToString:@"6"]){
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


    
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];

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

    
    bgView.hidden = NO;
    editView.hidden = NO;
    
    
}

- (void)WXWBButtonAction:(UIButton*)bt{
    
    editView.hidden = YES;
    
    editView = nil;
    
    bgView.hidden = YES;
    
    bgView = nil;
    
//    addView = [[UIView alloc]initWithFrame:CGRectMake(40, 250, kScreenWidth - 80, 136)];
//    
//    addView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
//    
//    addView.layer.cornerRadius = 4;
//    
//    addView.layer.masksToBounds = YES;
//    
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:addView];
//    
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
//    
//    if (![_dic[@"goods_description"] isEqualToString:@""]) {
//        
//        isSPMS = YES;
//        _selectfriendImageV.image = [UIImage imageNamed:@"chs11@2x"];
//        _selectSPMSImageV.image = [UIImage imageNamed:@"nochs11@2x"];
//        
//    }else{
//        isSPMS = NO;
//        _selectfriendImageV.image = [UIImage imageNamed:@"nochs11@2x"];
//        _selectSPMSImageV.image = [UIImage imageNamed:@"chs11@2x"];
//        
//    }
//
//    
//    bgView.hidden = NO;
//    addView.hidden = NO;

    
    if (bt.tag == 100) {
        
        isWXWB = YES;
        [self WXAction];

    }else{
        
        isWXWB = NO;
        [self WBAction];

    }
    
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
    
    addView = nil;
  
    bgView = nil;
    
    if (isWXWB) {
        
        [self WXAction];
        
    }else{
        
        [self WBAction];
        
        
    }
    
}



- (void)WXAction{
    
    bgView.hidden = YES;
    editView.hidden = YES;
    

    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
    
    for (NSDictionary *dic1 in _dic[@"img"]) {
        
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
    hud.labelText = @"朋友圈文字已复制到系统剪切板";
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
    
    if (_dic[@"share_goods_id"]) {
        
        [params setObject:_dic[@"share_goods_id"] forKey:@"goods_id"];

    }else{
        [params setObject:_dic[@"id"] forKey:@"goods_id"];

    }
    
    
    [params setObject:@"wechat" forKey:@"type"];
    
    [DataSeviece requestUrl:add_share_loghtml params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = _goods_descriptionLabel.text;

//    if (isSPMS) {
//        
//        
//    }else{
//        
//        pasteboard.string = SPMSStr;
//    }
//
    
    
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
    
    [self.viewController presentViewController:activityViewController animated:TRUE completion:nil];
    
}


- (void)WBAction{
    
    bgView.hidden = YES;
    editView.hidden = YES;
    


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    if (_dic[@"share_goods_id"]) {
        [params setObject:_dic[@"share_goods_id"] forKey:@"goods_id"];
    }else{
        [params setObject:_dic[@"id"] forKey:@"goods_id"];
    }
    
    [params setObject:@"weibo" forKey:@"type"];
    
    [DataSeviece requestUrl:add_share_loghtml params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imgStr = [NSMutableArray array];
    
    for (NSDictionary *dic1 in _dic[@"img"]) {
        
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
    
    message.text = NSLocalizedString(_goods_descriptionLabel.text, nil);

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
    addView.hidden = YES;
    
    bgView = nil;
    editView = nil;
    addView = nil;

}

@end
