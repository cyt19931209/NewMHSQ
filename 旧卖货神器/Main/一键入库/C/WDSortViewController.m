//
//  WDSortViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "WDSortViewController.h"

@interface WDSortViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

    UIPickerView *_mPickerView;
    
    UIView *_adressV;

    NSInteger index;
    
}


@property (nonatomic,strong) NSArray *pickerArr;

@property (nonatomic,strong) NSDictionary *pickerDic;

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation WDSortViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    if (_isMaterial) {
    
        self.navigationItem.title = @"材质";

    }else{
    
        self.navigationItem.title = @"微店分类选择";
        
        _dataArr = [NSMutableArray array];

    }

    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    if (!_isMaterial) {
        
        [self loadData];

    }else{
    
        [self loadData1];
    }
    
    NSLog(@"%@",_dataArr);
    
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
    [trueButton1 setTitleColor:[RGBColor colorWithHexString:@"949dff"] forState:UIControlStateNormal];

    [_adressV addSubview:trueButton1];
    UIButton *cancelButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton1.frame = CGRectMake(10, 0, 40, 40);
    [cancelButton1 setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton1 addTarget:self action:@selector(cancelAction1) forControlEvents:
     UIControlEventTouchUpInside];
    
    [cancelButton1 setTitleColor:[RGBColor colorWithHexString:@"949dff"] forState:UIControlStateNormal];
    [_adressV addSubview:cancelButton1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    label.textColor = [RGBColor colorWithHexString:@"949dff"];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"材质纯度";
    
    label.font = [UIFont systemFontOfSize:14];
    
    [_adressV addSubview:label];
    
    
}

//确定
- (void)trueAction1{
    
    _adressV.hidden = YES;
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
    NSLog(@"%@ %@",dic1,_pickerDic);
    
    [dic1 setObject:_pickerDic forKey:@"purity"];
    
    
    [_dataArr replaceObjectAtIndex:index withObject:[dic1 copy]];
    
    [_myTableView reloadData];


}
//取消
- (void)cancelAction1{
    
    _adressV.hidden = YES;

}

