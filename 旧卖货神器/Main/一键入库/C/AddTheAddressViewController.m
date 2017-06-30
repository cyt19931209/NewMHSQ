//
//  AddTheAddressViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AddTheAddressViewController.h"

@interface AddTheAddressViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

    UIPickerView *_mPickerView;
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *allName;
    NSString *allCode;
    UIView *_adressV;

    NSArray *jsonDataArr;

}

@end

@implementation AddTheAddressViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    

    //    地区选择器
    
    _adressV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
    _adressV.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    _adressV.hidden = YES;
    [self.view addSubview:_adressV];
    
    _mPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
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
    
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"xinshang" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    jsonDataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    provinceArr = jsonDataArr;
    
    cityArr = jsonDataArr[0][@"children"];
    
    districtArr = jsonDataArr[0][@"children"][0][@"children"];
    
    
    allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:0] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    
    
}

- (void)trueAction1{
    
    _adressV.hidden = YES;
    _SSXTextField.text = allName;
    
}


- (void)cancelAction1{
    _adressV.hidden = YES;
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
        
        cityArr = jsonDataArr[row][@"children"];
        districtArr = jsonDataArr[row][@"children"][0][@"children"];
        
        
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
        
        cityArr = jsonDataArr[provinceIndex][@"children"];
        districtArr = jsonDataArr[provinceIndex][@"children"][row][@"children"];
        
        
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


//左边返回按钮
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"新增地址";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.tableView addGestureRecognizer:singleRecognizer];
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
     
        _adressV.hidden = NO;
    }
    
}

//隐藏键盘
- (void)singleAction{
    
    [_DZTextField resignFirstResponder];
    
    [_phoneTextField resignFirstResponder];
    
    [_XXTextField resignFirstResponder];

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
//保存按钮
- (IBAction)saveAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    if ([_DZTextField.text isEqualToString:@""]) {
        alertV.message = @"收货人不能为空";
        [alertV show];
        return;
    }

    
    if ([_phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"手机号不能为空";
        [alertV show];
        return;
    }
    
    if ([_SSXTextField.text isEqualToString:@""]) {
        alertV.message = @"省市县不能为空";
        [alertV show];
        return;
    }
    
    if ([_XXTextField.text isEqualToString:@""]) {
        alertV.message = @"详细不能为空";
        [alertV show];
        return;
    }


    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:@"newshang" forKey:@"type"];
    [params setObject:@"address" forKey:@"param_name"];

    
    
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    
    
    [data setObject:_phoneTextField.text forKey:@"phone"];
    [data setObject:_DZTextField.text forKey:@"contactName"];
    [data setObject:_XXTextField.text forKey:@"address"];
    [data setObject:allName forKey:@"city"];
    [data setObject:provinceArr[provinceIndex][@"id"] forKey:@"provinceId"];
    [data setObject:cityArr[cityIndex][@"id"] forKey:@"cityId"];
    [data setObject:districtArr[districtIndex][@"id"] forKey:@"districtId"];
    
    
    [params setObject:[data copy] forKey:@"data"];
    
    [DataSeviece requestUrl:add_platform_paramhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationAddress" object:result[@"result"][@"data"][@"id"]];
            
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
    
}
@end
