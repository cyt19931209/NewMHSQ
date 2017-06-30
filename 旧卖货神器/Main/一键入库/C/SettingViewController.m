//
//  SettingViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "PlatformAccountViewController.h"
#import "RepertoryPublishViewController.h"
#import "ReleaseHistoryViewController.h"
#import "FinanceViewController.h"
#import "MD5CommonDigest.h"
#import "PersonalSettingsViewController.h"
#import "UIButton+WebCache.h"
#import "MyPartnerViewController.h"
#import "ZLPhoto.h"
#import "AFNetworking.h"

@interface SettingViewController ()<UINavigationControllerDelegate,ZLPhotoPickerViewControllerDelegate>{

    UIAlertView *alertV1;
    
    UIAlertView *alertV2;
    
    UIView *bgView;
    
    UIView *codeView;

    UIImageView *QGView;

}

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *FocusOnButton;
@property (weak, nonatomic) IBOutlet UIButton *OnFocusButton;

@property (weak, nonatomic) IBOutlet UISwitch *isSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *isTopSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *isDLJGSwitch;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self loadData];
    
    _iconButton.layer.cornerRadius = 28;
    
    _iconButton.layer.masksToBounds = YES;
    
    _iconButton.layer.borderWidth = 3;
    
    _iconButton.layer.borderColor = [RGBColor colorWithHexString:@"ffffff"].CGColor;
    
    _iconButton.backgroundColor = [RGBColor colorWithHexString:@"d8d8d8"];
    
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

    
    codeView = [[UIView alloc]initWithFrame:CGRectMake(37.5, kScreenHeight/2 - 175, kScreenWidth - 75, 350)];
    
    codeView.backgroundColor = [RGBColor colorWithHexString:@"ffffff"];
    
    codeView.hidden = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:codeView];
    
    QGView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, codeView.width - 30, 270)];
    
    QGView.backgroundColor = [RGBColor colorWithHexString:@"d8d8d8"];
    
    [codeView addSubview:QGView];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 300, codeView.width, 16);
    label.text = @"扫一扫，随时关注我的货源";
    label.font = [UIFont fontWithName:@".PingFangSC-Regular" size:16];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    label.textAlignment = NSTextAlignmentCenter;
    
    [codeView addSubview:label];

    
    
//    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"123" attributes:attribtDic];
//    
//    //设置下划线颜色...
//    [attribtStr addAttribute:NSForegroundColorAttributeName value:[RGBColor colorWithHexString:@"F5554A"]  range:NSMakeRange(0,[attribtStr length])];
//
//    [attribtStr addAttribute:NSUnderlineColorAttributeName value:[RGBColor colorWithHexString:@"F5554A"] range:(NSRange){0,[attribtStr length]}];
//    [_FocusOnButton setAttributedTitle:attribtStr forState:UIControlStateNormal];
//    
//
    
}


//隐藏视图
- (void)bgButtonAction{
    
    bgView.hidden = YES;
 
    codeView.hidden = YES;

}
- (void)loadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:change_user_privilegehtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"data"][@"status"] isEqualToString:@"enable"]) {
            
            [_isSwitch setOn:YES];
            
        }else{
            
            [_isSwitch setOn:NO];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    [DataSeviece requestUrl:get_shop_settinghtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {
            
            if ([result[@"result"][@"data"][@"show_agency_price"] integerValue] == 1) {
                
                [_isDLJGSwitch setOn:YES];
                
            }else{
                
                [_isDLJGSwitch setOn:NO];
                
            }
            
            if ([result[@"result"][@"data"][@"stick_after_publish"] integerValue] == 1) {
                
                [_isTopSwitch setOn:YES];
                
            }else{
                
                [_isTopSwitch setOn:NO];
                
            }

        }
        else{
        
            [_isDLJGSwitch setOn:NO];
            
            [_isTopSwitch setOn:NO];


        }
     
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
}
//二维码
- (IBAction)QrCodeAction:(id)sender {
    
    bgView.hidden = NO;
    
    codeView.hidden = NO;
    
}

//返回
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row == 5) {
        
        ReleaseHistoryViewController *ReleaseHistoryVC = [[ReleaseHistoryViewController alloc]init];
        
        
        ReleaseHistoryVC.hidesBottomBarWhenPushed = YES;
        ReleaseHistoryVC.is_delete = @"1";

        [self.navigationController pushViewController:ReleaseHistoryVC animated:YES];
        
    }else if (indexPath.row == 3){
    
        //绑定平台账号
        PlatformAccountViewController *storageVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"PlatformAccountViewController"];
        
        storageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storageVC animated:YES];
        
    }else if (indexPath.row == 4){
        
        
        
        //人员管理
        FinanceViewController *financeVC = [[FinanceViewController alloc]init];
        
        financeVC.isPersonnel = YES;
        
        financeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:financeVC animated:YES];
        

    }else if (indexPath.row == 11){
            
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults removeObjectForKey:@"SYGData"];
        
        [defaults removeObjectForKey:@"Text"];
        
        [defaults synchronize];

    }else if (indexPath.row == 2){
    
        PersonalSettingsViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"PersonalSettingsViewController"];
  
        OneButtonPublishingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
        
        
    }else if (indexPath.row == 0){
    
        MyPartnerViewController *myPartnerVC = [[MyPartnerViewController alloc]init];
        
        myPartnerVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:myPartnerVC animated:YES];
        
    
    }
    
}

