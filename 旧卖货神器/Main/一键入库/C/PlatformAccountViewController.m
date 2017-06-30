//
//  PlatformAccountViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PlatformAccountViewController.h"
#import "AccountBindingViewController.h"
#import "AccountListViewController.h"

@interface PlatformAccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ponhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *aidingmaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiboLabel;
@property (weak, nonatomic) IBOutlet UILabel *xinshangLabel;
@property (weak, nonatomic) IBOutlet UILabel *shaopuLabel;
@property (weak, nonatomic) IBOutlet UILabel *ADMZYLabel;
@property (weak, nonatomic) IBOutlet UILabel *ADMSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *JALabel;
@property (weak, nonatomic) IBOutlet UILabel *XHSLabel;
@property (weak, nonatomic) IBOutlet UILabel *LQLabel;




@property (nonatomic,strong) NSDictionary *dataDic;

@end

@implementation PlatformAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectTypeNotification) name:@"SelectTypeNotification" object:nil];

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
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self loadData];
}

//加载
- (void)loadData{
    
    _ponhuLabel.text = @"去绑定账号";
    _aidingmaoLabel.text = @"去绑定账号";
    _weiboLabel.text = @"去绑定账号";
    _xinshangLabel.text = @"去绑定账号";
    _ADMZYLabel.text = @"去绑定账号";
    _ADMSJLabel.text = @"去绑定账号";
    _JALabel.text = @"去绑定账号";
    _XHSLabel.text = @"去绑定账号";
    _LQLabel.text = @"去绑定账号";

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"newshang",@"shopuu",@"aidingmaopro",@"aidingmaomer",@"jiuai",@"xiaohongshu",@"liequ"];

    _imageV1.hidden = YES;
    _imageV2.hidden = YES;
    _imageV3.hidden = YES;
//    _imageV4.hidden = YES;
    _imageV5.hidden = YES;
    _imageV6.hidden = YES;
//    _imageV7.hidden = YES;
    _imageV8.hidden = YES;
    _imageV9.hidden = YES;
    _imageV10.hidden = YES;
    _imageV12.hidden = YES;
    _imageV13.hidden = YES;

    
    for (int i = 0 ; i < typeArr.count; i++) {
        
        [params setObject:@"1" forKey:@"is_default"];

        [params setObject:typeArr[i] forKey:@"type"];
        
        [DataSeviece requestUrl:Shareget_share_accounthtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            NSArray *arr = result[@"result"][@"data"][@"item"];
            
            for (NSDictionary *dic in arr) {
                
                if ([dic[@"is_default"] isEqualToString:@"1"]) {
                    
                    UIImageView *imageV = [self.tableView viewWithTag:100+i];

                    if (![dic[@"status"] isEqualToString:@"1"]) {
                        imageV.hidden = NO;
                    }
                    
                    if (i == 0) {
                        _ponhuLabel.text = dic[@"phone"];
                    }else if (i == 1){
                        _aidingmaoLabel.text = dic[@"phone"];
                    }else if (i == 2){
                        _weiboLabel.text = dic[@"phone"];
                    }else if (i == 3){
                        _xinshangLabel.text = dic[@"phone"];
                    }else if (i == 4){
                        _shaopuLabel.text = dic[@"phone"];
                    }else if (i == 5){
                        _ADMZYLabel.text = dic[@"phone"];
                    }else if (i == 6){
                        _ADMSJLabel.text = dic[@"phone"];
                    }else if (i == 7){
                        _JALabel.text = dic[@"phone"];
                    }else if (i == 8){
                        _XHSLabel.text = dic[@"phone"];
                    }else if (i == 9){
                        _LQLabel.text = dic[@"phone"];
                    }

                }
            }
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
            
    }
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"newshang",@"shopuu",@"aidingmaopro",@"aidingmaomer",@"jiuai",@"xiaohongshu",@"liequ"];
    
    AccountListViewController *AccountListVC = [[AccountListViewController alloc]init];
    
    AccountListVC.titleStr = typeArr[indexPath.row];
    
    [self.navigationController pushViewController:AccountListVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
    
}

- (void)SelectTypeNotification{
    
    [self loadData];
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)weiboLoginByResponse:(WBBaseResponse *)response{
    
    NSDictionary *dic = (NSDictionary *) response.requestUserInfo;
    
    NSLog(@"userinfo %@",dic);
    
}



@end
