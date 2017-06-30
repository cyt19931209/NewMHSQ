//
//  PersonalSettingsViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/6.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "PersonalSettingsViewController.h"
#import "ZLPhoto.h"
#import "AFNetworking.h"
#import "ChangePasswordViewController.h"


@interface PersonalSettingsViewController ()<UINavigationControllerDelegate,ZLPhotoPickerViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{

    UIPickerView *_mPickerView;
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *allName;
    
    UIView *_adressV;
    
    NSArray *jsonDataArr;

    NSString *typeStr;
    

}

@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,strong) UIView *barImageView;

@end

@implementation PersonalSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    _barImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    _barImageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_barImageView];

    
    UIView *bgBarV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    bgBarV.backgroundColor = [UIColor whiteColor];
    
    bgBarV.alpha = 0;
    
    bgBarV.tag = 100;
    
    [_barImageView addSubview:bgBarV];
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(13, 36, 20, 20);
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"bcw"] forState:UIControlStateNormal];
    leftButton.tag = 101;
    
    [leftButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_barImageView addSubview:leftButton];

    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 380.0/720.0*kScreenWidth);
    
    [self loadData];

    
    _logoImageV.layer.cornerRadius = 41;
    
    _logoImageV.layer.masksToBounds = YES;

    _logoButton.layer.borderWidth = 3;
    
    _logoButton.layer.cornerRadius = 44;
    
    _logoButton.layer.masksToBounds = YES;

    _logoButton.layer.borderColor = [UIColor colorWithWhite:255 alpha:.4].CGColor;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _nameTextField.userInteractionEnabled = NO;
    
    _nameTextField.delegate = self;
    
    _addressTextField.delegate = self;
    
    _WXHTextField.delegate = self;
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.tableView addGestureRecognizer:singleRecognizer];
    
    _nameTextField.returnKeyType = UIReturnKeySend;
    
    _addressTextField.returnKeyType = UIReturnKeySend;
    
    _WXHTextField.returnKeyType = UIReturnKeySend;

    
    //    地区选择器
    _adressV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
    
    _adressV.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    _adressV.hidden = YES;
    [self.view addSubview:_adressV];
    
    _mPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 300)];
    _mPickerView.delegate = self;
    _mPickerView.dataSource = self;
    [_adressV addSubview:_mPickerView];
    
    UIButton *trueButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    trueButton1.frame = CGRectMake(kScreenWidth-50, 0, 40, 40);
    [trueButton1 addTarget:self action:@selector(trueAction1) forControlEvents:UIControlEventTouchUpInside];
    [trueButton1 setTitle:@"确定" forState:UIControlStateNormal];
    [_adressV addSubview:trueButton1];
    UIButton *cancelButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton1.frame = CGRectMake(10, 0, 40, 40);
    [cancelButton1 setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton1 addTarget:self action:@selector(cancelAction1) forControlEvents:UIControlEventTouchUpInside];
    [_adressV addSubview:cancelButton1];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    jsonDataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    provinceArr = jsonDataArr;
    
    cityArr = jsonDataArr[0][@"city"];
    
    districtArr = jsonDataArr[0][@"city"][0][@"area"];
    
    allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:0] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];

}

- (void)trueAction1{
    
    _adressV.hidden = YES;
    _addressLabel.text = allName;
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:provinceArr[provinceIndex][@"id"] forKey:@"province"];
    [params setObject:cityArr[cityIndex][@"id"] forKey:@"city"];
    [params setObject:districtArr[districtIndex][@"id"] forKey:@"area"];
    
    NSString *url = @"";
    
    if ([typeStr isEqualToString:@"2"]) {
        url = edit_shop_infohtml;
    }else{
    
        url = edit_userhtml;
        
        [params setObject:typeStr forKey:@"type"];

    }

    [DataSeviece requestUrl:url params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            alertV.message = @"修改成功";
            [alertV show];
            
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)cancelAction1{
    
    _adressV.hidden = YES;
    
}


- (void)singleAction{

    [_nameTextField resignFirstResponder];
    
    [_addressTextField resignFirstResponder];
    
    [_WXHTextField resignFirstResponder];

}