//加载数据
- (void)loaData1{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_shop_infohtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
//        self.navigationItem.title = [NSString stringWithFormat:@"%@:%@",result[@"result"][@"data"][@"shopinfo"][@"shop_name"],result[@"result"][@"data"][@"shopinfo"][@"mobile"]];
        
        [_iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:result[@"result"][@"data"][@"logo_url"]] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"mrtx1"]];

        _nameLabel.text = result[@"result"][@"data"][@"shop_name"];
        
        [_FocusOnButton setTitle:result[@"result"][@"data"][@"me_follow_nums"] forState:UIControlStateNormal];
        
        [_OnFocusButton setTitle:result[@"result"][@"data"][@"follow_me_nums"] forState:UIControlStateNormal];

        [QGView sd_setImageWithURL:[NSURL URLWithString:result[@"result"][@"data"][@"qrcode_url"]]];
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loaData1];
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.delegate = self;

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    
//    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
//       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
//    
//    [self.navigationController.navigationBar setShadowImage:nil];
//    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
//    
//    [_iconButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgUrl,SYGData[@"shopinfo"][@"logo"]]] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"mrtx1"]];

}

- (IBAction)switchAction:(UISwitch *)sender {
    
    
    alertV1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alertV1.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    [alertV1 show];
    
}

- (IBAction)isTopAction:(UISwitch*)sender {
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    if (!_isTopSwitch.isOn) {
        
        [params setObject:@"2" forKey:@"stick_after_publish"];
        
    }else{
        
        [params setObject:@"1" forKey:@"stick_after_publish"];
        
    }
    
    [DataSeviece requestUrl:settinghtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] integerValue] == 1) {
            

        }else{
            
            [_isTopSwitch setOn:!_isTopSwitch.isOn];
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message: result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];

        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
 

}

