//
//  LoginViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "AppDelegate.h"
#import "PasswordRecoveryViewController.h"
#import "OnePublishingViewController.h"
#import "JPUSHService.h"
#import "BaseTabBarController.h"


@interface LoginViewController ()<UITextFieldDelegate>{

    UITextField *phoneTextField;
    UITextField *passwordTextField;
    UIButton *codeButton;
    NSInteger number;

}

@property (nonatomic,strong) UIImageView *selectImageV;

@property (nonatomic,strong) UIImageView *XHImageV;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    number = 60;
    //背景图片
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    bgImageV.image = [UIImage imageNamed:@"logobg"];
    
    [self.view addSubview:bgImageV];
    
    //账号密码
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(30, kScreenHeight/2 - 70, kScreenWidth - 75, 140)];
    
    [self.view addSubview:midView];

    
    
    _XHImageV = [[UIImageView alloc]initWithFrame:CGRectMake(94, kScreenHeight/2 - 65 - 28 + 43, 240, 37)];
    
    _XHImageV.image = [UIImage imageNamed:@"tipsbg"];
    
    [self.view addSubview:_XHImageV];

    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 24, 24)];
    
    imageV.image = [UIImage imageNamed:@"tipslogo"];
    
    [_XHImageV addSubview:imageV];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(36, 8, 204, 12);
    label.text = @"使用闲货帐号可以直接登陆哦！";
    label.font = [UIFont fontWithName:@".PingFangSC-Light" size:14];
    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    [_XHImageV addSubview:label];

    
    //中间线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43 + 5, midView.width, 42)];
    
    lineView.backgroundColor = [UIColor clearColor];
    
    lineView.layer.cornerRadius = 4;
    lineView.layer.masksToBounds = YES;
    lineView.layer.borderWidth = 1;
    lineView.layer.borderColor = [RGBColor colorWithHexString:@"#d9d9d9"].CGColor;
    
    [midView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 93 + 5, midView.width, 42)];
    lineView1.backgroundColor = [UIColor clearColor];
    
    lineView1.layer.cornerRadius = 4;
    lineView1.layer.masksToBounds = YES;
    lineView1.layer.borderWidth = 1;
    lineView1.layer.borderColor = [RGBColor colorWithHexString:@"#d9d9d9"].CGColor;
    
    [midView addSubview:lineView1];

    //主账号和子账号选择按钮
    
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.frame = CGRectMake(0, 0, midView.width/2, 30);
    [mainButton setTitle:@"主账号" forState:UIControlStateNormal];
    [mainButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [mainButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateSelected];
    mainButton.titleLabel.font = [UIFont systemFontOfSize:16];
    mainButton.tag = 101;
    mainButton.selected = YES;
    [mainButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:mainButton];
    
    _selectImageV = [[UIImageView alloc]initWithFrame:CGRectMake((midView.width/2 - 12)/2, 25, 12, 6)];
    
    _selectImageV.image = [UIImage imageNamed:@"三角标@2x"];
    
//    _selectImageV.backgroundColor = [UIColor whiteColor];
//    _selectImageV.layer.cornerRadius = 4;
//    _selectImageV.layer.masksToBounds = YES;
    [mainButton addSubview:_selectImageV];
    
    UIButton *sonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sonButton.frame = CGRectMake(midView.width/2, 0, midView.width/2, 30);
    [sonButton setTitle:@"子账号" forState:UIControlStateNormal];
    [sonButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [sonButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateSelected];
    sonButton.titleLabel.font = [UIFont systemFontOfSize:16];
    sonButton.tag = 102;
    [sonButton addTarget:self action:@selector(sonButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:sonButton];
    
    //手机号和密码
    
    UIImageView *phoneImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 58, 22, 22)];
    
    phoneImageV.image = [UIImage imageNamed:@"账号"];
    
    [midView addSubview:phoneImageV];

    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageV.right+10, 60, 200, 22)];
    phoneTextField.delegate = self;
    
    phoneTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    phoneTextField.tag = 110;
    phoneTextField.font = [UIFont systemFontOfSize:18];
    phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    phoneTextField.placeholder = @"请输入手机号或者邮箱";
    
    [phoneTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:phoneTextField];
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    showButton.frame = CGRectMake(midView.width - 38, 57, 24, 24);
    
    [showButton setImage:[UIImage imageNamed:@"tips"] forState:UIControlStateNormal];
    
    
    [showButton addTarget:self action:@selector(showButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [midView addSubview:showButton];

    
    UIImageView *passwordImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 110, 22, 22)];
    
    passwordImageV.image = [UIImage imageNamed:@"密码"];
    passwordImageV.tag = 121;

    [midView addSubview:passwordImageV];
    
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(passwordImageV.right+10, 112, 150, 22)];
    passwordTextField.delegate = self;
    passwordTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    passwordTextField.tag = 111;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.font = [UIFont systemFontOfSize:18];
    passwordTextField.placeholder = @"请输入密码";
