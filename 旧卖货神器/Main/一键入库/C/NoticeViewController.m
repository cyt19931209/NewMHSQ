//
//  NoticeViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/13.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeOneCell.h"
#import "NoticeTwoTableViewCell.h"
#import "NoticeThreeCell.h"
#import "WebViewController.h"
#import "ReleaseHistoryViewController.h"
#import "MJRefresh.h"
#import "JPUSHService.h"
#import "PartnerDetailsViewController.h"
#import "NewPartnerViewController.h"


@interface NoticeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{

    NSInteger page;
    
    NSInteger row;

    NSString *shop_id;
    
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    page = 1;

    row = 1;
    
    self.navigationItem.title = @"系统通知";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    _dataArr = [NSMutableArray array];
    
    //左边Item
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 10, 19);
//    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.separatorStyle = NO;
    
    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"NoticeOneCell" bundle:nil] forCellReuseIdentifier:@"NoticeOneCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"NoticeTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeTwoTableViewCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"NoticeThreeCell" bundle:nil] forCellReuseIdentifier:@"NoticeThreeCell"];
    
    if (_isNotifation) {
        
        [self pushNotifation];
        
    }else{
        
        [self loadData];
    
    }
    __weak NoticeViewController *weakSelf = self;

    //下拉刷新
    
    _myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        
        [weakSelf loadData];
        
    }];
    
    //上拉加载
    
    _myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page ++;
        
        [weakSelf loadData];
        
    }];
    
}

