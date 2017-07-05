//
//  ReleaseHistoryCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ReleaseHistoryCell.h"
#import "OneButtonPublishingViewController.h"
#import "UIView+Controller.h"
#import "SharedItem.h"
#import "AppDelegate.h"
#import "ScanViewController.h"
#import "PlatformAccountViewController.h"
#import "PartnerDetailsViewController.h"

@implementation ReleaseHistoryCell


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _scrollView.hidden = NO;
    
    row = 0;
    
    _imageWidth.constant = kScreenWidth / 4;
    _imageHeight.constant = kScreenWidth / 4;
    

    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    
    CGFloat emptylen = 20;
    
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_dic[@"goods_description"] attributes:@{NSParagraphStyleAttributeName:paraStyle01,NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _goods_descriptionLabel.attributedText = attrText;
    
    NSAttributedString *attrText1 = [[NSAttributedString alloc] initWithString:_dic[@"goods_name"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    _goods_nameLabel.attributedText = attrText1;

    _priceLabel.text = [NSString stringWithFormat:@"%ld",[_dic[@"price"] integerValue]];
    
    NSArray *imageArr = _dic[@"img"];
    
    for (int i = 0; i < 9; i++) {
        
        UIImageView *imageV = [self.contentView viewWithTag:100+i];

        if (imageArr.count > i) {
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[i][@"thumbnail"]]];
            
        }else{
            
            imageV.image = nil;
        }
    }

    if (imageArr.count < 4) {
        
        _nameTop.constant = 10 + kScreenWidth/ 4 + 10 - 8;
        
    }else if (imageArr.count > 3&& imageArr.count < 7){
        
        _nameTop.constant = 15 + kScreenWidth/ 2 + 10 - 8;

    }else if (imageArr.count > 6 && imageArr.count < 10){
    
        _nameTop.constant = 20 + kScreenWidth/ 4 * 3 + 10 - 8;

    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    
    CGRect rect = [_dic[@"goods_description"] boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paraStyle01} context:nil];
    
    _height.constant = rect.size.height + 1;
    
    _dayLabel.text = _dic[@"last_time"];

    BOOL isPH = NO;
    BOOL isADM = NO;
    BOOL isWD = NO;
    BOOL isLQ = NO;
    BOOL isXS = NO;
    BOOL isSP = NO;
    BOOL isZD = NO;
    BOOL isADMZY = NO;
    BOOL isADMSJ = NO;
    BOOL isJA = NO;

    
    for (NSString *str in _dic[@"unstatus"]) {
    
        if ([str isEqualToString:@"ponhu"]) {
            isPH = YES;
        }
        
        if ([str isEqualToString:@"aidingmao"]){
            isADM = YES;
        }
        if ([str isEqualToString:@"vdian"]){
            isWD = YES;
        }
        if ([str isEqualToString:@"liequ"]){
            isLQ = YES;
        }
        
        if ([str isEqualToString:@"newshang"]){
            isXS = YES;
        }
        
        if ([str isEqualToString:@"shopuu"]){
            isSP = YES;
        }
        if ([str isEqualToString:@"xiaohongshu"]){
            isZD = YES;
        }
        
        if ([str isEqualToString:@"aidingmaopro"]){
            isADMZY = YES;
        }
        
        if ([str isEqualToString:@"aidingmaomer"]){
            isADMSJ = YES;
        }
        
        if ([str isEqualToString:@"jiuai"]){
            isJA = YES;
        }
        
    }

    if (isPH) {
        _PHButton.hidden = NO;
        _PHLabel.hidden = NO;
        
    }else{
        _PHButton.hidden = YES;
        _PHLabel.hidden = YES;

    }
    
    if (isADM) {
        _ADMLabel.hidden = NO;
        _ADMButton.hidden = NO;
    }else{
        _ADMLabel.hidden = YES;
        _ADMButton.hidden = YES;

    }
    
    if (isWD) {
        _WDButton.hidden = NO;
        _WDLabel.hidden = NO;
    }else{
        _WDButton.hidden = YES;
        _WDLabel.hidden = YES;

    }
    
    if (isLQ) {
        _LPHButton.hidden = NO;
        _LPHLabel.hidden = NO;

    }else{
        _LPHButton.hidden = YES;
        _LPHLabel.hidden = YES;

    }
    
    if (isXS) {
        _XSButton.hidden = NO;
        _XSLabel.hidden = NO;

    }else{
        _XSButton.hidden = YES;
        _XSLabel.hidden = YES;

    }
    
    if (isSP) {
        _SPButton.hidden = NO;
        _SPLabel.hidden = NO;
        
    }else{
        _SPButton.hidden = YES;
        _SPLabel.hidden = YES;

    }
    
    if (isZD) {
        _ZDButton.hidden = NO;
        _ZDLabel.hidden = NO;

    }else{
        _ZDButton.hidden = YES;
        _ZDLabel.hidden = YES;

    }
    
    if (isADMZY) {
        _ADMZYButton.hidden = NO;
        _ADMZYLabel.hidden = NO;
    }else{
        _ADMZYButton.hidden = YES;
        _ADMZYLabel.hidden = YES;
        
    }
    
    if (isADMSJ) {
        _ADMSJButton.hidden = NO;
        _ADMSJLabel.hidden = NO;

    }else{
        _ADMSJButton.hidden = YES;
        _ADMSJLabel.hidden = YES;
        
    }
    
    if (isJA) {
        _JAButton.hidden = NO;
        _JALabel.hidden = NO;
    }else{
        _JAButton.hidden = YES;
        _JALabel.hidden = YES;
        
    }
    

    
    if (_PHButton.hidden) {
        _ADMBLeft.constant = - 34;
        _ADMLLeft.constant = - 42;
    }else{
        _ADMBLeft.constant = 20;
        _ADMLLeft.constant = 12;
    }
    
    if (_ADMButton.hidden) {
        _WDBLeft.constant =  - 34;
        _WDLLeft.constant =  - 42;
    }else{
        _WDBLeft.constant = 20;
        _WDLLeft.constant = 12;
    }
    
    if (_WDButton.hidden) {
        _LPHBLeft.constant =  - 34;
        _LPHLLeft.constant =  - 42;
    }else{
        _LPHBLeft.constant = 20;
        _LPHLLeft.constant = 12;
    }
    
    if (_LPHButton.hidden) {
        _XSBLeft.constant =  - 34;
        _XSLLeft.constant =  - 42;
    }else{
        _XSBLeft.constant = 20;
        _XSLLeft.constant = 12;
    }
    
    if (_XSButton.hidden) {
        _SPBLeft.constant =  - 34;
        _SPLLeft.constant =  - 42;
    }else{
        _SPBLeft.constant = 20;
        _SPLLeft.constant = 12;
    }

    if (_SPButton.hidden) {
        _ZDBLeft.constant =  - 34;
        _ZDLLeft.constant =  - 42;
    }else{
        _ZDBLeft.constant = 20;
        _ZDLLeft.constant = 12;
    }
    
    if (_ZDButton.hidden) {
        _ADMZYBLeft.constant =  - 34;
        _ADMZYLLeft.constant =  - 42;
    }else{
        _ADMZYBLeft.constant = 20;
        _ADMZYLLeft.constant = 12;
    }
    
    if (_ADMZYButton.hidden) {
        _ADMSJBLeft.constant =  - 34;
        _ADMSJLLeft.constant =  - 42;
    }else{
        _ADMSJBLeft.constant = 20;
        _ADMSJLLeft.constant = 12;
    }
    
    if (_ADMSJButton.hidden) {
        _JABLeft.constant =  - 34;
    }else{
        _JABLeft.constant = 20;
    }
    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];

    
    NSMutableArray *typeMutablbArr = [NSMutableArray array];
    
    for (NSString *str in _dic[@"unstatus"]) {
        
        if ([typeArr containsObject:str]) {
            
            [typeMutablbArr addObject:str];
        }

    }

    if (typeMutablbArr.count == 0||[_is_delete isEqualToString:@"1"]) {
    
        _label1.hidden = YES;
        _label2.hidden = YES;
        _view1.hidden = YES;
        _view2.hidden = YES;
        _button1.hidden = YES;
        _imageV1.hidden = YES;
        _scrollView.hidden = YES;
        
    }else{
        
        _label1.hidden = NO;
        _label2.hidden = NO;
        _view1.hidden = NO;
        _view2.hidden = NO;
        _button1.hidden = NO;
        _imageV1.hidden = NO;
        _scrollView.hidden = NO;

    }
    
    _viewWidth.constant = typeMutablbArr.count * 54 + 11;
    
    _MoreButton.hidden = NO;

    
    if ([_is_delete isEqualToString:@"1"]) {
       
        _label1.hidden = YES;
        _label2.hidden = YES;
        _view1.hidden = YES;
        _view2.hidden = YES;
        _button1.hidden = YES;
        _imageV1.hidden = YES;
        _scrollView.hidden = YES;
        _MoreButton.hidden = YES;
        
        [_WXButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_WBButton setImage:[UIImage imageNamed:@"恢复"] forState:UIControlStateNormal];

    }
    
    if ([_dic[@"agency_price"] isEqualToString:@"***"]) {
        _agentPriceTextField.userInteractionEnabled = NO;
        _DLLabel.hidden = YES;
        _agentPriceTextField.hidden = YES;
        
    }else{
        _agentPriceTextField.userInteractionEnabled = YES;
        _DLLabel.hidden = NO;
        _agentPriceTextField.hidden = NO;
        
    }
    
    _agentPriceTextField.delegate = self;

    
    if ([_dic[@"is_friend_goods"] isEqualToString:@"1"]) {

        _chatButton.hidden = NO;
        
        _shopNameLabel.hidden = NO;
        
        _shopAdressLabel.hidden = NO;
        
        _logoImageV.hidden = NO;
        
        _logoButton.hidden = NO;
        
        _editTextButton.hidden = YES;
        
        _WXLabel.hidden = NO;
        
        _MoreButton.hidden = YES;
        
        _image1Top.constant = 61;
        
        _image2Top.constant = 61;
        
        _imageTop.constant = 61;
        
        _image3Top.constant = 61;
        
        _logoImageV.layer.cornerRadius = 4;
        
        _logoImageV.layer.masksToBounds = YES;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
        
        NSString *imgUrl_API = serviceData[@"imgUrl_API"];

        
        [_logoImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl_API,_dic[@"logo"]]] placeholderImage:[UIImage imageNamed:@"mrtx1"]];
        
        _shopNameLabel.text = _dic[@"shop_name"];
        
        _shopAdressLabel.text = @"同行";
        
        _shopAdressLabel.layer.cornerRadius = 2;
        
        _shopAdressLabel.layer.masksToBounds =  YES;
        
        if ([_dic[@"wechat"] isEqualToString:@""]) {
         
            _WXLabel.text = @"";
            
        }else{
        
            _WXLabel.text = [NSString stringWithFormat:@"微信：%@",_dic[@"wechat"]];
            
        }

        if (imageArr.count < 4) {
            
            _nameTop.constant = 10 + kScreenWidth/ 4 + 10 - 8  + 52;
            
        }else if (imageArr.count > 3&& imageArr.count < 7){
            
            _nameTop.constant = 15 + kScreenWidth/ 2 + 10 - 8 + 52;
            
        }else if (imageArr.count > 6 && imageArr.count < 10){
            
            _nameTop.constant = 20 + kScreenWidth/ 4 * 3 + 10 - 8 + 52;
            
        }
        
        _agentPriceTextField.attributedText = nil;
        
        _agentPriceTextField.text = [NSString stringWithFormat:@"%ld",[_dic[@"agency_price"] integerValue]];

        _agentPriceTextField.userInteractionEnabled = NO;

    }else{
    
        _chatButton.hidden = YES;

        _MoreButton.hidden = NO;
        
        _shopNameLabel.hidden = YES;
        
        _shopAdressLabel.hidden = YES;
        
        _logoImageV.hidden = YES;
        
        _logoButton.hidden = YES;
        
        _editTextButton.hidden = NO;
        
        _WXLabel.hidden = YES;
        
        _image1Top.constant = 2;
        
        _image2Top.constant = 2;
        
        _imageTop.constant = 2;
        
        _image3Top.constant = 2;
        
        //下划线
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",[_dic[@"agency_price"] integerValue]] attributes:attribtDic];
        
        _agentPriceTextField.attributedText = attribtStr;
        
        if (_isFriend) {
            
            _editTextButton.hidden = YES;

            _MoreButton.hidden = YES;

            _agentPriceTextField.text = [NSString stringWithFormat:@"%ld",[_dic[@"agency_price"] integerValue]];
            
            _agentPriceTextField.userInteractionEnabled = NO;

        }
        
    }
    
    
}