//详细信息
- (void)loadData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_userinfohtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        _dataDic = result[@"result"][@"data"];
        
        typeStr = result[@"result"][@"data"][@"type"];
        
        if ([result[@"result"][@"data"][@"type"] isEqualToString:@"2"]) {
            
            [_logoImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl,result[@"result"][@"data"][@"shopinfo"][@"logo"]]] placeholderImage:[UIImage imageNamed:@"mrtx"]];
            
            _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",result[@"result"][@"data"][@"shopinfo"][@"province_name"],result[@"result"][@"data"][@"shopinfo"][@"city_name"],result[@"result"][@"data"][@"shopinfo"][@"area_name"]];
            
            _addressTextField.text = result[@"result"][@"data"][@"shopinfo"][@"address"];
            
            _WXHTextField.text = result[@"result"][@"data"][@"shopinfo"][@"wechat"];

            _nameTextField.text = result[@"result"][@"data"][@"shopinfo"][@"shop_name"];
            
        }else{
            
            [_logoImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",result[@"result"][@"data"][@"headimg"]]] placeholderImage:[UIImage imageNamed:@"mrtx"]];
            
            _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",result[@"result"][@"data"][@"province_name"],result[@"result"][@"data"][@"city_name"],result[@"result"][@"data"][@"area_name"]];
            
            _addressTextField.text = result[@"result"][@"data"][@"address"];
            
            _WXHTextField.text = result[@"result"][@"data"][@"wechat"];

            _nameTextField.text = result[@"result"][@"data"][@"user_name"];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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

- (void)leftBtnAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSString *url = @"";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    if ([_dataDic[@"type"] isEqualToString:@"2"]) {

        if (![_addressTextField.text isEqualToString:_dataDic[@"shopinfo"][@"address"]]) {
            
            url = edit_shop_infohtml;
            
            [params setObject:_addressTextField.text forKey:@"address"];
            
            [DataSeviece requestUrl:url params:params success:^(id result) {
                NSLog(@"%@",result);
                
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

            
        }

        if (![_WXHTextField.text isEqualToString:_dataDic[@"shopinfo"][@"wechat"]]) {
            
            
            url = edit_shop_infohtml;

            [params setObject:_WXHTextField.text forKey:@"wechat"];
            
            [DataSeviece requestUrl:url params:params success:^(id result) {
                NSLog(@"%@",result);
                
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

            
        }
        
        if (![_nameTextField.text isEqualToString:_dataDic[@"shopinfo"][@"shop_name"]]) {
            
            url = edit_shop_infohtml;
            
            [params setObject:_nameTextField.text forKey:@"shop_name"];
            
            [DataSeviece requestUrl:url params:params success:^(id result) {
                
                NSLog(@"%@",result);
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
        
        
    }else{
        
        if (![_addressTextField.text isEqualToString:_dataDic[@"address"]]) {
            
            url = edit_userhtml;
            
            [params setObject:typeStr forKey:@"type"];
            [params setObject:_addressTextField.text forKey:@"address"];

            [DataSeviece requestUrl:url params:params success:^(id result) {
                NSLog(@"%@",result);
                
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

        }
        
        if (![_WXHTextField.text isEqualToString:_dataDic[@"wechat"]]) {
            
            url = edit_userhtml;
            
            [params setObject:typeStr forKey:@"type"];
            
            [params setObject:_WXHTextField.text forKey:@"wechat"];

            
            [DataSeviece requestUrl:url params:params success:^(id result) {
                NSLog(@"%@",result);
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

        }
        
        if (![_nameTextField.text isEqualToString:_dataDic[@"user_name"]]) {
            
            url = edit_userhtml;
            
            [params setObject:typeStr forKey:@"type"];
            
            [params setObject:_nameTextField.text forKey:@"user_name"];

            [DataSeviece requestUrl:url params:params success:^(id result) {
                
                NSLog(@"%@",result);

                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
 
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}

- (IBAction)editName:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    
    if (sender.selected) {
        
        _nameTextField.userInteractionEnabled = YES;
        
        
        [_nameTextField becomeFirstResponder];
 
    }else{
    
        _nameTextField.userInteractionEnabled = NO;
        
        [_nameTextField resignFirstResponder];
        
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
}
- (IBAction)logoAction:(id)sender {
    
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
        
        _logoImageV.image = imageArr1[0];
        
        
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

            if ([typeStr isEqualToString:@"2"]) {
                
                url = edit_shop_infohtml;
                
                [params1 setObject:responseObject[@"result"][@"data"][@"file_name"] forKey:@"logo"];
            }else{
                
                url = edit_userhtml;
                
                [params1 setObject:typeStr forKey:@"type"];
                
                [params setObject:responseObject[@"result"][@"data"][@"file_name"] forKey:@"headimg"];
                
            }
            
            [DataSeviece requestUrl:url params:params1 success:^(id result) {
                NSLog(@"%@",result);
                
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    
                    if ([url isEqualToString:edit_shop_infohtml]) {
                        
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:SYGData];
                        
                        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:SYGData[@"shopinfo"]];
                        
                        [dic1 setObject:responseObject[@"result"][@"data"][@"file_name"] forKey:@"logo"];

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

#pragma mark - UIPickerViewDataSource||UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger row = 0;
    switch (component)
    {
        case 0:
            row = [provinceArr count];
            break;
        case 1:
            row = [cityArr count];
            break;
        case 2:
            row = [districtArr count];
            break;
        default:
            break;
    }
    return row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    id item;
    switch (component)
    {
        case 0:
            item = [provinceArr objectAtIndex:row];
            provinceIndex = row;
            break;
        case 1:
            item = [cityArr objectAtIndex:row];
            cityIndex = row;
            break;
        case 2:
            item = [districtArr objectAtIndex:row];
            districtIndex = row;
            break;
        default:
            break;
    }
    
    if (item)
    {
        title = [item objectForKey:@"name"];
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component)
    {
        
        cityArr = jsonDataArr[row][@"city"];
        
        districtArr = jsonDataArr[row][@"city"][0][@"area"];
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        provinceIndex = row;
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:row] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    }
    if (1 == component)
    {
        cityIndex = row;
        
        cityArr = jsonDataArr[provinceIndex][@"city"];
        
        districtArr = jsonDataArr[provinceIndex][@"city"][row][@"area"];
        
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:row] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    }
    
    if (2 == component) {
        
        districtIndex = row;
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:cityIndex] objectForKey:@"name"], [[districtArr objectAtIndex:row] objectForKey:@"name"]];
        
    }
    
    NSLog(@"%@", allName);
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        _adressV.hidden = NO;
        
    }else if (indexPath.row == 4){
    
        ChangePasswordViewController *ChangePasswordVC = [[ChangePasswordViewController alloc]init];
        
        [self.navigationController pushViewController:ChangePasswordVC animated:YES];
    }

}

//完成
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:okAction];
    
//    
//    
//    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSString *url = @"";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:SYGData[@"id"] forKey:@"uid"];

    
    
    if (textField == _nameTextField) {
        
        _nameTextField.userInteractionEnabled = NO;
        
        if ([typeStr isEqualToString:@"2"]) {
            
            url = edit_shop_infohtml;
            
            [params setObject:_nameTextField.text forKey:@"shop_name"];

        }else{
            
            url = edit_userhtml;
            
            [params setObject:typeStr forKey:@"type"];
            
            [params setObject:_nameTextField.text forKey:@"user_name"];

        }
        

        [DataSeviece requestUrl:url params:params success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                alertController.message = @"修改成功";
                
                [self presentViewController:alertController animated:YES completion:nil];

//                alertV.message = @"修改成功";
//                [alertV show];
                
                
            }else{
                alertController.message = result[@"result"][@"msg"];
                [self presentViewController:alertController animated:YES completion:nil];

//                alertV.message = result[@"result"][@"msg"];
//                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

        
        
    }else if (textField == _addressTextField ){
        
        if ([typeStr isEqualToString:@"2"]) {
            
            url = edit_shop_infohtml;
            
            
        }else{
            
            url = edit_userhtml;
            
            [params setObject:typeStr forKey:@"type"];
            
            
        }

        [params setObject:_addressTextField.text forKey:@"address"];
        
        [DataSeviece requestUrl:url params:params success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                alertController.message = @"修改成功";
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                //                alertV.message = @"修改成功";
                //                [alertV show];
                
                
            }else{
                alertController.message = result[@"result"][@"msg"];
                [self presentViewController:alertController animated:YES completion:nil];
                
                //                alertV.message = result[@"result"][@"msg"];
                //                [alertV show];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if (textField == _WXHTextField ){
        
        if ([typeStr isEqualToString:@"2"]) {
            
            url = edit_shop_infohtml;
            
        }else{
            
            url = edit_userhtml;
            
            [params setObject:typeStr forKey:@"type"];
            
            
        }
        
        [params setObject:_WXHTextField.text forKey:@"wechat"];
        
        [DataSeviece requestUrl:url params:params success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                alertController.message = @"修改成功";
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                //                alertV.message = @"修改成功";
                //                [alertV show];
                
                
            }else{
                alertController.message = result[@"result"][@"msg"];
                [self presentViewController:alertController animated:YES completion:nil];
                
                //                alertV.message = result[@"result"][@"msg"];
                //                [alertV show];
            }        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }

    [textField resignFirstResponder];

    
    return YES;
    
    
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
