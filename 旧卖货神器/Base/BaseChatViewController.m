//
//  BaseChatViewController.m
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import "BaseChatViewController.h"
#import "PartnerDetailsViewController.h"

@interface BaseChatViewController ()

@end

@implementation BaseChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 5, 18, 18);
    [rightBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;

    RCUserInfo *info = [[RCIM sharedRCIM] getUserInfoCache:self.targetId];

    
    NSLog(@"%@",info.name);
    
    if (info.name) {
        
        self.title = info.name;

    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    
}
//右边
- (void)rightBtnAction{
    
    NSLog(@"%@",self.targetId);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    NSString *RYUserId = serviceData[@"RYUserId"];
    
    NSLog(@"%@",RYUserId);

    
    [params setObject:[self.targetId substringWithRange:NSMakeRange(RYUserId.length, self.targetId.length - RYUserId.length)] forKey:@"user_id"];
    
    
    [DataSeviece requestUrl:get_user_infohtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            
            PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
            
            PartnerDetailsVC.shop_id = result[@"result"][@"data"][@"shop_id"];
            
            [self.navigationController pushViewController:PartnerDetailsVC animated:YES];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}


//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNumberNotification" object:nil];

    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