- (void)setDic1:(NSDictionary *)dic1{
    
    _dic1 = dic1;
    
//    _isFriend = YES;

    _agentPriceTextField.text = [NSString stringWithFormat:@"%ld",[_dic1[@"agency_price"] integerValue]];
    
    if ([_dic1[@"agency_price"] isEqualToString:@"***"]) {
        _DLLabel.hidden = YES;
        _agentPriceTextField.hidden = YES;

    }else{
        _DLLabel.hidden = NO;
        _agentPriceTextField.hidden = NO;

    }

    _agentPriceTextField.userInteractionEnabled = NO;

    _shopNameLabel.hidden = NO;
    
    _shopAdressLabel.hidden = NO;
    
    _logoImageV.hidden = NO;
    
    _logoButton.hidden = NO;


    _editTextButton.hidden = YES;
    
    _imageWidth.constant = kScreenWidth / 4;
    _imageHeight.constant = kScreenWidth / 4;
    
    _image1Top.constant = 60;
    
    _image2Top.constant = 60;
    
    _imageTop.constant = 60;
    
    _image3Top.constant = 60;
    
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_dic1[@"goods_description"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    _goods_descriptionLabel.attributedText = attrText;
    
    
    NSAttributedString *attrText1 = [[NSAttributedString alloc] initWithString:_dic1[@"goods_name"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    _goods_nameLabel.attributedText = attrText1;
    
    _priceLabel.text = [NSString stringWithFormat:@"%ld",[_dic1[@"price"] integerValue]];
    
    NSArray *imageArr = _dic1[@"img"];
    
    for (int i = 0; i < 9; i++) {
        
        UIImageView *imageV = [self.contentView viewWithTag:100+i];
        
        if (imageArr.count > i) {
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[i][@"thumbnail"]]];
            
        }else{
            
            imageV.image = nil;
        }
    }
    
    if (imageArr.count < 4) {
        
        _nameTop.constant = 10 + kScreenWidth/ 4 + 10 - 8  + 52;
        
    }else if (imageArr.count > 3&& imageArr.count < 7){
        
        _nameTop.constant = 15 + kScreenWidth/ 2 + 10 - 8 + 52;
        
    }else if (imageArr.count > 6 && imageArr.count < 10){
        
        _nameTop.constant = 20 + kScreenWidth/ 4 * 3 + 10 - 8 + 52;
        
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    
    CGRect rect = [_dic1[@"goods_description"] boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    _height.constant = rect.size.height + 1;
    
    _dayLabel.text = _dic1[@"add_time"];

    _label1.hidden = YES;
    _label2.hidden = YES;
    _view1.hidden = YES;
    _view2.hidden = YES;
    _button1.hidden = YES;
    _imageV1.hidden = YES;
    _scrollView.hidden = YES;
    _MoreButton.hidden = YES;

}


- (void)WXWBButtonAction:(NSString*)str{
    
    
    if ([str isEqualToString:@"1"]) {
        
        isWXWB = YES;
        [self WXButtonAction];

    }else{
        
        isWXWB = NO;
        [self WBButtonAction];

    }
    
}




- (IBAction)pushAction:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"编辑" otherButtonTitles:@"发布历史",@"保存原图",@"删除",nil];
    
    [actionSheet showInView:self];
    
}

- (IBAction)AllPushAction:(id)sender {
    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];
    
    NSMutableArray *typeMutablbArr = [NSMutableArray array];
    
    for (NSString *str in _dic[@"unstatus"]) {
        
        if ([typeArr containsObject:str]) {
            
            [typeMutablbArr addObject:str];
        }
        
    }
    
    [self pushOne:[typeMutablbArr copy]];

    
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
        
        RepertoryPublishVC.goods_id = _dic[@"id"];
        
        RepertoryPublishVC.hidesBottomBarWhenPushed = YES;
        
        [self.viewController.navigationController pushViewController:RepertoryPublishVC animated:YES];
    
        
    }else if (buttonIndex == 2){
        
        NSLog(@"保存原图");
        
        NSMutableArray *urlStr = [NSMutableArray array];
        
        NSMutableArray *imageArr = [NSMutableArray array];
        
        
        for (NSDictionary *dic1 in _dic[@"img"]) {
            
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
    
    for (NSString *str in _dic[@"unstatus"]) {
        
        for (NSString *str1 in typeMutablbArr.reverseObjectEnumerator) {
            
            if ([str isEqualToString:str1]) {
                
                [typeMutablbArr removeObject:str1];
            }
        }

    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"id"] forKey:@"goods_id"];
    
    [DataSeviece requestUrl:get_goods_detailshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:result[@"result"][@"data"]];
        
        [dic setObject:_dic[@"id"] forKey:@"id"];
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
            
            OneButtonPublishingVC.recordDic = dic;
            
            OneButtonPublishingVC.isCopy = YES;
            
            OneButtonPublishingVC.typeArr = [typeMutablbArr copy];
            
            OneButtonPublishingVC.selectTypeArr = [typeMutablbArr copy];

            OneButtonPublishingVC.isUpData = YES;
            
            OneButtonPublishingVC.hidesBottomBarWhenPushed = YES;
            
            [self.viewController.navigationController pushViewController:OneButtonPublishingVC animated:YES];
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
    [params setObject:_dic[@"id"] forKey:@"id"];
    
    [DataSeviece requestUrl:delete_goodshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
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
    
    
    NSArray *imageArr = _dic[@"img"];

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

//微信按钮
- (IBAction)WXWBAction:(id)sender {
    
    if ([_is_delete isEqualToString:@"1"]) {
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        if (![SYGData[@"type"] isEqualToString:@"2"]) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            [DataSeviece requestUrl:change_user_privilegehtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                
                if ([result[@"result"][@"data"][@"status"] isEqualToString:@"enable"]) {
                    
                    alertV1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定完全删除"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    
                    [alertV1 show];
                    
                    
                }else{
                    
                    alertV.message = @"没有权限完全删除";
                    [alertV show];
                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
            
        }else{
            
            NSLog(@"删除");
            
            alertV1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定完全删除"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alertV1 show];
            
        }
        
    }else{
    

        [self WXWBButtonAction:@"1"];
        

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
        
        [self WXButtonAction];
        
    }else{
        
        [self WBButtonAction];
        
        
    }
    
}

//微信
- (void)WXButtonAction{


    
    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (NSDictionary *dic1 in _dic[@"img"]) {
        
        [urlStr addObject:dic1[@"image_url"]];
        
        [imageArr addObject:@""];
        
    }

    
    NSLog(@"%@",urlStr);
    
    __block NSInteger item1 = 0;
    
    for (int i = 0 ; i < urlStr.count; i++) {
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr[i],thumbnail_img]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            NSLog(@"");
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            item1++;
            [hud hide:YES];
            
            if (item1 == urlStr.count) {
                
                __block NSInteger item2 = 0;
                
                for (int j = 0 ; j < urlStr.count; j++) {
                    
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr[j],thumbnail_img]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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


//微博
- (void)WBButtonAction{


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"id"] forKey:@"goods_id"];

    
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
    
    [params setObject:_dic[@"id"] forKey:@"goods_id"];
    
    [params setObject:@"wechat" forKey:@"type"];
    
    [DataSeviece requestUrl:add_share_loghtml params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
   
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = _goods_descriptionLabel.text;

    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    NSLog(@"%@",imageArr);
    
    for (int i = 0; i < imageArr.count; i++) {
        
        UIImage *imagerang = imageArr[i];
        
        NSLog(@"%lf %lf",imagerang.size.width,imagerang.size.height);
        
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


- (IBAction)WBButtonAction:(id)sender {
    
    if ([_is_delete isEqualToString:@"1"]) {
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        if (![SYGData[@"type"] isEqualToString:@"2"]) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            
            [DataSeviece requestUrl:change_user_privilegehtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                
                if ([result[@"result"][@"data"][@"status"] isEqualToString:@"enable"]) {
                    
                    alertV2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定恢复"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    
                    [alertV2 show];
                    
                    
                }else{
                    
                    alertV.message = @"没有权限恢复";
                    [alertV show];
                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
            
            
        }else{
            
            NSLog(@"恢复");
            
            
            alertV2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定恢复"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alertV2 show];
            
        }
        
    }else{

        [self WXWBButtonAction:@"0"];
        
        
        
    }
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    [_agentPriceTextField resignFirstResponder];
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    
    NSMutableArray *imaArr = [NSMutableArray array];
    
    NSInteger height;

    /** 图片数组*/
    
    
    for (NSDictionary *dic1 in _dic[@"img"]) {
        
        [imaArr addObject:dic1[@"image_url"]];
    }
    
    height = 0;

    
    if ([_dic[@"is_friend_goods"] isEqualToString:@"1"]) {
        
        height = 58;

    }
    
    
    NSMutableArray *thumbnailArr = [NSMutableArray array];
    
    for (int i = 0 ; i < imaArr.count; i++) {
        
        UIImageView *imageV = [self.contentView viewWithTag:100+i];

        if (imageV.image) {
            
            [thumbnailArr addObject:imageV.image];

        }else{
        
            [thumbnailArr addObject:[UIImage imageNamed:@"bg_clear"]];

        }
        
    }
    
    ScanViewController *scanVC = [[ScanViewController alloc]init];
    
    scanVC.imageURLArr = [imaArr copy];
    
    scanVC.hidesBottomBarWhenPushed = YES;
    
    scanVC.share_id = _dic[@"id"];
    
    if ([_dic[@"is_friend_goods"] isEqualToString:@"1"]||_isFriend) {

        scanVC.isFriend = YES;

    }else{
    
        scanVC.isFriend = NO;
    }

        
    scanVC.thumbnailArr = thumbnailArr;
    
    
    if (y > 10 +height  && y < 10+height + kScreenWidth/4 &&x > 10 && x < 10 + kScreenWidth/4) {
        
        if (imaArr.count > 0 ) {
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];

        }
        
    }
    
    if (y > 10+height && y < 10 + kScreenWidth/4+height && x > 15 + kScreenWidth/4 && x < 15 + kScreenWidth/2) {
        
        if (imaArr.count > 1 ) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }
        
    }
    
    if (y > 10+height && y < 10 + kScreenWidth/4+height &&x > 20 + kScreenWidth/2 && x < 20 + kScreenWidth/4 * 3) {
        
        if (imaArr.count > 2 ) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:2 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }

    }
    
    if (y > 15+height + kScreenWidth/4 && y < 15+height + kScreenWidth/2 &&x > 10 && x < 10 + kScreenWidth/4) {
        
        if (imaArr.count > 3 ) {
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:3 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }
    }
    
    if (y > 15+height + kScreenWidth/4 && y < 15+height + kScreenWidth/2&& x > 15 + kScreenWidth/4 && x < 15 + kScreenWidth/2) {
        
        if (imaArr.count > 4 ) {
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:4 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }
        
    }
    
    if (y > 15+height + kScreenWidth/4 && y < 15+height + kScreenWidth/2 && x > 20 + kScreenWidth/2 && x < 20 + kScreenWidth/4 * 3) {
        
        if (imaArr.count > 5 ) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:5 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }
        
    }


    
    if (y > 20+height + kScreenWidth/2 && y < 20+height + kScreenWidth/4 * 3 &&x > 10 && x < 10 + kScreenWidth/4) {
        
        if (imaArr.count > 6 ) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:6 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }
        
    }
    
    
    if (y > 20+height + kScreenWidth/2 && y < 20 +height+ kScreenWidth/4 * 3&&x > 15 + kScreenWidth/4 && x < 15 + kScreenWidth/2) {
        
        if (imaArr.count > 7 ) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:7 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
            
        }

    }
    
    
    if (y > 20+height + kScreenWidth/2 && y < 20+height + kScreenWidth/4 * 3&& x > 20 + kScreenWidth/2 && x < 20 + kScreenWidth/4 * 3) {
        
        if (imaArr.count > 8 ) {
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:8 inSection:0];
            scanVC.currentIndexPath = path;
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
        }
        
    }
    
}
//
- (IBAction)buttonAction:(UIButton *)sender {

    

    NSArray *typeArr = @[];
    
    
    if (sender == _PHButton) {
        
        
        typeArr = @[@"ponhu"];
        
    }else if (sender == _ADMButton){
        
        typeArr = @[@"aidingmao"];
        
        
    }else if (sender == _WDButton){
        
        typeArr = @[@"vdian"];
        
    }else if (sender == _LPHButton){
        
        typeArr = @[@"liequ"];

    }else if (sender == _XSButton){
        
        typeArr = @[@"newshang"];

    
    }else if (sender == _SPButton){
        
        typeArr = @[@"shopuu"];

        
    }else if (sender == _ZDButton){
        
        typeArr = @[@"xiaohongshu"];

        
    }else if (sender == _ADMZYButton){
        
        typeArr = @[@"aidingmaopro"];
        

    }else if (sender == _ADMSJButton){
        
        typeArr = @[@"aidingmaomer"];

    }else if (sender == _JAButton){
        
        typeArr = @[@"jiuai"];

    }
    
    [self pushOne:typeArr];

}

