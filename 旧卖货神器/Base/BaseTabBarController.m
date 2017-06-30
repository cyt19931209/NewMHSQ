//
//  BaseTabViewController.m
//  Weibo55
//
//  Created by phc on 15/12/1.
//  Copyright (c) 2015年 phc. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ReleaseHistoryViewController.h"
#import "NoticeViewController.h"
#import "SettingViewController.h"
#import "HomeViewController.h"
#import "GoodsViewController.h"


@interface BaseTabBarController ()

@property (nonatomic,strong) UIView *redView;

@property (nonatomic,strong) UIImageView *selectImageV;


@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTabBarNotification:) name:@"selectTabBarNotification" object:nil];
//
    /**
     *  1.加载子控制器
     */

    [self creactSubC];
    
    [self creactTabBar];
}

- (void)creactSubC{
    
    UINavigationController *sellingGoodsVC = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
    
    UINavigationController *supplyGoodsVC = [[UINavigationController alloc]initWithRootViewController:[[GoodsViewController alloc]init]];

    UINavigationController *informationVC = [[UINavigationController alloc]initWithRootViewController:[[NoticeViewController alloc]init]];
    
    SettingViewController *settingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    UINavigationController *myVC = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    NSArray *viewC = @[sellingGoodsVC,supplyGoodsVC,informationVC,myVC];

    self.viewControllers = viewC;
    
}

- (void)creactTabBar{
    
    
    //设置背景
    UIImageView * tabaImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    tabaImg.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    [self.tabBar addSubview:tabaImg];
    
    tabaImg.layer.borderColor = [RGBColor colorWithHexString:@"#dddddd"].CGColor;
    tabaImg.layer.borderWidth = 1;
    
    NSArray *imgArr = @[
                        @"home",
                        @"huoyuan",
                        @"xiaoxi",
                        @"wode",
                        ];
    float itemWidth = kScreenWidth/4;
    
    for (int i = 0; i< imgArr.count; i ++) {
        
        NSString *imgName = imgArr[i];
//        NSString *selectImgName = selectImgArr[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*itemWidth, 2, itemWidth, 45);
//        [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
        imageV.image = [UIImage imageNamed:imgName];
        imageV.tag = 1100+i;
        imageV.center = button.center;
        [self.tabBar addSubview:imageV];
        if (i == 0) {
            _selectImageV = imageV;
            imageV.image = [UIImage imageNamed:@"homexz"];
            
            _redView = [[UIView alloc]initWithFrame:CGRectMake(button.width/2 + 5, 10, 5, 5)];
            _redView.tag = 500;
            
            _redView.backgroundColor = [UIColor redColor];
            
            _redView.layer.cornerRadius = 2.5;
            
            _redView.layer.masksToBounds = YES;
            
            _redView.hidden = YES;
            
            [button addSubview:_redView];

        }
    }

}

- (void)buttonAction:(UIButton*)bt{
    
    
    if (self.selectedIndex == bt.tag - 1000&&bt.tag == 1000) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataTabBarNotification" object:nil];
        
    }
    
    self.selectedIndex = bt.tag - 1000;
    
    NSArray *imgArr = @[
                        @"home",
                        @"huoyuan",
                        @"xiaoxi",
                        @"wode",
                        ];

    NSArray *selectImgArr = @[
                        @"homexz",
                        @"huoyuanxz",
                        @"xiaoxixz",
                        @"wodexz",
                        ];

    UIImageView *imageV = [self.tabBar viewWithTag:bt.tag+100];
    
    if (imageV != _selectImageV) {
        
        imageV.image = [UIImage imageNamed:selectImgArr[bt.tag-1000]];
        _selectImageV.image = [UIImage imageNamed:imgArr[_selectImageV.tag-1100]];
        _selectImageV = imageV;

    }
    
    [self loadData];

}

- (void)loadData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_increase_numshtml params:params success:^(id result) {

        NSLog(@"%@",result);
    
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            if ([result[@"result"][@"data"][@"nums"] isEqualToString:@"0"]) {
                
                _redView.hidden = YES;
                
            }else{
                
                _redView.hidden = NO;
            }
            

        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];


}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self removeTaBarButton];

}

- (void)removeTaBarButton{
    
    for (UIView *view in self.tabBar.subviews) {
        
        if([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [view removeFromSuperview];
        }
    }
    
}
//
//- (void)selectTabBarNotification:(NSNotification*)noti{
//    
//
//    
//    NSArray *imgArr = @[
//                        @"卖货黑",
//                        @"货源黑",
//                        @"信息黑",
//                        @"我的黑",
//                        ];
//    
//    NSArray *selectImgArr = @[
//                              @"卖货红",
//                              @"货源红",
//                              @"信息红",
//                              @"我的红",
//                              ];
//    
//    
//    UIImageView *imageV = [self.tabBar viewWithTag:1100 + [[noti object] integerValue]];
//    
//    if (imageV != _selectImageV) {
//        
//        imageV.image = [UIImage imageNamed:selectImgArr[[[noti object] integerValue]]];
//        _selectImageV.image = [UIImage imageNamed:imgArr[_selectImageV.tag-1100]];
//        
//        _selectImageV = imageV;
//        
//    }
//
//}
//
//- (void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//}
@end
