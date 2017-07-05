//
//  ChangePasswordViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/11.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>{


    UITextField *nameTextField;
    UITextField *phoneTextField;
    UITextField *codeTextField;
    UITextField *passwordTextField;
    UIButton *codeButton;
    NSInteger number;

}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    number = 60;
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self.view addGestureRecognizer:singleRecognizer];
    

    //账号密码
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(30, 20, kScreenWidth - 60, 216)];
    
    //    midView.backgroundColor = [UIColor whiteColor];
    //    midView.layer.cornerRadius = 5;
    //    midView.layer.masksToBounds = YES;
    //    midView.layer.borderWidth = 1;
    //    midView.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    [self.view addSubview:midView];
    
    
    //中间线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, kScreenWidth - 60, 44)];
    
    lineView.backgroundColor = [UIColor clearColor];
    lineView.layer.cornerRadius = 4;
    lineView.layer.masksToBounds = YES;
    lineView.layer.borderWidth = 1;
    lineView.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    
    [midView addSubview:lineView];
    
    //中间线
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(0, lineView.bottom+10, kScreenWidth - 60, 44)];
    line1View.backgroundColor = [UIColor clearColor];
    line1View.layer.cornerRadius = 4;
    line1View.layer.masksToBounds = YES;
    line1View.layer.borderWidth = 1;
    line1View.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    
    [midView addSubview:line1View];
    
    //中间线
    UIView *line2View = [[UIView alloc]initWithFrame:CGRectMake(0, line1View.bottom+10, kScreenWidth - 60, 44)];
    line2View.backgroundColor = [UIColor clearColor];
    line2View.layer.cornerRadius = 4;
    line2View.layer.masksToBounds = YES;
    line2View.layer.borderWidth = 1;
    line2View.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    [midView addSubview:line2View];
    
    
    //中间线
    UIView *line3View = [[UIView alloc]initWithFrame:CGRectMake(0, line2View.bottom+10, kScreenWidth - 60,44)];
    line3View.backgroundColor = [UIColor clearColor];
    line3View.layer.cornerRadius = 4;
    line3View.layer.masksToBounds = YES;
    line3View.layer.borderWidth = 1;
    line3View.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    [midView addSubview:line3View];
    
    //手机号和密码 店名 短信验证码
    
    //店名
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
    nameLabel.text = @"账号:";
    nameLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:nameLabel];
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.right, nameLabel.top, 200, 20)];
    nameTextField.tag = 110;
    nameTextField.delegate = self;
    nameTextField.textColor = [RGBColor colorWithHexString:@"#6666666"];
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.font = [UIFont systemFontOfSize:15];
    nameTextField.placeholder = @"请输入手机号或者邮箱";
    [nameTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:nameTextField];
    
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, nameLabel.top+54, 55, 20)];
    phoneLabel.text = @"新密码:";
    phoneLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:phoneLabel];
    
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(phoneLabel.right, phoneLabel.top, 200, 20)];
    phoneTextField.delegate = self;
    phoneTextField.tag = 111;
    phoneTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    phoneTextField.secureTextEntry = YES;
    phoneTextField.font = [UIFont systemFontOfSize:15];
    phoneTextField.placeholder = @"请输入密码";
    [phoneTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:phoneTextField];
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, phoneLabel.top+54, 90, 20)];
    passwordLabel.text = @"确定新密码:";
    passwordLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    passwordLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:passwordLabel];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(passwordLabel.right, passwordLabel.top, 200, 20)];
    passwordTextField.delegate = self;
    passwordTextField.tag = 112;
    passwordTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.placeholder = @"请输入密码";
    [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:passwordTextField];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, passwordLabel.top+54, 90, 20)];
    codeLabel.text = @"获取验证码:";
    codeLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    codeLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:codeLabel];
    
    codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(codeLabel.right, codeLabel.top, 100, 20)];
    codeTextField.delegate = self;
    codeTextField.tag = 113;
    codeTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.font = [UIFont systemFontOfSize:15];
    codeTextField.placeholder = @"请输入验证码";
    [codeTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:codeTextField];
    
    codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame = CGRectMake(midView.width-78, codeLabel.top , 68, 24);
    
    codeButton.layer.cornerRadius = 4;
    codeButton.layer.masksToBounds = YES;
    codeButton.layer.borderWidth = 1;
    codeButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [codeButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [codeButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    codeButton.layer.cornerRadius = 5;
    codeButton.layer.masksToBounds = YES;
    
    [midView addSubview:codeButton];
    
    
    //注册按钮
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(30, midView.bottom+20, kScreenWidth - 60, 44);
    
    [registButton setBackgroundImage:[UIImage imageNamed:@"loginbtn0@2x"] forState:UIControlStateNormal];
    [registButton setBackgroundImage:[UIImage imageNamed:@"LOGINBTN@2x"] forState:UIControlStateHighlighted];
    
    
    //    [registButton setBackgroundColor:[UIColor colorWithRed:147/256.0 green:156/256.0 blue:255/256.0 alpha:.1]];
    //
    //    registButton.layer.borderWidth = 1;
    //    registButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    [registButton setTitle:@"确定" forState:UIControlStateNormal];
    [registButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:21];
    registButton.layer.cornerRadius = 5;
    registButton.layer.masksToBounds = YES;
    
    [registButton addTarget:self action:@selector(registButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];


}

- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"密码修改";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    

}

//确定
- (void)registButtonAction{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([nameTextField.text isEqualToString:@""]) {
        alertV.message = @"手机号不能为空";
        [alertV show];
        return;
    }
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"密码不能为空";
        [alertV show];
        return;
    }
    if ([codeTextField.text isEqualToString:@""]) {
        alertV.message = @"验证码不能为空";
        [alertV show];
        return;
    }
    
    if (![passwordTextField.text isEqualToString:phoneTextField.text] ) {
        alertV.message = @"密码不相同";
        [alertV show];
        return;
    }
    
    [params setObject:nameTextField.text forKey:@"mobile"];
    
    [params setObject:phoneTextField.text forKey:@"password"];
    
    [params setObject:codeTextField.text forKey:@"code"];
    
    
    [DataSeviece requestUrl:find_passwordhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"SYGData"]];
            [dic setObject:passwordTextField.text forKey:@"password"];
            [defaults setObject:dic forKey:@"SYGData"];
            [defaults synchronize];
            alertV.message = @"修改密码成功";
            [alertV show];
            [self dismissViewControllerAnimated:YES completion:nil];
            
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
    
    if ([nameTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":nameTextField.text,@"code_type":@"1"} mutableCopy] success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            //            alertV.message = @"发送成功";
            //            [alertV show];
            codeButton.userInteractionEnabled = NO;
            //            [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyzhui@2x"] forState:UIControlStateNormal];
            
            [codeButton setTitleColor:[RGBColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
            
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
        [codeButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
        
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        
        number--;
        
        [codeButton setTitle:[NSString stringWithFormat:@"%ld秒",(long)number] forState:UIControlStateNormal];
    }

    
}




//隐藏键盘
- (void)singleAction{
    
    [phoneTextField resignFirstResponder];
    
    [nameTextField resignFirstResponder];
    
    [passwordTextField resignFirstResponder];
    
    [codeTextField resignFirstResponder];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


@end