//通知跳转
- (void)pushNotifation{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:@"position" forKey:@"act"];
    
    [params setObject:_noticeId forKey:@"id"];
    
    [DataSeviece requestUrl:get_jpushhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] integerValue] == 1) {
            
            page = [result[@"result"][@"data"][@"page"] integerValue];
            
            row = [result[@"result"][@"data"][@"row"] integerValue];
            
            [self loadData];
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (void)loadData{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    [JPUSHService setBadge:0];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:@"list"forKey:@"act"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];

    [DataSeviece requestUrl:get_jpushhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if (page == 1) {
            
            [_dataArr removeAllObjects];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_dataArr addObject:dic];
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_myTableView reloadData];
        
        //        NSUInteger ii[2] = {0, rowCount - 1};
        //        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
        //
        
        if (_isNotifation) {
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row - 1 inSection:0];
            
            [_myTableView scrollToRowAtIndexPath:indexPath
                                atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dic = _dataArr[indexPath.row];
    
    if ([dic[@"type"] isEqualToString:@"news"]) {
       
        NoticeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeOneCell" forIndexPath:indexPath];
        
        cell.dic = _dataArr[indexPath.row];
        
        return cell;
        
    }else if ([dic[@"type"] isEqualToString:@"text"]||[dic[@"type"] isEqualToString:@"joinsuccessfriend"]||[dic[@"type"] isEqualToString:@"joinfriend"]){
    
        NoticeTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeTwoTableViewCell" forIndexPath:indexPath];
        
        cell.dic = _dataArr[indexPath.row];
        
        return cell;

    }else if ([dic[@"type"] isEqualToString:@"deletegoods"]){
        
        NoticeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeThreeCell" forIndexPath:indexPath];
        
        cell.dic = _dataArr[indexPath.row];
        
        return cell;

        
    }else if ([dic[@"type"] isEqualToString:@"addgoods"]||[dic[@"type"] isEqualToString:@"followfriend"]){
        
        NoticeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeThreeCell" forIndexPath:indexPath];
        
        cell.dic = _dataArr[indexPath.row];
        
        return cell;

    }

    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = _dataArr[indexPath.row];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:dic[@"id"] forKey:@"jpush_id"];

    [DataSeviece requestUrl:set_readhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] integerValue] == 1) {
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:dic];
            
            [dic1 setObject:@"1" forKey:@"is_read"];

            [_dataArr replaceObjectAtIndex:indexPath.row withObject:[dic1 copy]];
            
            [_myTableView reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
    if ([dic[@"type"] isEqualToString:@"followfriend"]) {

        
        PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
        
        PartnerDetailsVC.shop_id = _dataArr[indexPath.row][@"shop_id"];
        
        PartnerDetailsVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:PartnerDetailsVC animated:YES];
        
        
    }
    
    
    
    if ([dic[@"type"] isEqualToString:@"news"]) {
        
        WebViewController *webVC = [[WebViewController alloc]init];
        
        webVC.isNotifation = YES;
        webVC.urlStr = dic[@"url"];
        
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else if ([dic[@"type"] isEqualToString:@"text"]){
        
    }else if ([dic[@"type"] isEqualToString:@"deletegoods"]){
        
        ReleaseHistoryViewController *ReleaseHistoryVC = [[ReleaseHistoryViewController alloc]init];
        ReleaseHistoryVC.is_delete = @"1";
        ReleaseHistoryVC.isNotifation = YES;
        ReleaseHistoryVC.goods_id = dic[@"goods_id"];
        [self.navigationController pushViewController:ReleaseHistoryVC animated:YES];
        
        
    }else if ([dic[@"type"] isEqualToString:@"addgoods"]){
        
        ReleaseHistoryViewController *ReleaseHistoryVC = [[ReleaseHistoryViewController alloc]init];
        ReleaseHistoryVC.is_delete = @"2";
        ReleaseHistoryVC.isNotifation = YES;
        ReleaseHistoryVC.goods_id = dic[@"goods_id"];

        [self.navigationController pushViewController:ReleaseHistoryVC animated:YES];
        
    }else if ([dic[@"type"] isEqualToString:@"joinsuccessfriend"]){
        
        [params setObject:dic[@"goods_id"]forKey:@"friend_shop_id"];
        
        [DataSeviece requestUrl:get_friend_shop_statushtml params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] integerValue] == 1) {
               
                PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
                
                PartnerDetailsVC.shop_id = dic[@"goods_id"];
                
                [self.navigationController pushViewController:PartnerDetailsVC animated:YES];
                
            }else{
                
                shop_id = dic[@"goods_id"];
                
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"好友关系已解除,是否发送好友请求" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                [alertV show];

            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
    
            
        }];
        
        
    }else if ([dic[@"type"] isEqualToString:@"joinfriend"]){
        
        NewPartnerViewController *NewPartnerVC = [[NewPartnerViewController alloc]init];
        
        
        [self.navigationController pushViewController:NewPartnerVC animated:YES];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _dataArr[indexPath.row];
    
    if ([dic[@"type"] isEqualToString:@"news"]) {
        
        CGRect rect = [dic[@"content"] boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} context:nil];
        
        return 340 - 36 + rect.size.height;

        
    }else if ([dic[@"type"] isEqualToString:@"text"]||[dic[@"type"] isEqualToString:@"joinsuccessfriend"]||[dic[@"type"] isEqualToString:@"joinfriend"]){
        
        CGRect rect = [dic[@"content"] boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} context:nil];
        
        return 300 - 216 + rect.size.height;
        
    }else if ([dic[@"type"] isEqualToString:@"deletegoods"]){
        
       CGRect rect = [dic[@"content"] boundingRectWithSize:CGSizeMake(kScreenWidth - 45, 1000) options:NSStringDrawingUsesFontLeading attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} context:nil];
        
//        NSLog(@"%lf",rect.size.height);
        
        return 110 - 21 + rect.size.height;
        
        
    }else if ([dic[@"type"] isEqualToString:@"addgoods"]||[dic[@"type"] isEqualToString:@"followfriend"]){
        
        CGRect rect = [dic[@"content"] boundingRectWithSize:CGSizeMake(kScreenWidth - 45, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} context:nil];
        
//        NSLog(@"%lf",rect.size.height);

        
        return 110 - 21 + rect.size.height;
        
    }

    
    return 0;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
//       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#ffffff"]}];
//    
//
//    UIImage *image = [UIImage imageNamed:@"BGTP"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setShadowImage:nil];
    
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


- (void)leftBtnAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}





@end
