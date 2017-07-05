//
//  UpdatePlatform ViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "UpdatePlatform ViewController.h"
#import "ReleaseCompleteViewController.h"

@interface UpdatePlatform_ViewController (){
    
    UIView *bgView;
    
    UIView *feedBackV;

    CGFloat angle1;
    CGFloat angle2;
    CGFloat angle3;
    CGFloat angle4;
    CGFloat angle5;
    CGFloat angle6;
    CGFloat angle7;
    CGFloat angle8;
    CGFloat angle9;
    CGFloat angle10;

    
    BOOL isPHRotate;
    BOOL isADMRotate;
    BOOL isWBRotate;
    BOOL isLPHRotate;
    BOOL isXSRotate;
    BOOL isSPRotate;
    BOOL isZDRotate;
    BOOL isADMZYRotate;
    BOOL isADMSJRotate;
    BOOL isJARotate;



    
    NSString *PHmsg;
    NSString *ADMmsg;
    NSString *WBmsg;
    NSString *LPHmsg;
    NSString *XSmsg;
    NSString *SPmsg;
    NSString *ZDmsg;
    NSString *ADMZYmsg;
    NSString *ADMSJmsg;
    NSString *JAmsg;

}

@end

@implementation UpdatePlatform_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    ADMmsg = @"";
    
    PHmsg = @"";
    
    WBmsg = @"";
    
    LPHmsg = @"";
    
    XSmsg = @"";
    
    SPmsg = @"";
    
    ZDmsg = @"";
    
    ADMZYmsg = @"";

    ADMSJmsg = @"";
    JAmsg = @"";
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 4, 14)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    
    lineV.layer.cornerRadius = 2;
    
    lineV.layer.masksToBounds = YES;
    
    [self.view addSubview:lineV];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 10, 220, 21)];
    
    textLabel.text = @"将新的商品信息更新到以下平台";
    
    textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    textLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:textLabel];

    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    
    NSLog(@"%@",_typeArr);
    
    for (int i = 0; i < _typeArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i < 4) {
            button.frame = CGRectMake(((kScreenWidth - 280)/5 * (i +1))+ 70 * i,35 , 70, 92);
            
        }else if(i < 8) {
            button.frame = CGRectMake(((kScreenWidth - 280)/5 * (i - 4 + 1) ) + 70 * (i - 4), 35 + 92 + 10 , 70, 92);
        }else if(i < 12){
            
            button.frame = CGRectMake(((kScreenWidth - 280)/5 * (i - 8 + 1) ) + 70 * (i - 8), 35 + 92 + 10 + 92 + 10, 70, 92);
        }else{
        
            button.frame = CGRectMake(((kScreenWidth - 280)/5 * (i - 12 + 1) ) + 70 * (i - 12), 35 + 92 + 10 + 92 + 10, 70, 92);

        }
        
        button.tag = 200+i;
        button.selected = YES;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        
        imageV.tag = 100;
        
        [button addSubview:imageV];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 72, 15)];
        
        label.tag = 101;
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [button addSubview:label];
        
        
        UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 0, 38, 39)];
        
        imageV1.image = [UIImage imageNamed:@"标签.png"];
        
        imageV1.tag = 102;
        
        [button addSubview:imageV1];
        
        if ([_typeArr[i] isEqualToString:@"ponhu"]) {
            imageV.image = [UIImage imageNamed:@"胖虎50@2x"];
            label.text = @"胖虎";
        }else if ([_typeArr[i] isEqualToString:@"aidingmao"]){
            imageV.image = [UIImage imageNamed:@"爱丁猫50@2x"];
            label.text = @"爱丁猫";
        }else if ([_typeArr[i] isEqualToString:@"vdian"]){
            imageV.image = [UIImage imageNamed:@"微店50@2x"];
            label.text = @"微店";
        }else if ([_typeArr[i] isEqualToString:@"newshang"]){
            imageV.image = [UIImage imageNamed:@"心上50@2x"];
            label.text = @"心上";
        }else if ([_typeArr[i] isEqualToString:@"shopuu"]){
            imageV.image = [UIImage imageNamed:@"少铺50@2x"];
            label.text = @"少铺";
        }else if ([_typeArr[i] isEqualToString:@"aidingmaopro"]){
            label.width = 50;
            label.height = 40;
            label.left = 10;
            label.top = 55;
            label.numberOfLines = 0;
            imageV.image = [UIImage imageNamed:@"爱丁专业50"];
            label.text = @"爱丁猫专业版";
        }else if ([_typeArr[i] isEqualToString:@"aidingmaomer"]){
            label.width = 50;
            label.height = 40;
            label.left = 10;
            label.top = 55;
            label.numberOfLines = 0;
            imageV.image = [UIImage imageNamed:@"爱丁商家50"];
            label.text = @"爱丁猫商家版";
        }else if ([_typeArr[i] isEqualToString:@"jiuai"]){
            imageV.image = [UIImage imageNamed:@"旧爱50"];
            label.text = @"旧爱";
        }else if ([_typeArr[i] isEqualToString:@"xiaohongshu"]){
            imageV.image = [UIImage imageNamed:@"xhs50"];
            label.text = @"小红书";
        }else if ([_typeArr[i] isEqualToString:@"liequ"]){
            imageV.image = [UIImage imageNamed:@"猎趣50"];
            label.text = @"猎趣";
        }
        
    }
    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.frame = CGRectMake(35, kScreenHeight - 150, kScreenWidth - 70, 48);
    
    tureButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    
    [tureButton setTitle:@"确定更新" forState:UIControlStateNormal];
    
    [tureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    tureButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    tureButton.layer.cornerRadius = 5;
    
    tureButton.layer.masksToBounds = YES;
    
    [tureButton addTarget:self action:@selector(tureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tureButton];
    
    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
//    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];

    

}
//
- (void)buttonAction:(UIButton*)bt{

    
    UIImageView *imageV = [bt viewWithTag:100];
    
    UIImageView *imageV1 = [bt viewWithTag:102];

    UILabel *label = [bt viewWithTag:101];
    
    NSInteger index = bt.tag - 200;

    if (bt.selected) {
    
        if ([_typeArr[index] isEqualToString:@"ponhu"]) {
            imageV.image = [UIImage imageNamed:@"胖虎50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
        }else if ([_typeArr[index] isEqualToString:@"aidingmao"]){
            imageV.image = [UIImage imageNamed:@"爱丁猫50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
        }else if ([_typeArr[index] isEqualToString:@"vdian"]){
            imageV.image = [UIImage imageNamed:@"微店50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
        }
        else if ([_typeArr[index] isEqualToString:@"newshang"]){
            imageV.image = [UIImage imageNamed:@"心上50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
            
        }else if ([_typeArr[index] isEqualToString:@"shopuu"]){
            imageV.image = [UIImage imageNamed:@"少铺50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
            
        }else if ([_typeArr[index] isEqualToString:@"aidingmaopro"]){
            imageV.image = [UIImage imageNamed:@"爱丁猫专业版50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
            
        }else if ([_typeArr[index] isEqualToString:@"aidingmaomer"]){
            imageV.image = [UIImage imageNamed:@"爱丁猫商家版50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
            
        }else if ([_typeArr[index] isEqualToString:@"jiuai"]){
            imageV.image = [UIImage imageNamed:@"旧爱50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
            
        }else if ([_typeArr[index] isEqualToString:@"xiaohongshu"]){
            imageV.image = [UIImage imageNamed:@"小红书50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
        }else if ([_typeArr[index] isEqualToString:@"liequ"]){
            imageV.image = [UIImage imageNamed:@"猎趣50qs@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#333333"];
            imageV1.hidden = YES;
        }



    }else{
    
        if ([_typeArr[index] isEqualToString:@"ponhu"]) {
            imageV.image = [UIImage imageNamed:@"胖虎50@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"aidingmao"]){
            imageV.image = [UIImage imageNamed:@"爱丁猫50@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"vdian"]){
            imageV.image = [UIImage imageNamed:@"微店50@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"newshang"]){
            imageV.image = [UIImage imageNamed:@"心上50@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"shopuu"]){
            imageV.image = [UIImage imageNamed:@"少铺50@2x"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"aidingmaopro"]){
            imageV.image = [UIImage imageNamed:@"爱丁专业50"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"aidingmaomer"]){
            imageV.image = [UIImage imageNamed:@"爱丁商家50"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"jiuai"]){
            imageV.image = [UIImage imageNamed:@"旧爱50"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"xiaohongshu"]){
            imageV.image = [UIImage imageNamed:@"小红书50"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }else if ([_typeArr[index] isEqualToString:@"liequ"]){
            imageV.image = [UIImage imageNamed:@"猎趣50"];
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            imageV1.hidden = NO;
        }

    }
    
    
    bt.selected = !bt.selected;

}

//确定
- (void)tureButtonAction{
    
    BOOL isType = NO;
    
    for (int i = 0 ; i < _typeArr.count; i++) {
        
        UIButton *button = [self.view viewWithTag:200+i];
        
        if (button.selected) {
            
            isType = YES;
            
        }
        
    }
    
    if (!isType) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        [DataSeviece requestUrl:goods_sharehtml params:[_params mutableCopy] success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [defaults removeObjectForKey:@"Text"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataNotification" object:nil];

                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
    }else{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];

    
    [DataSeviece requestUrl:goods_sharehtml params:[_params mutableCopy] success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        _goods_id = result[@"result"][@"data"][@"goods_id"];
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [defaults removeObjectForKey:@"Text"];
            
            for (int i = 0 ; i < _typeArr.count; i++) {
                
                UIButton *button = [self.view viewWithTag:200+i];
                
                if (button.selected) {
                  
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:_typeArr[i] forKey:@"share_platform"];
                    
                    if ([_typeArr[i] isEqualToString:@"ponhu"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isPHRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:101];
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                PHmsg = result[@"result"][@"msg"];
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            
                            isPHRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:101];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            PHmsg = @"服务器异常";
                            
                            [self pushAction];

                        }];
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"aidingmao"]) {
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isADMRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:102];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                ADMmsg = result[@"result"][@"msg"];
                                
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            isADMRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:102];
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            ADMmsg = @"服务器异常";
                            
                            [self pushAction];

                            
                        }];
                        
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"vdian"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isWBRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:103];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                WBmsg = result[@"result"][@"msg"];
                                
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            isWBRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:103];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            WBmsg = @"服务器异常";
                            
                            [self pushAction];

                            
                        }];
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"liequ"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isLPHRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:104];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                LPHmsg = result[@"result"][@"msg"];
                                
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            isLPHRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:104];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            LPHmsg = @"服务器异常";
                            
                            [self pushAction];

                        }];
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"newshang"]) {
                        
                        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                        
                        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                        
                        [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                        
                        [params1 setObject:@"newshang" forKey:@"share_platform"];
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isXSRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:105];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                XSmsg = result[@"result"][@"msg"];
                                
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            isXSRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:105];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            XSmsg = @"服务器异常";
                            
                            [self pushAction];

                        }];
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"shopuu"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isSPRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:106];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                                
                            }else{
                                
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                SPmsg = result[@"result"][@"msg"];
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            
                            isSPRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:106];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            SPmsg = @"服务器异常";
                            
                            [self pushAction];
                            
                        }];
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"xiaohongshu"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isZDRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:107];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                ZDmsg = result[@"result"][@"msg"];
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            
                            isZDRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:107];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            ZDmsg = @"服务器异常";
                            
                            [self pushAction];
                            
                        }];
                    }

                    if ([_typeArr[i] isEqualToString:@"aidingmaopro"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isADMZYRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:108];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                ADMZYmsg = result[@"result"][@"msg"];
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            
                            isADMZYRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:108];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            ADMZYmsg = @"服务器异常";
                            
                            [self pushAction];
                            
                        }];
                        
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"aidingmaomer"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isADMSJRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:109];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                ADMSJmsg = result[@"result"][@"msg"];
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            
                            isADMSJRotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:109];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            ADMSJmsg = @"服务器异常";
                            
                            [self pushAction];
                            
                        }];
                        
                    }
                    
                    if ([_typeArr[i] isEqualToString:@"jiuai"]) {
                        
                        
                        [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                            
                            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                            
                            isJARotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:110];
                            
                            
                            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                                imageV.image = [UIImage imageNamed:@"rt@2x"];
                            }else{
                                imageV.image = [UIImage imageNamed:@"wr@2x"];
                                JAmsg = result[@"result"][@"msg"];
                            }
                            
                            [self pushAction];
                            
                        } failure:^(NSError *error) {
                            
                            NSLog(@"%@",error);
                            
                            isJARotate = YES;
                            
                            UIImageView *imageV = [feedBackV viewWithTag:110];
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            
                            JAmsg = @"服务器异常";
                            
                            [self pushAction];
                            
                        }];
                        
                    }
                    
                    
                    
                    
                    }
                
                
                
            }
            
            bgView.hidden = NO;
            feedBackV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 145, kScreenHeight/2 - 70, 290, 140)];
            feedBackV.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
            feedBackV.layer.cornerRadius = 3;
            feedBackV.layer.masksToBounds = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:feedBackV];
            
            BOOL isPH = NO;
            BOOL isADM = NO;
            BOOL isWD = NO;
            BOOL isLPH = NO;
            BOOL isXS = NO;
            BOOL isSP = NO;
            BOOL isZD = NO;
            BOOL isADMZY = NO;
            BOOL isADMSJ = NO;
            BOOL isJA = NO;





            for (int i = 0; i < _typeArr.count; i++) {
                
                UIButton *button = [self.view viewWithTag:200+i];

                if ([_typeArr[i] isEqualToString:@"ponhu"]) {
                    
                    if (button.selected) {
                        isPH = YES;
                    }
                    
                }else if ([_typeArr[i] isEqualToString:@"aidingmao"]){
                    if (button.selected) {
                        isADM = YES;
                    }

                }else if ([_typeArr[i] isEqualToString:@"vdian"]){
                    if (button.selected) {
                        isWD = YES;
                    }

                }else if ([_typeArr[i] isEqualToString:@"liequ"]){
                    if (button.selected) {
                        isLPH = YES;
                    }

                }else if ([_typeArr[i] isEqualToString:@"newshang"]){
                    if (button.selected) {
                        isXS = YES;
                    }
                }else if ([_typeArr[i] isEqualToString:@"shopuu"]){
                    if (button.selected) {
                        isSP = YES;
                    }
                }else if ([_typeArr[i] isEqualToString:@"xiaohongshu"]){
                    if (button.selected) {
                        isZD = YES;
                    }
                }else if ([_typeArr[i] isEqualToString:@"aidingmaopro"]){
                    if (button.selected) {
                        isADMZY = YES;
                    }
                }else if ([_typeArr[i] isEqualToString:@"aidingmaomer"]){
                    if (button.selected) {
                        isADMSJ = YES;
                    }
                }else if ([_typeArr[i] isEqualToString:@"jiuai"]){
                    if (button.selected) {
                        isJA = YES;
                    }
                }

            }

            UILabel *PHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            
            [feedBackV addSubview:PHLabel];

            
            if (isPH) {
                
                PHLabel.top = 17;
                PHLabel.left = 20;
                PHLabel.width = 60;
                PHLabel.height = 20;
                PHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                PHLabel.font = [UIFont systemFontOfSize:18];
                PHLabel.text = @"胖虎";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, PHLabel.top, 20, 20)];
                
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                imageV.tag = 101;
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
                
            }
            
            UILabel *ADMLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, PHLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:ADMLabel];
            
            if (isADM) {
                
                ADMLabel.top = PHLabel.bottom+30;
                ADMLabel.left = 20;
                ADMLabel.width = 60;
                ADMLabel.height = 20;
                ADMLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                ADMLabel.font = [UIFont systemFontOfSize:18];
                ADMLabel.text = @"爱丁猫";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ADMLabel.top, 20, 20)];
                imageV.tag = 102;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *WBLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ADMLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:WBLabel];
            
            
            if (isWD) {
                
                WBLabel.top = ADMLabel.bottom+30;
                WBLabel.left = 20;
                WBLabel.width = 60;
                WBLabel.height = 20;
                WBLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                WBLabel.font = [UIFont systemFontOfSize:18];
                WBLabel.text = @"微店";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, WBLabel.top, 20, 20)];
                imageV.tag = 103;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *LPHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WBLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:LPHLabel];
            
            
            if (isLPH) {
                
                LPHLabel.top = WBLabel.bottom+30;
                LPHLabel.left = 20;
                LPHLabel.width = 60;
                LPHLabel.height = 20;
                LPHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                LPHLabel.font = [UIFont systemFontOfSize:18];
                LPHLabel.text = @"猎趣";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, LPHLabel.top, 20, 20)];
                imageV.tag = 104;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *XSLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, LPHLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:XSLabel];
            
            
            if (isXS) {
                
                XSLabel.top = LPHLabel.bottom+30;
                XSLabel.left = 20;
                XSLabel.width = 60;
                XSLabel.height = 20;
                XSLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                XSLabel.font = [UIFont systemFontOfSize:18];
                XSLabel.text = @"心上";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, XSLabel.top, 20, 20)];
                imageV.tag = 105;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            
            UILabel *SPLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, XSLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:SPLabel];
            
            if (isSP) {
                
                SPLabel.top = XSLabel.bottom+30;
                SPLabel.left = 20;
                SPLabel.width = 60;
                SPLabel.height = 20;
                SPLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                SPLabel.font = [UIFont systemFontOfSize:18];
                SPLabel.text = @"少铺";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, SPLabel.top, 20, 20)];
                imageV.tag = 106;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *ZDLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SPLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:ZDLabel];
            
            
            if (isZD) {
                
                ZDLabel.top = SPLabel.bottom+30;
                ZDLabel.left = 20;
                ZDLabel.width = 60;
                ZDLabel.height = 20;
                ZDLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                ZDLabel.font = [UIFont systemFontOfSize:18];
                ZDLabel.text = @"小红书";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ZDLabel.top, 20, 20)];
                imageV.tag = 107;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *ADMZYLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZDLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:ADMZYLabel];
            
            
            if (isADMZY) {
                
                ADMZYLabel.top = ZDLabel.bottom+30;
                ADMZYLabel.left = 20;
                ADMZYLabel.width = 150;
                ADMZYLabel.height = 20;
                ADMZYLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                ADMZYLabel.font = [UIFont systemFontOfSize:18];
                ADMZYLabel.text = @"爱丁猫专业版";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ADMZYLabel.top, 20, 20)];
                imageV.tag = 108;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *ADMSJLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ADMZYLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:ADMSJLabel];
            
            
            if (isADMSJ) {
                
                ADMSJLabel.top = ADMZYLabel.bottom+30;
                ADMSJLabel.left = 20;
                ADMSJLabel.width = 150;
                ADMSJLabel.height = 20;
                ADMSJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                ADMSJLabel.font = [UIFont systemFontOfSize:18];
                ADMSJLabel.text = @"爱丁猫商家版";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ADMSJLabel.top, 20, 20)];
                imageV.tag = 109;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *JALabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ADMSJLabel.bottom, 0, 0)];
            
            [feedBackV addSubview:JALabel];
            
            
            if (isJA) {
                
                JALabel.top = ADMSJLabel.bottom+30;
                JALabel.left = 20;
                JALabel.width = 150;
                JALabel.height = 20;
                JALabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                JALabel.font = [UIFont systemFontOfSize:18];
                JALabel.text = @"旧爱";
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, JALabel.top, 20, 20)];
                imageV.tag = 110;
                imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                
                [feedBackV addSubview:imageV];
                
                [self startAnimation:imageV];
            }
            
            UILabel *KKHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, JALabel.bottom, 0, 0)];
            
            [feedBackV addSubview:KKHLabel];
            
            
            
            feedBackV.height = KKHLabel.bottom +20;
            
            feedBackV.top = (kScreenHeight - feedBackV.height)/2;
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

    }

}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"选择平台更新";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
}