//确定
- (void)editAction{
    
    
    if (_isMaterial) {
        
        NSMutableArray *selectArr = [NSMutableArray array];
        
        for (NSDictionary *dic in _dataArr) {
            
            if ([dic[@"isSelect"] isEqualToString:@"1"]) {
                
                [selectArr addObject:dic];
                
            }
            
        }
        
        NSString *idStr = @"";
        
        NSString *nameStr = @"";

        
        for (NSDictionary *dic in selectArr) {
            
            NSString *str = dic[@"id"];
            
            NSString *str1 = dic[@"name"];

            if (dic[@"purity"][@"id"]) {

                str = [NSString stringWithFormat:@"%@|%@",str,dic[@"purity"][@"id"]];
                
                str1 = [NSString stringWithFormat:@"%@|%@",str1,dic[@"purity"][@"name"]];
            }

            idStr = [NSString stringWithFormat:@"%@,%@",idStr,str];
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,str1];
            
        }
        
        if (selectArr.count > 0) {
        
            idStr = [idStr substringFromIndex:1];
            
            nameStr = [nameStr substringFromIndex:1];
        }
        
//        NSLog(@"%@    %@",idStr,nameStr);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MaterialNotification" object:@{@"id":idStr,@"name":nameStr}];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
    
        NSMutableArray *selectArr = [NSMutableArray array];
        
        for (NSDictionary *dic in _dataArr) {
            
            if ([dic[@"isSelect"] isEqualToString:@"1"]) {
                
                [selectArr addObject:dic];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WDSorNotification" object:[selectArr copy]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


- (void)loadData1{

    NSArray *idArr = [_idStr componentsSeparatedByString:@","];
    
    NSArray *nameArr = [_nameStr componentsSeparatedByString:@","];

    for (int i = 0; i < _dataArr.count; i++) {
        
        NSDictionary *dic = _dataArr[i];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [dic1 setObject:@"0" forKey:@"isSelect"];
        
        
        NSLog(@"%@ %@",nameArr,idArr);
        
        for (int j = 0; j < idArr.count; j++) {
            
            NSString *idStr = idArr[j];
            
            NSString *nameStr = @"";
            
            if (nameArr.count > j) {
                
                nameStr = nameArr[j];

            }
            
            
            NSRange range = [idStr rangeOfString:@"|"]; //现获取搜索要截取的字符串位置
            
            NSRange range1 = [nameStr rangeOfString:@"|"]; //现获取搜索要截取的字符串位置
            

            NSString *materialId;
            
            NSString *purityId;
            
            NSString *materialName;
            
            NSString *purityName;
            
            if ([idStr rangeOfString:@"|"].location == NSNotFound) {
                
                materialId = idStr;
                
                
                purityId = @"";
                
//                materialName = nameStr;
//
//                purityName = @"";

            }else{
            
                materialId = [idStr substringToIndex:range.location];
                
                purityId = [idStr substringFromIndex:range.location + 1];
                
//                materialName = [nameStr substringToIndex:range1.location];
//                
//                purityName = [nameStr substringFromIndex:range1.location + 1];
//                
            }
            
            if ([nameStr rangeOfString:@"|"].location == NSNotFound) {
                
                
                materialName = nameStr;
                
                
                purityName = @"";
                
            }else{
                
                materialName = [nameStr substringToIndex:range1.location];
                
                purityName = [nameStr substringFromIndex:range1.location + 1];
                
            }
            
            
            
            
            
            if ([materialId integerValue] == [dic1[@"id"] integerValue]) {

                [dic1 setObject:@"1" forKey:@"isSelect"];

                [dic1 setObject:@{@"name":purityName,@"id":purityId} forKey:@"purity"];
            }
        }
        
        [_dataArr replaceObjectAtIndex:i withObject:[dic1 copy]];
    }

}

- (void)loadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSString *url = @"";
    
//    if (_isMaterial) {
//        
//        url = get_materialhtml;
//
//        [params setObject:_category_id forKey:@"category_id"];
//        
//    }else{
    
        [params setObject:@"vdian" forKey:@"type"];
        
        [params setObject:@"category" forKey:@"param_name"];
        
        url = get_platform_paramhtml;

//    }
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSArray *idArr = [_idStr componentsSeparatedByString:@","];
        
        NSLog(@"%@",idArr);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
            
            [dic1 setObject:@"0" forKey:@"isSelect"];
            
            for (NSString *str in idArr) {
                
                NSLog(@"%@ %@",str,dic1[@"cate_id"]);
                
                if ([str integerValue] == [dic1[@"cate_id"] integerValue]) {
                    
                    [dic1 setObject:@"1" forKey:@"isSelect"];
                    
                }
            }
            
            [_dataArr addObject:[dic1 copy]];
            
        }
        
        if (_isMaterial) {
            
            NSArray *arr = result[@"result"][@"data"][@"item"];
            
            if (arr.count == 0) {
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 80, 128, 128)];
                imageV.image = [UIImage imageNamed:@"bq@2x"];
                
                [self.view addSubview:imageV];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.bottom+10, kScreenWidth, 20)];
                
                label.text = @"请登录PC网页微店添加分类";
                
                label.textColor = [RGBColor colorWithHexString:@"#666666"];
                label.font = [UIFont systemFontOfSize:16];
                label.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:label];
                
            }
        }
        
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WDSortCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WDSortCell"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100;
        
        button.frame = CGRectMake(- 9, -1, 50, 50);
        
        [button setImage:[UIImage imageNamed:@"noch@2x"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"ch@2x"] forState:UIControlStateSelected];
        
        [cell.contentView addSubview:button];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        if (_isMaterial) {
          
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 9, 70, 30)];
            
            textField.tag = 101;
            
            textField.placeholder = @"选择纯度";
            
            textField.textAlignment = NSTextAlignmentRight;
            
            textField.enabled = NO;
            
            textField.textColor = [RGBColor colorWithHexString:@"666666"];
            
            
            [cell.contentView addSubview:textField];
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

            
        }
    }
    

    UIButton *button = [cell.contentView viewWithTag:100];
    
    UITextField *textField = [cell.contentView viewWithTag:101];
    
    
    if (_isMaterial) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"    %@",_dataArr[indexPath.row][@"name"]];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (_dataArr[indexPath.row][@"purity"][@"name"]) {
            
            textField.text = _dataArr[indexPath.row][@"purity"][@"name"];
        }else{
        
            textField.text = @"";
        }
        
    }else{
    
        cell.textLabel.text = [NSString stringWithFormat:@"    %@",_dataArr[indexPath.row][@"cate_name"]];
        
    }
    
    if ([_dataArr[indexPath.row][@"isSelect"] isEqualToString:@"1"]) {
        
        button.selected = YES;
        
        button.userInteractionEnabled = YES;
        
    }else{
        
        button.selected = NO;
        
        button.userInteractionEnabled = NO;

    }
    
    cell.contentView.tag = 200+indexPath.row;
    
    return cell;
}

