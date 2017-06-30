//
//  AccountBindingViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AccountBindingViewController.h"

@interface AccountBindingViewController (){

    UITextField *accountTextField;
    UITextField *passwordTextField;
    UIButton *codeButton;
    NSInteger number;

}

@end

@implementation AccountBindingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    number = 60;
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar@2x"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"绑定平台账号";

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    UIView *ZHView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, kScreenWidth - 60, 44)];
    
    ZHView.layer.cornerRadius = 4;
    ZHView.layer.masksToBounds = YES;
    ZHView.layer.borderWidth = 1;
    ZHView.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    
    [self.view addSubview:ZHView];
    

    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 50, 20)];
    
    numLabel.text = @"账号:";
    numLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    numLabel.font = [UIFont systemFontOfSize:16];
    [ZHView addSubview:numLabel];
    
    
    accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(58, 12, kScreenWidth - 58 - 60 - 20, 20)];
    
    accountTextField.font = [UIFont systemFontOfSize:16];
    accountTextField.textColor =[RGBColor colorWithHexString:@"#666666"];
    
//    accountTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    [ZHView addSubview:accountTextField];
    
    UIView *MMView = [[UIView alloc]initWithFrame:CGRectMake(30, 84, kScreenWidth - 60, 44)];
    
    MMView.layer.cornerRadius = 4;
    MMView.layer.masksToBounds = YES;
    MMView.layer.borderWidth = 1;
    MMView.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    
    [self.view addSubview:MMView];
    
    UILabel *numLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 70, 20)];

    numLabel1.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    [MMView addSubview:numLabel1];

    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(58, 12, kScreenWidth - 58 - 60 - 20, 20)];
    
    passwordTextField.font = [UIFont systemFontOfSize:16];
    passwordTextField.textColor =[RGBColor colorWithHexString:@"#666666"];