- (void)pushAction{
    
    BOOL isph;
    BOOL isadm;
    BOOL iswb;
    BOOL islph;
    BOOL isxs;
    BOOL issp;
    BOOL iszd;
    BOOL isadmzy;
    BOOL isadmsj;
    BOOL isja;


    
    
    NSMutableArray *arr = [NSMutableArray array];
    
    UIImageView *imageV1 = [feedBackV viewWithTag:101];
    UIImageView *imageV2 = [feedBackV viewWithTag:102];
    UIImageView *imageV3 = [feedBackV viewWithTag:103];
    UIImageView *imageV4 = [feedBackV viewWithTag:104];
    UIImageView *imageV5 = [feedBackV viewWithTag:105];
    UIImageView *imageV6 = [feedBackV viewWithTag:106];
    UIImageView *imageV7 = [feedBackV viewWithTag:107];
    UIImageView *imageV8 = [feedBackV viewWithTag:108];
    UIImageView *imageV9 = [feedBackV viewWithTag:109];
    UIImageView *imageV10 = [feedBackV viewWithTag:110];


    BOOL isPH = NO;
    BOOL isADM = NO;
    BOOL isWD = NO;
    BOOL isLPH = NO;
    BOOL isXS = NO;
    BOOL isSP = NO;
    BOOL isZD = NO;
    BOOL isADMZY = NO;
    BOOL isADMSJ = NO;
    BOOL isJA = NO;

    
    for (int i = 0; i < _typeArr.count; i++) {
        
        UIButton *button = [self.view viewWithTag:200+i];
        
        if ([_typeArr[i] isEqualToString:@"ponhu"]) {
            
            if (button.selected) {
                isPH = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"aidingmao"]){
            
            if (button.selected) {
                
                isADM = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"vdian"]){
            if (button.selected) {
                isWD = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"liequ"]){
            
            if (button.selected) {
                isLPH = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"newshang"]){
            if (button.selected) {
                isXS = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"shopuu"]){
            if (button.selected) {
                isSP = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"xiaohongshu"]){
            if (button.selected) {
                isZD = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"aidingmaopro"]){
            if (button.selected) {
                isADMZY = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"aidingmaomer"]){
            if (button.selected) {
                isADMSJ = YES;
            }
            
        }else if ([_typeArr[i] isEqualToString:@"jiuai"]){
            if (button.selected) {
                isJA = YES;
            }
            
        }

    }
    
    
    if (isPH) {
        
        isph = isPHRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"胖虎50@2x" forKey:@"img"];
        
        if ([imageV1.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:PHmsg forKey:@"msg"];
        }
        [arr addObject:dic];
    }else{
        isph = YES;
    }
    
    if (isADM) {
        
        isadm = isADMRotate;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"爱丁猫50@2x" forKey:@"img"];
        
        if ([imageV2.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            
            [dic setObject:@"1" forKey:@"isSuccess"];
            
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ADMmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isadm = YES;
    }
    
    if (isWD) {
        iswb = isWBRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"微店34x34@2x" forKey:@"img"];
        if ([imageV3.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:WBmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        iswb = YES;
    }
    
    if (isLPH) {
        islph = isLPHRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"猎趣34" forKey:@"img"];
        if ([imageV4.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:LPHmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        islph = YES;
    }
    
    if (isXS) {
        
        isxs = isXSRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"心上34@2x" forKey:@"img"];
        if ([imageV5.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:XSmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isxs = YES;
    }
    
    if (isSP) {
        
        issp = isSPRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"少铺34@2x" forKey:@"img"];
        
        if ([imageV6.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            
            [dic setObject:@"1" forKey:@"isSuccess"];
            
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:SPmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        issp = YES;
    }

    if (isZD) {
        
        iszd = isZDRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"xhs34" forKey:@"img"];
        if ([imageV7.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ZDmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        iszd = YES;
    }
    
    if (isADMZY) {
        
        isadmzy = isADMZYRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"爱丁专业34@2x" forKey:@"img"];
        if ([imageV8.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ADMZYmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isadmzy = YES;
    }
    
    if (isADMSJ) {
        
        isadmsj = isADMSJRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"爱丁商家34@2x" forKey:@"img"];
        if ([imageV9.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ADMSJmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isadmsj = YES;
    }
    
    if (isJA) {
        
        isja = isJARotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"jiuai34@2x" forKey:@"img"];
        if ([imageV10.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:JAmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isja = YES;
    }
    
    

    
    
    if (isph&&isadm&&iswb&&islph&&isxs&&issp&&iszd&&isadmzy&&isadmsj&&isja) {
        
        bgView.hidden = YES;
        feedBackV.hidden = YES;
        
        ReleaseCompleteViewController *ReleaseCompleteVC = [[ReleaseCompleteViewController alloc]init];
        NSLog(@"%@",arr);
        ReleaseCompleteVC.arr = [arr copy];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:_params];
//
//        [params setObject:_titleTextField.text forKey:@"goods_name"];
//        
//        [params setObject:_brandId forKey:@"brand_id"];
//        
//        [params setObject:_sortId forKey:@"category_id"];
//        
//        [params setObject:_expectedId forKey:@"expected_delivery_type"];
//        
//        [params setObject:_describeTextView.text forKey:@"goods_description"];
//        
//        [params setObject:_gradeId forKey:@"grade"];
//        
//        [params setObject:_priceTextField.text forKey:@"price"];
//        
//        [params setObject:_publicPriceTextField.text forKey:@"market_price"];
//        
//        [params setObject:_imageStrArr forKey:@"img"];
//
        
        [params setObject:_imageArr forKey:@"imageArr"];
        
        ReleaseCompleteVC.dataDic = params;
        
        ReleaseCompleteVC.isUpData = YES;
        
        ReleaseCompleteVC.goods_id = _goods_id;
        
        [self.navigationController pushViewController:ReleaseCompleteVC animated:YES];
        
    }
    
    
}
- (void)startAnimation:(UIImageView*)imageV
{
    
    if (imageV.tag == 101) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle1 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            if (!isPHRotate) {
                angle1 += 10; [self startAnimation:imageV];
            }else{
                
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    
    if (imageV.tag == 102) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle2 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isADMRotate) {
                angle2 += 10; [self startAnimation:imageV];
            }else{
                
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
        
    }
    
    if (imageV.tag == 103) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle3 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isWBRotate) {
                angle3 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    
    if (imageV.tag == 104) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle4 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isLPHRotate) {
                angle4 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    
    if (imageV.tag == 105) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle5 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isXSRotate) {
                angle5 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    
    if (imageV.tag == 106) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle6 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isSPRotate) {
                angle6 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }

    if (imageV.tag == 107) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle7 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isZDRotate) {
                angle7 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }

    if (imageV.tag == 108) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle8 * (M_PI / 180.0f));

        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isADMZYRotate) {
                angle8 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    if (imageV.tag == 109) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle9 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isADMSJRotate) {
                angle9 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    
    if (imageV.tag == 110) {
        
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle10 * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            imageV.transform = endAngle;
        } completion:^(BOOL finished) {
            
            if (!isJARotate) {
                angle10 += 10; [self startAnimation:imageV];
            }else{
                imageV.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
    
    
}

- (void)editAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [DataSeviece requestUrl:goods_sharehtml params:[_params mutableCopy] success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [defaults removeObjectForKey:@"Text"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataNotification" object:nil];

            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (void)leftBtnAction{
    

    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