- (IBAction)isDLJGAction:(id)sender {
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSString *url;
    
    url = settinghtml;
    
    if (!_isDLJGSwitch.isOn) {
        
        [params setObject:@"2" forKey:@"show_agency_price"];
        
    }else{
        
        [params setObject:@"1" forKey:@"show_agency_price"];
        
    }
    
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        
        if ([result[@"result"][@"code"] integerValue] == 1) {
            
            
        }else{
            
            [_isDLJGSwitch setOn:!_isDLJGSwitch.isOn];
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message: result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    UITextField *tf = [alertView textFieldAtIndex:0];
    
    [MD5CommonDigest MD5:tf.text success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result isEqualToString:@"1"]) {
            

            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:SYGData[@"id"] forKey:@"uid"];
            
            NSString *url;
            
            if (alertView == alertV1) {
                [params setObject:@"edit_goods" forKey:@"privilege"];
                
                if (!_isSwitch.isOn) {
                    
                    [params setObject:@"disenable" forKey:@"type"];
                    
                }else{
                    
                    [params setObject:@"enable" forKey:@"type"];
                    
                }
                
                url = change_user_privilegehtml;
                
            }else if (alertView == alertV2){

                url = settinghtml;
                
                if (!_isDLJGSwitch.isOn) {
                    
                    [params setObject:@"2" forKey:@"show_agency_price"];
                    
                }else{
                    
                    [params setObject:@"1" forKey:@"show_agency_price"];
                    
                }

            }
            
            [DataSeviece requestUrl:url params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
                if ([result[@"result"][@"code"] integerValue] == 1) {
                    
                    
                }else{
                    
                    [_isSwitch setOn:!_isSwitch.isOn];

                    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message: result[@"result"][@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertV show];

                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
            
        }else{
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
            if (alertView == alertV1) {
                [_isSwitch setOn:!_isSwitch.isOn];

            }else if (alertView == alertV2){
                [_isDLJGSwitch setOn:!_isDLJGSwitch.isOn];

            }
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];

    if (indexPath.row == 0) {
        return 98;
    }else if (indexPath.row == 1){
        return 10;
    }else if (indexPath.row == 2){
        return 44;
    }else if (indexPath.row == 3){
        return 44;
    }else if (indexPath.row == 4){
        return 44;
    }else if (indexPath.row == 5){
        return 44;
    }else if (indexPath.row == 6){
        return 10;
    }else if (indexPath.row == 7){
        if ([SYGData[@"type"] isEqualToString:@"2"]) {
            return 44;

        }else{
            return 0;
        }
        
    }else if (indexPath.row == 8){
        
        if ([SYGData[@"type"] isEqualToString:@"2"]) {
            return 44;
            
        }else{
            
            return 0;
        }
    }else if (indexPath.row == 9){
        
        if ([SYGData[@"type"] isEqualToString:@"2"]) {
            return 44;
            
        }else{
            return 0;
        }
        
    }else if (indexPath.row == 10){
        
        return 10;

    }else if (indexPath.row == 11){
        return 44;
    }
    
    return 0;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:NO];
    
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
//
- (IBAction)iconAction:(id)sender {
    
    
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    // 最多能选9张图片
    
    pickerVc.isShowCamera = YES;
    
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.delegate = self;
    pickerVc.maxCount = 1;
    
    [pickerVc showPickerVc:self];

    
    
}

#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    
    NSMutableArray *imageArr1 = [NSMutableArray array];
    
    for (NSInteger i = 0; i < assets.count ; i++) {
        //
        if ([assets[i] isKindOfClass:[ZLPhotoAssets class]]) {
            ZLPhotoAssets *asset = assets[i];
            
            [imageArr1 addObject:asset.originImage];
            
        }else{
            
            [imageArr1 addObject:[self rotateImage:assets[i]]];
            
        }
        
        
        
//        [_iconButton setBackgroundImage:imageArr1[0] forState:UIControlStateNormal];
        

        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:result[@"result"][@"data"][@"qiniu_token"] forKey:@"token"];
            
            [params setObject:SYGData[@"shop_id"] forKey:@"x:shop_id"];
            
            AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
            
            [manager POST:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                NSData *imgData = UIImageJPEGRepresentation(imageArr1[i], 1);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"%@",responseObject);
                
                NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                
                [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                
                NSString *url = @"";
                
                url = edit_shop_infohtml;
                
                [params1 setObject:responseObject[@"result"][@"data"][@"file_name"] forKey:@"logo"];
                
                [DataSeviece requestUrl:url params:params1 success:^(id result) {
                    NSLog(@"%@",result);
                    
                    if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                        
                        if ([url isEqualToString:edit_shop_infohtml]) {
                            
                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:SYGData];
                            
                            NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:SYGData[@"shopinfo"]];
                            
                            [dic1 setObject:responseObject[@"result"][@"data"][@"file_name"] forKey:@"logo"];
                            
                            [_iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl,responseObject[@"result"][@"data"][@"file_name"]]] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"mrtx1"]];
                            
                            [dic setObject:[dic1 copy] forKey:@"shopinfo"];
                            
                            [defaults setObject:[dic copy] forKey:@"SYGData"];
                            
                            [defaults synchronize];
                            
                        }
                        
                        alertV.message = @"修改成功";
                        [alertV show];
                    }else{
                        alertV.message = result[@"result"][@"msg"];
                        [alertV show];
                    }
                    
                } failure:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
        
    }
    
}

- (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}


@end
