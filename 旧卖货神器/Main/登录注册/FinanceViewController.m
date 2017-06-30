//
//  FinanceViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "FinanceViewController.h"
#import "FinanceCell.h"
#import "FinancialModel.h"
#import "PersonelModel.h"
#import "StaffEditorViewController.h"


@interface FinanceViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{

    BOOL flag;
    UIImageView *typeImageV;
    UILabel *typelabel;
    UITextField *numbelTextField;
    UITextField *nameTextField;
    UITextField *passwordTextField;
    UIView *passwordView;
}

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation FinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popAction) name:@"NSNotificationPOP" object:nil];
    
    _dataArr = [NSMutableArray array];

    
    //设置标题
    if (_isPersonnel) {
        self.navigationItem.title = @"人员账号管理";

    }else{
        self.navigationItem.title = @"财务账号管理";
    }
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar@2x"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];

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
    rightBtn.tag = 100;
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    //表示图
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];

    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"FinanceCell" bundle:nil] forCellReuseIdentifier:@"FinanceCell"];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    
    footerView.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    if ([SYGData[@"type"] isEqualToString:@"3"]&&_isPersonnel) {
        
        
    }else{

        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(35, 40, kScreenWidth-70, 48);
        
        addButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
        
        [addButton setTitle:@"添加" forState:UIControlStateNormal];
        [addButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        addButton.layer.cornerRadius = 4;
        addButton.layer.masksToBounds = YES;
        
        [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:addButton];
        _myTableView.tableFooterView = footerView;

    }
    
    
    
    if (_isPersonnel) {
        
        [self loadData1];
    }else{
        
        [self loadData];

    }
    
}

//加载数据财务管理
- (void)loadData{
    
    //网络加载
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    [DataSeviece requestUrl:get_accounthtm_API params:[@{@"uid":SYGData[@"id"]} mutableCopy] success:^(id result) {
        
        NSLog(@"%@",result);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            FinancialModel *model = [[FinancialModel alloc]initWithContentsOfDic:[NULLHandle NUllHandle:dic]];
            model.financialId = dic[@"id"];
            [_dataArr addObject:model];
        }
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

//人员管理数据
- (void)loadData1{

    //网络加载
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    
    [DataSeviece requestUrl:get_userhtml params:[@{@"uid":SYGData[@"id"]} mutableCopy] success:^(id result) {
        
        NSLog(@"%@",result);
        NSString *msgStr = result[@"result"][@"msg"];
        NSLog(@"%@",msgStr);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            PersonelModel *model = [[PersonelModel alloc]initWithContentsOfDic:[NULLHandle NUllHandle:dic]];
            model.personelId = dic[@"id"];
            [_dataArr addObject:model];
        }
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


//确定添加
//- (void)tureButtonAction{
//    
////    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    NSString *url;
//    if (_isPersonnel) {
////        if (![self isMobile:numbelTextField.text]) {
////            
////            alertV.message = @"手机号格式不正确";
////            [alertV show];
////            return;
////        }
//        
//
//        url = add_userhtml;
//        [params setObject:numbelTextField.text forKey:@"mobile"];
//        [params setObject:nameTextField.text forKey:@"user_name"];
//
//        NSArray *arr = @[@"老板",@"主帐号",@"店员"];
//
//        for (int i = 0; i<3; i++) {
//            if ([arr[i] isEqualToString:typelabel.text]) {
//                [params setObject:[NSString stringWithFormat:@"%d",i+1] forKey:@"type"];
//            }
//        }
//        [params setObject:passwordTextField.text forKey:@"password"];
//    }else{
//        url = add_accounthtml;
//        [params setObject:nameTextField.text forKey:@"use_name"];
//
//        [params setObject:numbelTextField.text forKey:@"account"];
//    for (NSDictionary *dic in _downArr) {
//        if ([dic[@"name"] isEqualToString:typelabel.text]) {
//            [params setObject:dic[@"id"] forKey:@"type"];
//        }
//    }
//    }
//    [DataSeviece requestUrl:url params:params success:^(id result) {
//        
//        NSLog(@"%@",result);
//        
//         if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
//            _zzView.hidden = YES;
//            _addView.hidden = YES;
//            [_dataArr removeAllObjects];
//            if (_isPersonnel) {
//                [self loadData1];
//            }else{
//               [self loadData];
//            }
//        }else{
//            
//            NSString *str = result[@"result"][@"msg"];
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertV show];
//            NSLog(@"%@",str);
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//
//}
//手机号验证
- (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349|77)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    return NO;
}


//添加账号
- (void)addButtonAction{
    
    StaffEditorViewController *staffVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"StaffEditorViewController"];
    staffVC.isAdd = YES;
    [self.navigationController pushViewController:staffVC animated:YES];
    

}

//左边返回按钮
- (void)leftBtnAction{
    
    if (_isPersonnel) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SticksNotification" object:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//右边编辑按钮
-(void)editAction:(UIButton*)bt{
    
    //当前tableView的是否正在编辑
    BOOL editing = _myTableView.editing;
    
    if (editing) {
        
        [bt setTitle:@"编辑" forState:UIControlStateNormal];
        [_myTableView setEditing:NO animated:YES];
    }else{
        
        [bt setTitle:@"完成" forState:UIControlStateNormal];
        [_myTableView setEditing:YES animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FinanceCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"FinanceCell" forIndexPath:indexPath];
    
    if (_isPersonnel) {
        cell.model1 = _dataArr[indexPath.row];
        
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else{
        
        cell.model = _dataArr[indexPath.row];
        
    }
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    if (_isPersonnel) {
        
        if (indexPath.row != 0) {
            
            StaffEditorViewController *staffVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"StaffEditorViewController"];
            staffVC.model = _dataArr[indexPath.row];
            [self.navigationController pushViewController:staffVC animated:YES];
            
        }
    }
    
}

//是否可以编辑，如果返回值是no，不可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//返回每一行编辑的风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row==0) {
//        
//        //可以根据不同的行数返回不同的编辑模式   插入（添加）
//        return UITableViewCellEditingStyleInsert;
//    }
    
    return UITableViewCellEditingStyleDelete;
    //    删除
    //    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    
}

//具体实现添加或删除，执行的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonelModel *model = _dataArr[indexPath.row];
    
    if ([model.type isEqualToString:@"2"]) {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"主账号不能删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
        
    }
    
    
//    if (indexPath.row == 0) {
//        if (_isPersonnel) {
//
//            if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"2"]) {
//                
//            }
//            
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"主账号不能删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertV show];
//            return;
//
//
//        }else{
//            
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"现金支付不能删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertV show];
//            return;
//            
//        }
//        
//    }

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSString *url;
    if (_isPersonnel) {
        
        PersonelModel *model = _dataArr[indexPath.row];
        [params setObject:model.personelId forKey:@"id"];
        url = delete_userhtml;
    }else{
    
        FinancialModel *model = _dataArr[indexPath.row];
    
        [params setObject:model.financialId forKey:@"id"];
        url = delete_accounthtml;
    }
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [_dataArr removeObjectAtIndex:indexPath.row];
            
            [_myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  
        }else{
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

- (void)singleAction{
    
    [nameTextField resignFirstResponder];
    [numbelTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

- (void)popAction{
    
    [_dataArr removeAllObjects];
    
    [self loadData1];

}

@end
