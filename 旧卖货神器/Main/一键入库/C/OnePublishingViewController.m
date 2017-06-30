//
//  OnePublishingViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "OnePublishingViewController.h"
#import "SettingViewController.h"
#import "OneButtonPublishingViewController.h"
#import "AccountListViewController.h"
#import "ReleaseHistoryViewController.h"
#import "NoticeViewController.h"

@interface OnePublishingViewController (){

    UILabel *rightLabel;
    
    UIScrollView *myScrollView;
    
    NSArray *typeArr;
    
    NSArray *nameArr;
}


@property (weak, nonatomic) IBOutlet UILabel *SPSLLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SPSLLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginHeight;

@end

@implementation OnePublishingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"一键发布";
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];

    nameArr = @[@"胖虎",@"爱丁猫",@"微店",@"猎趣",@"心上",@"少铺",@"小红书",@"爱丁猫专业版",@"爱丁猫商家版",@"旧爱"];
    
//    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 27)];
//    
//    [self.view addSubview:rightView];
//    
//    rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 12, 12)];
//    
//    rightLabel.backgroundColor = [RGBColor colorWithHexString:@"#ee0303"];
//    
//    rightLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
//    
//    rightLabel.font = [UIFont systemFontOfSize:10];
//    
//    rightLabel.textAlignment = NSTextAlignmentCenter;
//    
//    rightLabel.layer.cornerRadius = 6;
//    
//    rightLabel.layer.masksToBounds = YES;
//    
//    rightLabel.text = @"";
//    
//    rightLabel.hidden = YES;
//    
//    [rightView addSubview:rightLabel];
//    
//    _SPSLLabel.layer.cornerRadius = 7.5;
//    
//    _SPSLLabel.layer.masksToBounds = YES;
//    

    //右边
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 5, 22, 22);
//    [rightBtn setImage:[UIImage imageNamed:@"tonz"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [rightView addSubview:rightBtn];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
//    
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    
//    _loginHeight.constant = 380.0/720.0*kScreenWidth;
//    
//    if (kScreenWidth < 375) {
//        
//        _SPSLLeft.constant = 61;
//        
//    }else{
//        
//        if (kScreenWidth < 400) {
//            
//            _SPSLLeft.constant = 81;
//            
//        }else{
//        
//            _SPSLLeft.constant = 85;
//        }
//    }

    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, kScreenWidth, 30);
    label.text = @"   老板，要将商品发布到哪些平台呢？";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    label.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:label];
    
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];

    
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 32 , kScreenWidth, kScreenHeight - 32 - 64)];
    
    myScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [myScrollView showsVerticalScrollIndicator];
    
    [self.view addSubview:myScrollView];
    

    for (int i = 0; i < nameArr.count; i++) {
        
        NSInteger row = i%4;
        
        NSInteger section = i/4;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"底板选中.png"] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"底板未选.png"] forState:UIControlStateSelected];

        button.tag = 400 + i;
        
        button.frame = CGRectMake((kScreenWidth - 312)/5 + ((kScreenWidth - 312)/5 + 78)*row , section * 110, 78, 78);
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [myScrollView addSubview:button];
        
        
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, 14, 50, 50)];
        
        typeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@50",nameArr[i]]];
        
        typeImage.tag = 200;
        
        [button addSubview:typeImage];
        
        UIImageView *selectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(37, 3, 38, 39)];
        
        selectImageV.image = [UIImage imageNamed:@"标签.png"];
        
        selectImageV.tag = 100;
        
        [button addSubview:selectImageV];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(button.left, button.bottom, 78, 20)];
        
        label.text = nameArr[i];
        
        label.tag = 300 + i;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        label.numberOfLines = 0;
        
        [myScrollView addSubview:label];
        
        if (i == 7|| i == 8) {
            
            label.height = 40;
            
        }

    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(kScreenWidth/2 - 40, 110 * 3 + 34, 92, 48);
    
    [button setImage:[UIImage imageNamed:@"btn normal.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [myScrollView addSubview:button];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, button.bottom + 11, kScreenWidth, 14);
    label1.text = @"一键发布";
    label1.font = [UIFont fontWithName:@".PingFangSC-Regular" size:14];
    label1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    label1.textAlignment = NSTextAlignmentCenter;
    
    [myScrollView addSubview:label1];
    
    myScrollView.contentSize = CGSizeMake(kScreenWidth, 110 * 3 + 100);
    
}

//勾选平台
- (void)buttonAction:(UIButton*)sender{
    
    UILabel *label = [myScrollView viewWithTag:sender.tag - 100];
    
    UIImageView *typeImage = [sender viewWithTag:200];
    
    UIImageView *selectImageV = [sender viewWithTag:100];
    
    
    if (!sender.selected) {
        
        label.textColor = [RGBColor colorWithHexString:@"#cccccc"];
 
        selectImageV.hidden = YES;
        
        typeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@50qs",nameArr[sender.tag - 400]]];;

    }else{
    
        label.textColor = [RGBColor colorWithHexString:@"#666666"];

        selectImageV.hidden = NO;
        
        typeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@50",nameArr[sender.tag - 400]]];;

    }
    
    sender.selected = ! sender.selected;

}


- (void)rightBtnAction{

    NoticeViewController *NoticeVC = [[NoticeViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:NoticeVC];

    [self presentViewController:nav animated:YES completion:nil];

}

//菜单
- (void)leftBtnAction{
    
//    SettingViewController *settingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
//    
//    [self.navigationController pushViewController:settingVC animated:YES];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    UIImage *image = [UIImage imageNamed:@"bg_clear"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setShadowImage:image];
//    
//    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//
//    [self loadData];
    
    self.navigationItem.title = @"一键发布";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableArray *selectTypeArr = [NSMutableArray array];
    
    for (int i = 0; i < typeArr.count; i++) {
        
        UIButton *button = [myScrollView viewWithTag:400 +i];
        
        if (button.selected == NO) {
            
            [selectTypeArr addObject:typeArr[i]];

        }
    }
    
    [defaults setObject:[selectTypeArr copy] forKey:[NSString stringWithFormat:@"%@Type",SYGData[@"id"]]];
    
    [defaults synchronize];

    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;

}

//加载
- (void)loadData{
    
    for (int i = 0; i < typeArr.count; i++) {
        
        UIButton *button = [myScrollView viewWithTag:400 + i];
        
        UILabel *label = [myScrollView viewWithTag:300 + i];
        
        UIImageView *selectImageV = [button viewWithTag:100];
        
        UIImageView *typeImageV = [button viewWithTag:200];
        
        selectImageV.hidden = YES;
        
        typeImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@50qs",nameArr[i]]];;
        
        button.selected = YES;
        
        label.textColor = [RGBColor colorWithHexString:@"#cccccc"];
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSArray *selectTypeArr = [defaults objectForKey:[NSString stringWithFormat:@"%@Type",SYGData[@"id"]]];
    
    for (int i = 0 ; i < typeArr.count; i++) {
        
        UIButton *button = [myScrollView viewWithTag:400 + i];
        
        UILabel *label = [myScrollView viewWithTag:300 + i];
        
        UIImageView *selectImageV = [button viewWithTag:100];
        
        UIImageView *typeImageV = [button viewWithTag:200];
        
        if ([selectTypeArr containsObject:typeArr[i]]) {
            
            selectImageV.hidden = NO;
            typeImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@50",nameArr[i]]];;
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            button.selected = NO;
            
        }

    }
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params1 setObject:@"unread" forKey:@"act"];
    

    [DataSeviece requestUrl:get_jpushhtml params:params1 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);

        if ([result[@"result"][@"data"][@"unread_nums"] integerValue] == 0) {
            
            rightLabel.hidden = YES;
            
        }else if ([result[@"result"][@"data"][@"unread_nums"] integerValue] > 99){
        
            rightLabel.hidden = NO;
            
            rightLabel.width = 16;

            rightLabel.text = @"...";
        }else if ([result[@"result"][@"data"][@"unread_nums"] integerValue] > 9){
            
            rightLabel.hidden = NO;
            
            rightLabel.width = 16;
            
            rightLabel.text = result[@"result"][@"data"][@"unread_nums"];
            
        }else {
            
            rightLabel.hidden = NO;
            
            rightLabel.width = 12;
            
            rightLabel.text = result[@"result"][@"data"][@"unread_nums"];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    [DataSeviece requestUrl:get_recently_friend_goods_counthtml params:params1 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"data"][@"count"] integerValue] == 0) {
            
            _SPSLLabel.hidden = YES;
            
        }else if ([result[@"result"][@"data"][@"count"] integerValue] > 99){
            
            _SPSLLabel.hidden = NO;
            
            _SPSLLabel.text = @"99";
        }else{
            
            _SPSLLabel.hidden = NO;
            
            _SPSLLabel.text = result[@"result"][@"data"][@"count"];
        
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


- (IBAction)pushAction:(id)sender {
    

    NSMutableArray *selectTypeArr = [NSMutableArray array];
    
    for (int i = 0; i < typeArr.count; i++) {
        
        UIButton *button = [myScrollView viewWithTag:400 + i];
        
        if (button.selected == NO) {
            
            [selectTypeArr addObject:typeArr[i]];
            
        }

    }
    
    OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
    
    OneButtonPublishingVC.isOnePush = YES;
    
    OneButtonPublishingVC.typeArr = typeArr;
    
    OneButtonPublishingVC.selectTypeArr = selectTypeArr;
    
    [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];

    
}
- (IBAction)settingAction:(id)sender {
    
    SettingViewController *settingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
}
- (IBAction)myAction:(id)sender {
    
    ReleaseHistoryViewController *ReleaseHistoryVC = [[ReleaseHistoryViewController alloc]init];
    ReleaseHistoryVC.is_delete = @"2";
    [self.navigationController pushViewController:ReleaseHistoryVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
    
}






@end