//跳转绑定账号页面
- (void)pushAccount{

    
    //绑定平台账号
    PlatformAccountViewController *storageVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"PlatformAccountViewController"];
    
    storageVC.hidesBottomBarWhenPushed = YES;
    
    [self.viewController.navigationController pushViewController:storageVC animated:YES];
    
    
}

//跳转发布页面
- (void)pushOne:(NSArray*)typeArr{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"id"] forKey:@"goods_id"];
    
    [DataSeviece requestUrl:get_goods_detailshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:result[@"result"][@"data"]];
        
        [dic setObject:_dic[@"id"] forKey:@"id"];
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
            
            OneButtonPublishingVC.recordDic = dic;
            
            OneButtonPublishingVC.isCopy = YES;
            
            OneButtonPublishingVC.typeArr = typeArr;
            
            OneButtonPublishingVC.selectTypeArr = typeArr;
            
            OneButtonPublishingVC.hidesBottomBarWhenPushed = YES;
            
            [self.viewController.navigationController pushViewController:OneButtonPublishingVC animated:YES];

        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

//编辑文字
- (IBAction)editLabelAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    if (![SYGData[@"type"] isEqualToString:@"2"]) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [DataSeviece requestUrl:change_user_privilegehtml params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            
            if ([result[@"result"][@"data"][@"status"] isEqualToString:@"enable"]) {
                
                [self editTextAction];
                
            }else{
                
                alertV.message = @"没有权限修改";
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
        
        
    }else{
        
        NSLog(@"修改文字");
        
        [self editTextAction];
        
    }

    
}
//修改文字