//    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.secureTextEntry = YES;

    [MMView addSubview:passwordTextField];
    
    if([_dataDic[@"type"] isEqualToString:@"newshang"]||[_dataDic[@"type"] isEqualToString:@"xiaohongshu"]){
        
        passwordTextField.left = 70;
        
        numLabel1.text = @"验证码:";
        
        codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        codeButton.frame = CGRectMake(kScreenWidth - 60 - 8 - 78, 8, 78, 28);
//        [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyz@2x"] forState:UIControlStateNormal];
        
        codeButton.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
        
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];

        [codeButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
        codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [codeButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        codeButton.layer.cornerRadius = 4;
        codeButton.layer.masksToBounds = YES;
        codeButton.layer.borderWidth = 1;
        codeButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
        
        [MMView addSubview:codeButton];

    }else{
        numLabel1.text = @"密码:";
    }

    
    if ([_dataDic[@"type"] isEqualToString:@"ponhu"]) {
        accountTextField.placeholder = @"请输入胖虎账号";
        passwordTextField.placeholder = @"请输入胖虎密码";

    }else if([_dataDic[@"type"] isEqualToString:@"aidingmao"]){
        accountTextField.placeholder = @"请输入爱丁猫账号";
        passwordTextField.placeholder = @"请输入爱丁猫密码";

    }else if([_dataDic[@"type"] isEqualToString:@"aidingmaopro"]){
        accountTextField.placeholder = @"请输入爱丁猫专业版账号";
        passwordTextField.placeholder = @"请输入爱丁猫专业版密码";
        
    }else if([_dataDic[@"type"] isEqualToString:@"aidingmaomer"]){
        accountTextField.placeholder = @"请输入爱丁猫商家版账号";
        passwordTextField.placeholder = @"请输入爱丁猫商家版密码";
        
    }else if([_dataDic[@"type"] isEqualToString:@"jiuai"]){
        accountTextField.placeholder = @"请输入旧爱账号";
        passwordTextField.placeholder = @"请输入旧爱密码";
        
    }else if([_dataDic[@"type"] isEqualToString:@"xiaohongshu"]){
        accountTextField.placeholder = @"请输入小红书账号";
        passwordTextField.placeholder = @"请输入验证码";
        
        passwordTextField.width = 140;
        passwordTextField.clearButtonMode = UITextFieldViewModeNever;
        
        
    }else if([_dataDic[@"type"] isEqualToString:@"liequ"]){
        accountTextField.placeholder = @"请输入猎趣账号";
        passwordTextField.placeholder = @"请输入猎趣密码";
        
    }else if([_dataDic[@"type"] isEqualToString:@"shopuu"]){
        accountTextField.placeholder = @"请输入少铺账号";
        passwordTextField.placeholder = @"请输入少铺密码";
        
    }else if ([_dataDic[@"type"] isEqualToString:@"newshang"]){
        accountTextField.placeholder = @"请输入心上账号";
        passwordTextField.placeholder = @"请输入验证码";
        passwordTextField.width = 140;
        passwordTextField.clearButtonMode = UITextFieldViewModeNever;
        
    }

    
    UIButton *bindingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    bindingButton.backgroundColor = [UIColor colorWithRed:147/255.0 green:156/255.0 blue:255/255.0 alpha:.1];

    bindingButton.frame = CGRectMake(30, 158, kScreenWidth - 60, 44);

    [bindingButton setTitle:@"绑定" forState:UIControlStateNormal];
    [bindingButton setTitleColor:[RGBColor colorWithHexString:@"949dff"] forState:UIControlStateNormal];
    
    bindingButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [bindingButton addTarget:self action:@selector(bindingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    bindingButton.layer.masksToBounds = YES;
    bindingButton.layer.cornerRadius = 4;
    
    bindingButton.layer.borderWidth = 1;
    
    bindingButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    
    [self.view addSubview:bindingButton];
    
    if (([_dataDic[@"is_default"] isEqualToString:@"1"]&&[_dataDic[@"status"] isEqualToString:@"1"])||![_dataDic[@"is_default"] isEqualToString:@"1"]) {
        
        if (_dataDic[@"id"]) {
            
            UIButton *JCBDButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            JCBDButton.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
            
            JCBDButton.frame = CGRectMake(30, bindingButton.bottom+20, kScreenWidth - 60, 48);
            [JCBDButton setTitleColor:[RGBColor colorWithHexString:@"949dff"] forState:UIControlStateNormal];
            
            [JCBDButton setTitle:@"解绑" forState:UIControlStateNormal];
            
            JCBDButton.titleLabel.font = [UIFont systemFontOfSize:20];
            
            [JCBDButton addTarget:self action:@selector(JCBDButtonAction) forControlEvents:UIControlEventTouchUpInside];
            JCBDButton.layer.masksToBounds = YES;
            JCBDButton.layer.cornerRadius = 4;
            JCBDButton.layer.borderWidth = 1;
            
            JCBDButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
            
            [self.view addSubview:JCBDButton];
            
            accountTextField.text = _dataDic[@"phone"];
            
            
            if([_dataDic[@"type"] isEqualToString:@"newshang"]){
                
            }else{
                passwordTextField.text = _dataDic[@"password"];
            }
            
        }

    }else{
    
        [bindingButton setTitle:@"重新绑定" forState:UIControlStateNormal];

    }
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    
    [self.view addGestureRecognizer:singleRecognizer];
    

}

- (void)singleAction{

    [passwordTextField resignFirstResponder];
    
    [accountTextField resignFirstResponder];

}

//解除绑定
- (void)JCBDButtonAction{

    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_dataDic[@"id"] forKey:@"id"];
    [DataSeviece requestUrl:delete_share_accounthtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectTypeNotification" object:@{}];

            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//绑定
- (void)bindingButtonAction{
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:accountTextField.text forKey:@"phone"];
    
    [params setObject:_dataDic[@"type"] forKey:@"type"];
    
    NSString *url = @"";
    
    if (_dataDic[@"id"]) {
        
        url = edit_share_accounthtml;
        
        [params setObject:_dataDic[@"id"] forKey:@"id"];
        
    }else{
        
        url = Shareadd_share_accounthtml;
        
    }
    
    if ([_dataDic[@"type"] isEqualToString:@"newshang"]||[_dataDic[@"type"] isEqualToString:@"xiaohongshu"]) {
        
        url = editSmsUserhtml;
        
        [params setObject:passwordTextField.text forKey:@"code"];

    }else{
    
        [params setObject:passwordTextField.text forKey:@"password"];

    }
    
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectTypeNotification" object:@{}];

        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

//获取验证码
- (void)codeButtonAction:(UIButton*)bt{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([accountTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:accountTextField.text forKey:@"phone"];
    

    if ([_dataDic[@"type"] isEqualToString:@"newshang"]){
        [params setObject:@"newshang" forKey:@"type"];
    }
    
    if ([_dataDic[@"type"] isEqualToString:@"xiaohongshu"]){
        [params setObject:@"xiaohongshu" forKey:@"type"];
    }
    
    [DataSeviece requestUrl:SendSmshtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            codeButton.userInteractionEnabled = NO;

            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
            
        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)timeAction:(NSTimer*)timer{
    
    if (number == 0) {
        codeButton.userInteractionEnabled = YES;
        [timer invalidate];
        timer = nil;
        number = 60;
//        [codeButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//        [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyz@2x"] forState:UIControlStateNormal];
//        
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        
        number--;
        
        [codeButton setTitle:[NSString stringWithFormat:@"%ld秒",number] forState:UIControlStateNormal];
    }
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
