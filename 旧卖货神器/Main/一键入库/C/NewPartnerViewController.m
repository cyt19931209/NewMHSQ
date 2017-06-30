//
//  NewPartnerViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/5.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "NewPartnerViewController.h"
#import "NewPartnerCell.h"
#import "PartnerDetailsViewController.h"

@interface NewPartnerViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{

    NSString *shop_id;
}


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation NewPartnerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = @"新的同行";
    
    _dataArr = [NSMutableArray array];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NewPartnerNotification:) name:@"NewPartnerNotification" object:nil];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    
    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"NewPartnerCell" bundle:nil] forCellReuseIdentifier:@"NewPartnerCell"];

    [self loadData];

}

- (void)loadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_friend_applyhtml params:params success:^(id result) {
        
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        [_dataArr removeAllObjects];
        
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"friend_list"]) {
            
            [_dataArr addObject:dic];
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
    
    NewPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewPartnerCell"];
    
    cell.dic = _dataArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSDictionary *dic = _dataArr[indexPath.row];
    
    if ([dic[@"status"] isEqualToString:@"4"]) {
     
        shop_id = dic[@"friend_shop_id"];
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否发送好友请求" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertV show];
        
    }else if ([dic[@"status"] isEqualToString:@"2"]){
    
        PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
        
        PartnerDetailsVC.shop_id = dic[@"friend_shop_id"];
        
        [self.navigationController pushViewController:PartnerDetailsVC animated:YES];
        
    }
    
    

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

- (void)NewPartnerNotification:(NSNotification*)noti{
    
//    NSString *str = [noti object];
    
    
    [self loadData];

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
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

-  (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        //发送申请

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:shop_id forKey:@"friend_shop_id"];
        
        [DataSeviece requestUrl:Friendaddhtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {

                
                [alertV show];
  
            }else{

                alertV.message = result[@"result"][@"msg"];
                
                [alertV show];

            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
    }

}


-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