- (void)editTextAction{

    bgView.hidden = NO;
    editView.hidden = NO;
    
    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];
    
    editView = [[UIView alloc]initWithFrame:CGRectMake(55, kScreenHeight/2 - 200, kScreenWidth - 110, 230)];
    editView.layer.cornerRadius = 4;
    editView.layer.masksToBounds = YES;
    editView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:editView];
    
    editTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 35, kScreenWidth - 140, 140)];
    
    editTextView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
    editTextView.tag = 200;
    editTextView.text = _dic[@"goods_description"];
    
    [editView addSubview:editTextView];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editButton.frame = CGRectMake(35, 187, kScreenWidth - 180, 34);
    
    editButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    
    editButton.layer.cornerRadius = 4;
    
    editButton.layer.masksToBounds = YES;
    
    [editButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [editButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    
    editButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:editButton];
    
    
    UIButton *delegateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    delegateButton.frame = CGRectMake(editView.width - 31, 2, 27, 27);
    
    [delegateButton setImage:[UIImage imageNamed:@"wr1@2x"] forState:UIControlStateNormal];
    
    [delegateButton addTarget:self action:@selector(delegateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [editView addSubview:delegateButton];
    
}

//删除
- (void)delegateButtonAction{
    
    [editTextView resignFirstResponder];

    editView.hidden = YES;
    
    bgView.hidden = YES;

    editView = nil;
    bgView = nil;

}

//保存
- (void)editButtonAction{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
    
    [editTextView resignFirstResponder];

    editView.hidden = YES;
    
    bgView.hidden = YES;
    
    editView = nil;
    
    bgView = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"id"] forKey:@"id"];

    [params setObject:editTextView.text forKey:@"friend_describe"];

    //
    //    [params setObject:@{@"1":@{@"attribute_id":_dic[@"attribute_id"],@"attribute_value":editTextView.text}} forKey:@"attribute_list"];
    //
    NSLog(@"%@",params);
    
    [DataSeviece requestUrl:update_goodshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result[@"result"][@"msg"],result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {

            alert.message = @"保存成功";
            [alert show];
            
            NSDictionary *dic = @{@"2":editTextView.text,@"1":[NSString stringWithFormat:@"%ld",(long)_index]};
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            [DataSeviece requestUrl:get_shop_settinghtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                if ([result[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {
                    
                    
                    if ([result[@"result"][@"data"][@"stick_after_publish"] integerValue] == 1) {

                        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataNotification" object:dic];

                    }else{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"TextViewNotification" object:dic];
                        
                    }
                    
                }else{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"TextViewNotification" object:dic];

                }
                
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];

            
            
            
        }else{
            
            alert.message = @"保存失败";
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)bgButtonAction{

    
    [editTextView resignFirstResponder];
    
    editView.hidden = YES;
    
    bgView.hidden = YES;

    RYView.hidden = YES;
    
    addView.hidden = YES;
    editView = nil;
    bgView = nil;
    addView = nil;
    RYView = nil;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    if (buttonIndex == 1) {
        
        if (alertV1 == alertView) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            [params setObject:_dic[@"id"] forKey:@"id"];
            [params setObject:@"1" forKey:@"confirm"];
            
            [DataSeviece requestUrl:delete_goodshtml params:params success:^(id result) {
                NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"DelegateNotification" object:[NSString stringWithFormat:@"%ld",(long)_index]];
                    
                }else{
                    
                    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertV show];
                    
                }
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
        
        if (alertView == alertV2) {
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            [params setObject:_dic[@"id"] forKey:@"id"];
            
            [DataSeviece requestUrl:rollback_goodshtml params:params success:^(id result) {
                NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"DelegateNotification" object:[NSString stringWithFormat:@"%ld",_index]];
                    
                }else{
                    
                    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertV show];
                    
                }
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
        
    }
    
}

- (IBAction)logoAction:(id)sender {
    
    PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
    
    PartnerDetailsVC.shop_id = _dic[@"shop_id"];
    
    PartnerDetailsVC.hidesBottomBarWhenPushed = YES;
    
    [self.viewController.navigationController pushViewController:PartnerDetailsVC animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"id"] forKey:@"id"];
    
    [params setObject:_agentPriceTextField.text forKey:@"agency_price"];
    
    NSLog(@"%@",params);
    
    [DataSeviece requestUrl:update_goodshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result[@"result"][@"msg"],result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            alert.message = @"保存成功";
            
            [alert show];
            
            NSDictionary *dic = @{@"2":_agentPriceTextField.text,@"1":[NSString stringWithFormat:@"%ld",(long)_index]};
            
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            [DataSeviece requestUrl:get_shop_settinghtml params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                if ([result[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {

                    if ([result[@"result"][@"data"][@"stick_after_publish"] integerValue] == 1) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataNotification" object:dic];
                        
                    }else{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"DLTextViewNotification" object:dic];
                        
                    }
                }else{
                
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"DLTextViewNotification" object:dic];
                }
                
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
            
        }else{
            
            alert.message = @"保存失败";
            [alert show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    return YES;
}
//聊天
- (IBAction)chatAction:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"shop_id"] forKey:@"shop_id"];
    
    [DataSeviece requestUrl:get_shop_user_listhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            NSArray *arr = result[@"result"][@"data"][@"user"];
            
            //遮罩视图
            bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
            bgView.alpha = .4;
            [[UIApplication sharedApplication].keyWindow addSubview:bgView];
            
            UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bgButton.frame = bgView.frame;
            [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
            [bgView addSubview:bgButton];
            
            RYView = [[RYSelectListView alloc]initWithFrame:CGRectMake(18, (kScreenHeight - (arr.count + 1) * 50)/2, kScreenWidth - 36, (arr.count + 1) * 50)];
            
            RYView.dataDic = result[@"result"][@"data"];
            
            RYView.backBlock = ^(NSInteger index) {
                
                [self bgButtonAction];
                
                NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
                
                NSString *RYUserId = serviceData[@"RYUserId"];

                //新建一个聊天会话View Controller对象,建议这样初始化
                BaseChatViewController *chat = [[BaseChatViewController alloc] initWithConversationType:ConversationType_PRIVATE
                                                                                               targetId:[NSString stringWithFormat:@"%@%@",RYUserId,result[@"result"][@"data"][@"user"][index][@"id"]]];
                
                chat.hidesBottomBarWhenPushed = YES;
                
                //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
                //            chat.conversationType = ConversationType_PRIVATE;
                //            //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
                //            chat.targetId = @"targetIdYouWillChatIn";
                //
                //设置聊天会话界面要显示的标题
                
                chat.title = result[@"result"][@"data"][@"user"][index][@"nickname"];
                //显示聊天会话界面
                [self.viewController.navigationController pushViewController:chat animated:YES];
                
            };
            
            [[UIApplication sharedApplication].keyWindow addSubview:RYView];
            
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

}

@end
