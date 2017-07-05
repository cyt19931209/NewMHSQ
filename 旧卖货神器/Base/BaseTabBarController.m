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
#import "ChatListViewController.h"

@interface BaseTabBarController ()<UITabBarDelegate>

@property (nonatomic,strong) UIView *redView;

@property (nonatomic,strong) UIImageView *selectImageV;

@property (nonatomic,strong) UILabel *numberLabel;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushNumberNotification) name:@"PushNumberNotification" object:nil];

    /**
     *  1.加载子控制器
     */
    
//    [self removeTaBarButton];
    
    [self creactSubC];
    
//    [self creactTabBar];
    
}

- (void)creactSubC{
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    self.tabBar.tintColor=[RGBColor colorWithHexString:@"949dff"];;

    
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

    
    UINavigationController *sellingGoodsVC = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
    
    [sellingGoodsVC.tabBarItem setImage:[UIImage imageNamed:imgArr[0]]];
    
    [sellingGoodsVC.tabBarItem setSelectedImage:[UIImage imageNamed:selectImgArr[0]]];
    
    sellingGoodsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    UINavigationController *supplyGoodsVC = [[UINavigationController alloc]initWithRootViewController:[[GoodsViewController alloc]init]];
    
    [supplyGoodsVC.tabBarItem setImage:[UIImage imageNamed:imgArr[1]]];
    
    [supplyGoodsVC.tabBarItem setSelectedImage:[UIImage imageNamed:selectImgArr[1]]];

    supplyGoodsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

    
    UINavigationController *informationVC = [[UINavigationController alloc]initWithRootViewController:[[ChatListViewController alloc]init]];
    
    [informationVC.tabBarItem setImage:[UIImage imageNamed:imgArr[2]]];
    
    [informationVC.tabBarItem setSelectedImage:[UIImage imageNamed:selectImgArr[2]]];
    
    informationVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);


    SettingViewController *settingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    UINavigationController *myVC = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    [myVC.tabBarItem setImage:[UIImage imageNamed:imgArr[3]]];
    
    [myVC.tabBarItem setSelectedImage:[UIImage imageNamed:selectImgArr[3]]];

    myVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

    NSArray *viewC = @[sellingGoodsVC,supplyGoodsVC,informationVC,myVC];

    self.viewControllers = viewC;
    
    
    _redView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4/2 + 5, 10, 5, 5)];
    
    _redView.tag = 500;
    
    _redView.backgroundColor = [UIColor redColor];
    
    _redView.layer.cornerRadius = 2.5;
    
    _redView.layer.masksToBounds = YES;
    
    _redView.hidden = YES;
    
    [self.tabBar addSubview:_redView];
    
    _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4/2 + 6 + kScreenWidth/4 * 2, 5, 14, 14)];
    
    _numberLabel.backgroundColor = [RGBColor colorWithHexString:@"#F5554A"];
    
    _numberLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    _numberLabel.font = [UIFont systemFontOfSize:12];
    
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    
    _numberLabel.layer.cornerRadius = 7;
    
    _numberLabel.layer.masksToBounds = YES;
    
    _numberLabel.hidden = YES;
    
    [self.tabBar addSubview:_numberLabel];

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{

    [super setSelectedIndex:selectedIndex];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    if (SYGData[@"id"]) {
        
        [self loadData];
    }
    

    
    
//    NSArray *imgArr = @[
//                        @"home",
//                        @"huoyuan",
//                        @"xiaoxi",
//                        @"wode",
//                        ];
//    
//    NSArray *selectImgArr = @[
//                              @"homexz",
//                              @"huoyuanxz",
//                              @"xiaoxixz",
//                              @"wodexz",
//                              ];
//
//    UIImageView *imageV = [self.tabBar viewWithTag:1100 + selectedIndex];
//
//    if (imageV != _selectImageV) {
//        
//        _selectImageV.image = [UIImage imageNamed:imgArr[_selectImageV.tag-1100]];
//
//        imageV.image = [UIImage imageNamed:selectImgArr[imageV.tag-1100]];
//        
//        _selectImageV = imageV;
//    }


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
        
        if (i == 2) {
            
            
            [self.tabBar addSubview:_numberLabel];

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
    
    
    NSLog(@"%ld %ld %ld",bt.tag,_selectImageV.tag,imageV.tag);

//    if (imageV != _selectImageV) {
    
    _selectImageV.image = [UIImage imageNamed:imgArr[_selectImageV.tag-1100]];

    imageV.image = [UIImage imageNamed:selectImgArr[bt.tag-1000]];
    
    _selectImageV = imageV;
    
    
//    }
    
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

    int number = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    
    NSLog(@"%d",number);
    
    if ( number == 0 || number == 0) {
        
        _numberLabel.hidden = YES;

    }else{

        
        _numberLabel.hidden = NO;
        
        _numberLabel.text = [NSString stringWithFormat:@"%d",number];

        if (number > 9) {
            
            _numberLabel.width = 20;
            
        }else if (number > 99){
        
            _numberLabel.width = 30;
            
            _numberLabel.text = @"99+";
            
        }
        
    }
    

}

- (void)PushNumberNotification{

    int number = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    
    NSLog(@"%d",number);
    
    if ( number < 0 || number == 0) {
        
        _numberLabel.hidden = YES;
        
    }else{
        

        _numberLabel.hidden = NO;
        
        _numberLabel.text = [NSString stringWithFormat:@"%d",number];
        
        if (number > 9) {
            
            _numberLabel.width = 20;
            
        }else if (number > 99){
            
            _numberLabel.width = 30;
            
            _numberLabel.text = @"99+";
            
        }
        
    }

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self removeTaBarButton];

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


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    [self loadData];
    
    
   UITabBarItem *bar = tabBar.items[self.selectedIndex];
    
    
    if (bar == item &&item == tabBar.items[0]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataTabBarNotification" object:nil];
        
    }
    
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