//    [passwordTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:passwordTextField];
    
    codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame = CGRectMake(midView.width-78, midView.height-30, 68, 24);
    
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
    codeButton.hidden = YES;
    codeButton.tag = 120;
    [midView addSubview:codeButton];

    //登录按钮
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(30, midView.bottom+20, kScreenWidth - 75, 44);
    
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"loginbtn0@2x"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"LOGINBTN@2x"] forState:UIControlStateHighlighted];

    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:21];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;

    
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    //注册按钮
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(kScreenWidth - 45 - 54, loginButton.bottom+13, 54, 19);
    
    [registButton setTitle:@"免费注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [registButton addTarget:self action:@selector(registButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    //忘记密码
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordButton.frame = CGRectMake(20, loginButton.bottom+15, 80, 15);
    
    [passwordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    [passwordButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [passwordButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    passwordButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [passwordButton addTarget:self action:@selector(passwordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwordButton];

    //免密登录
    UIButton *avoidCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    avoidCloseButton.tag = 200;
    avoidCloseButton.frame = CGRectMake(kScreenWidth/2 - 40, loginButton.bottom+15, 80, 15);
    
    [avoidCloseButton setTitle:@"免密登录" forState:UIControlStateNormal];
    [avoidCloseButton setTitle:@"密码登录" forState:UIControlStateSelected];

    [avoidCloseButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    avoidCloseButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [avoidCloseButton addTarget:self action:@selector(avoidCloseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:avoidCloseButton];
    
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.view addGestureRecognizer:singleRecognizer];

    
}

- (void)singleAction{

    _XHImageV.hidden = YES;
}

//显示闲货视图
- (void)showButtonAction{

    _XHImageV.hidden = NO;
    
}


//免密登录
- (void)avoidCloseButtonAction:(UIButton*)bt{
    
    bt.selected = !bt.selected;
    
    if (bt.selected) {
        
        UIImageView *imageV = [self.view viewWithTag:121];
        imageV.image = [UIImage imageNamed:@"验证码"];
        
        UIButton *button = (UIButton*)[self.view viewWithTag:120];
        button.hidden = NO;
        
        passwordTextField.width = 100;
        passwordTextField.placeholder = @"请输入验证码";

    }else{
        
        UIImageView *imageV = [self.view viewWithTag:121];
        imageV.image = [UIImage imageNamed:@"密码"];
        UIButton *button = (UIButton*)[self.view viewWithTag:120];
        button.hidden = YES;
        passwordTextField.width = 150;
        passwordTextField.placeholder = @"请输入密码";

    }
    

}


//忘记密码
- (void)passwordButtonAction{
    
    PasswordRecoveryViewController *passwordRecoveryVC = [[PasswordRecoveryViewController alloc]init];
    
    [self presentViewController:passwordRecoveryVC animated:YES completion:nil];
    
}


//获取验证码
- (void)codeButtonAction:(UIButton*)bt{
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    
    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":phoneTextField.text,@"code_type":@"3"} mutableCopy] success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
//            alertV.message = @"发送成功";
//            [alertV show];
            codeButton.userInteractionEnabled = NO;
            
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


//登录
- (void)loginButtonAction{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    

    UIButton *button = [self.view viewWithTag:200];
    NSString *url;
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }else{
        [params setObject:phoneTextField.text forKey:@"mobile"];
    }

    if (!button.selected) {
        
        if ([passwordTextField.text isEqualToString:@""]) {
            alertV.message = @"密码不能为空";
            [alertV show];
            return;
        }else{
            
            [params setObject:passwordTextField.text forKey:@"password"];
        }
        
        url = master_loginhtmlA_API;

    }else{
        if ([passwordTextField.text isEqualToString:@""]) {
            alertV.message = @"验证码不能为空";
            [alertV show];
            return;
        }else{
            
            [params setObject:passwordTextField.text forKey:@"code"];
        }
        url = child_loginhtml_API;
    
    }

    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
//            OnePublishingViewController *OnePublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OnePublishingViewController"];
//            
//            UINavigationController *naviC = [[UINavigationController alloc]initWithRootViewController:OnePublishingVC];
//            
            BaseTabBarController *baseTabBarC = [[BaseTabBarController alloc]init];
            
            
            [UIApplication sharedApplication].keyWindow.rootViewController = baseTabBarC;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NULLHandle NUllHandle:result[@"result"][@"data"]]];
            
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic[@"shopinfo"]];
            [dic setObject:dic1 forKey:@"shopinfo"];
            [dic setObject:passwordTextField.text forKey:@"password"];
            
            [defaults setObject:dic forKey:@"SYGData"];
            
            [defaults synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataNotifocation" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
            
            [JPUSHService setTags:[NSSet setWithObjects:result[@"result"][@"data"][@"shop_id"],nil] alias:result[@"result"][@"data"][@"id"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"%d %@ %@",iResCode,iTags,iAlias);
            }];

        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

//注册
- (void)registButtonAction{

    RegistViewController *registVC = [[RegistViewController alloc]init];
    
    [self presentViewController:registVC animated:YES completion:nil];
    
}


//主账号选择
- (void)mainButtonAction:(UIButton*)bt{

    if (bt.selected == NO) {
        UIButton *sonButton = (UIButton*)[self.view viewWithTag:102];
        
        sonButton.selected = NO;
        bt.selected = YES;
        phoneTextField.text = @"";
        passwordTextField.text = @"";


        [bt addSubview:_selectImageV];
    }
    
}

//子帐号选择
- (void)sonButtonAction:(UIButton*)bt{

    if (bt.selected == NO) {
        
        UIButton *mainButton = (UIButton*)[self.view viewWithTag:101];
        mainButton.selected = NO;
        bt.selected = YES;
//        UIImageView *imageV = [self.view viewWithTag:121];
//        imageV.image = [UIImage imageNamed:@"验证码"];
//
//        UIButton *button = (UIButton*)[self.view viewWithTag:120];
//        button.hidden = NO;
        phoneTextField.text = @"";
        passwordTextField.text = @"";
//        passwordTextField.secureTextEntry = NO;
//        passwordTextField.placeholder = @"请输入验证码";
        
        [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

        [bt addSubview:_selectImageV];

    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (int i = 0; i < 2; i++) {
        
        UITextField *textField = [self.view viewWithTag:110+i];
        [textField resignFirstResponder];
    }
    
}

@end