//取消选择
- (void)buttonAction:(UIButton*)bt{

    NSLog(@"取消选择");
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:_dataArr[bt.superview.tag - 200]];

    [dic1 setObject:@"0" forKey:@"isSelect"];
    
    [dic1 setObject:@{} forKey:@"purity"];

    [_dataArr replaceObjectAtIndex:bt.superview.tag - 200 withObject:[dic1 copy]];
    
    [_myTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_isMaterial) {
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:_dataArr[indexPath.row]];
        
        [dic1 setObject:@"1" forKey:@"isSelect"];
        
        [_dataArr replaceObjectAtIndex:indexPath.row withObject:[dic1 copy]];
        
        [_myTableView reloadData];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:_dataArr[indexPath.row][@"id"] forKey:@"material_id"];

        [DataSeviece requestUrl:get_purityhtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            index = indexPath.row;
            
            _pickerArr = result[@"result"][@"data"][@"item"];
            
            [_mPickerView selectRow:0 inComponent:0 animated:YES];

            if (_pickerArr.count > 0) {
                
            
                for (int i = 0;i < _pickerArr.count ; i++) {
                    
                    if (_dataArr[indexPath.row][@"purity"]) {
                        
                        
                        if ([_dataArr[indexPath.row][@"purity"][@"id"] integerValue] == [_pickerArr[i][@"id"] integerValue]) {
                            
                            _pickerDic = _pickerArr[i];
                            
                            [_mPickerView selectRow:i inComponent:0 animated:YES];
                        }
                        
                    }else{
                        
                        _pickerDic = _pickerArr[0];
                        
                    }
                    
                }
                
                if (_dataArr[indexPath.row][@"purity"]) {
                    
                    if (_dataArr[indexPath.row][@"purity"][@"id"]) {
                    
                        if ([_dataArr[indexPath.row][@"purity"][@"id"] isEqualToString:@""]) {
                            _pickerDic = _pickerArr[0];
                        }
                    }
                    
                }
                
//                NSLog(@"%@",_pickerArr);
                
                [_mPickerView reloadComponent:0];
                
                _adressV.hidden = NO;
                
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        
        
        
    }else{
    
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:_dataArr[indexPath.row]];
        
        if ([dic1[@"isSelect"] isEqualToString:@"1"]) {
            
            [dic1 setObject:@"0" forKey:@"isSelect"];
            
        }else{
            
            [dic1 setObject:@"1" forKey:@"isSelect"];
            
        }
        
        [_dataArr replaceObjectAtIndex:indexPath.row withObject:[dic1 copy]];
        
        [_myTableView reloadData];
        
    }

}


#pragma mark - UIPickerViewDataSource||UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return _pickerArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerArr[row][@"name"];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _pickerDic = _pickerArr[row];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    
}


@end
