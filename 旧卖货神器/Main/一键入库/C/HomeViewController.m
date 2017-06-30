//
//  HomeViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/6/6.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "HomeViewController.h"
#import "UIButton+WebCache.h"
#import "ReleaseHistoryCell.h"
#import "MJRefresh.h"
#import "ReleaseHistoryModel.h"
#import "OnePublishingViewController.h"
#import "ReleaseHistoryViewController.h"
#import "FinanceViewController.h"
#import "OneButtonPublishingViewController.h"

@interface HomeViewController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>{

    UIButton *leftBtn;

    UIButton *rightBtn;
    
    UIButton *rightBtn1;

    UIButton *homeButton;
    
    NSInteger page;
    
    UIImageView *BQimageV;
    
    UILabel* BQlabel;
    

    NSString *typeStr;
    
}

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    typeStr = @"all";
    
    page = 1;
    
    _dataArr = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataNotification:) name:@"UpDataNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextViewNotification:) name:@"TextViewNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TypeSelectNotification:) name:@"TypeSelectNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DelegateNotification:) name:@"DelegateNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataNotification:) name:@"editPhotoNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DLTextViewNotification:) name:@"DLTextViewNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataTabBarNotification) name:@"UpDataTabBarNotification" object:nil];

    
    //左边Item
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);

    leftBtn.backgroundColor = [RGBColor colorWithHexString:@"D8D8D8"];
    
    leftBtn.layer.cornerRadius = 20;
    
    leftBtn.layer.masksToBounds = YES;
    
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 5, 22, 22);
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 5, 22, 22);
    [rightBtn1 setImage:[UIImage imageNamed:@"fbtj"] forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(rightBtnAction1) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    
    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem];

    
    homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    homeButton.frame = CGRectMake(0, 0, 63, 22);
    
    
    [homeButton setTitleColor:[RGBColor colorWithHexString:@"949DFF"] forState:UIControlStateNormal];
    
    [homeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0, 13)];
    
    [homeButton setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0,0)];
    
    homeButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [homeButton setImage:[UIImage imageNamed:@"jtdown"] forState:UIControlStateNormal];
    
    [homeButton setTitle:@"全部" forState:UIControlStateNormal];

    [homeButton addTarget:self action:@selector(homeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = homeButton;

    [self creatUI];
    
    [self loadData];
    
}

//UI
- (void)creatUI{
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ReleaseHistoryCell" bundle:nil] forCellReuseIdentifier:@"ReleaseHistoryCell"];

    //下拉刷新
    
    __weak HomeViewController *weakSelf = self;

    
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

- (void)loadData{
    
    [BQimageV removeFromSuperview];
    [BQlabel removeFromSuperview];
    

    UIView *redView = [self.tabBarController.tabBar viewWithTag:500];

    redView.hidden = YES;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    NSString *url = @"";
    
    url = ShareGoodsget_goods_listhtml;

    [params setObject:typeStr forKey:@"type"];
    
    
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if (result[@"result"][@"data"][@"increase"]) {
            

            if (![result[@"result"][@"data"][@"increase"] isEqualToString:@"0"]) {
                
                // 提示用户最新的数量

                [self showNewStatusesCount:[result[@"result"][@"data"][@"increase"] intValue]];
                
            }
            
        }
        
        
        if (page == 1) {
            
            [_dataArr removeAllObjects];
            
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            BOOL isCopy = NO;
            
            for (NSDictionary *dic1 in _dataArr) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
                    isCopy = YES;
                }
            }
            
            if (!isCopy) {
                
                ReleaseHistoryModel *model = [[ReleaseHistoryModel alloc]init];
                
                model.dic = dic;
                                
                [_dataArr addObject:dic];
            }
            
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_myTableView reloadData];
        
        
        if (_dataArr.count == 0) {
            
            BQimageV.hidden = NO;
            BQlabel.hidden = NO;
            
            BQimageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 80, 128, 128)];
            BQimageV.image = [UIImage imageNamed:@"bq@2x"];
            
            [self.view addSubview:BQimageV];
            
            BQlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BQimageV.bottom+10, kScreenWidth, 20)];
            
            BQlabel.text = @"没有搜索到数据";
            
            BQlabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            BQlabel.font = [UIFont systemFontOfSize:16];
            BQlabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:BQlabel];
            
        }else{
            
            BQimageV.hidden = YES;
            BQlabel.hidden = YES;
        }
        
    } failure:^(NSError *error) {
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        NSLog(@"%@",error);
        
    }];
    
    
    
}


- (void)showNewStatusesCount:(int)count
{
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"已为您更新%d件新上架商品", count];
        
    } else {
        label.text = @"没有最新的商品数据";
    }
    
    // 3.设置背景
    
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    
    
//    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.left = 0;
    label.top = - label.height;
    
    // 5.添加到导航控制器的view
    //    [self.navigationController.view addSubview:label];
    
    [self.view addSubview:label];
    
//    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
//    
    // 6.动画
    CGFloat duration = 0.75;
    //    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        //        label.alpha = 1.0;
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            //            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}



//头像
- (void)leftBtnAction{
    
    //人员管理
    FinanceViewController *financeVC = [[FinanceViewController alloc]init];
    
    financeVC.isPersonnel = YES;
    
    financeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:financeVC animated:YES];

}

//搜索
- (void)rightBtnAction{
    
    
    ReleaseHistoryViewController *ReleaseHistoryVC = [[ReleaseHistoryViewController alloc]init];
    ReleaseHistoryVC.is_delete = @"2";
    
    ReleaseHistoryVC.IsSearch = YES;
    
    ReleaseHistoryVC.typeStr = typeStr;
    
    ReleaseHistoryVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:ReleaseHistoryVC animated:YES];
    

}
//添加
- (void)rightBtnAction1{
    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSArray *selectTypeArr = [defaults objectForKey:[NSString stringWithFormat:@"%@Type",SYGData[@"id"]]];
    
    OneButtonPublishingViewController *OneButtonPublishingVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"OneButtonPublishingViewController"];
    
    OneButtonPublishingVC.isOnePush = YES;
    
    OneButtonPublishingVC.typeArr = typeArr;
    
    if (selectTypeArr == nil) {
        
        OneButtonPublishingVC.selectTypeArr = typeArr;

    }else{
    
        OneButtonPublishingVC.selectTypeArr = selectTypeArr;
        
    }
    
    
    [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
    

//    
//    OnePublishingViewController *onePublishingVC  = [[OnePublishingViewController alloc]init];
//    
//    onePublishingVC.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:onePublishingVC animated:YES];
//    
}

//筛选
- (void)homeButtonAction{

    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部",@"同行",@"本店", nil];
    
    [actionSheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [homeButton setTitle:@"全部" forState:UIControlStateNormal];
        
        typeStr = @"all";

        page = 1;
        
        [self loadData];

    }else if (buttonIndex == 1){
        
        [homeButton setTitle:@"同行" forState:UIControlStateNormal];
        
        typeStr = @"friend";

        page = 1;

        [self loadData];

    }else if (buttonIndex == 2){
        
        [homeButton setTitle:@"本店" forState:UIControlStateNormal];
        
        typeStr = @"me";
        
        page = 1;

        [self loadData];
        
    }
    

}

#pragma mark --UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _dataArr[indexPath.section];
    
    
    ReleaseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseHistoryCell" forIndexPath:indexPath];
    
    cell.is_delete = @"0";
    cell.index = indexPath.section;
    
    cell.dic = dic;

    return cell;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat height = 0;

    NSDictionary *dic = _dataArr[indexPath.section];

    NSArray *arr = dic[@"img"];
    
    
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    
    CGFloat emptylen = 20;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    
    CGRect rect = [dic[@"goods_description"] boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paraStyle01} context:nil];
    height = 80 + rect.size.height + 5;
    
    if (arr.count < 4) {
        
        height = height + kScreenWidth/4;
        
    }else if (arr.count > 3 && arr.count < 7){
        
        height = height + kScreenWidth/2 + 5;
        
    }else if (arr.count > 6){
        
        height = height + kScreenWidth/4 * 3 + 10;
        
    }
    
    NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];
    
    NSMutableArray *unstatusArr = [NSMutableArray array];
    
    for (NSString *str in dic[@"unstatus"]) {
        
        if ([typeArr containsObject:str]) {
            
            [unstatusArr addObject:str];
        }
    }

    height = height + 10;
    
    if (unstatusArr.count != 0) {
        height = height + 80;
    }
    
    if ([dic[@"is_friend_goods"] isEqualToString:@"1"]) {
        
        height = height + 60;
    }
    
    
    return height;

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


//通知
- (void)UpDataNotification:(NSNotification*)noti{
    
    page = 1;
    
    [self loadData];
    
}

- (void)DelegateNotification:(NSNotification*)noti{
    
    
    NSInteger index = [[noti object] integerValue];
    
    NSLog(@"%ld",index);
    
    if (_dataArr.count > index) {
        
        [_dataArr removeObjectAtIndex:index];
        
    }
    
    [_myTableView reloadData];
    
    
}

- (void)TypeSelectNotification:(NSNotification*)noti{
    
    
    NSInteger index = [[noti object][@"index"] integerValue];
    
    NSLog(@"%ld",index);
    
    if (_dataArr.count > index) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
        
        [dic setObject:[noti object][@"num"] forKey:[noti object][@"type"]];
        
        NSLog(@"%@",dic);
        
        [_dataArr replaceObjectAtIndex:index withObject:[dic copy]];
        
        [_myTableView reloadData];
        
        
    }
    
}

- (void)TextViewNotification:(NSNotification*)noti{
    
    NSDictionary *dic = [noti object];
    
    NSInteger index = [dic[@"1"] integerValue];
    
    if (_dataArr.count > index) {
        
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[[dic[@"1"] integerValue]]];
        
        NSLog(@"%@",mutableDic);
        
        [mutableDic setObject:dic[@"2"] forKey:@"goods_description"];
        
        [_dataArr replaceObjectAtIndex:[dic[@"1"] integerValue] withObject:[mutableDic copy]];
        
        [_myTableView reloadData];
        
    }

}

- (void)DLTextViewNotification:(NSNotification*)noti{
    
    NSDictionary *dic = [noti object];
    
    NSInteger index = [dic[@"1"] integerValue];
    
    if (_dataArr.count > index) {
        
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[[dic[@"1"] integerValue]]];
        
        NSLog(@"%@",mutableDic);
        
        [mutableDic setObject:dic[@"2"] forKey:@"agency_price"];
        
        [_dataArr replaceObjectAtIndex:[dic[@"1"] integerValue] withObject:[mutableDic copy]];
        
        [_myTableView reloadData];
        
    }
    
}

- (void)UpDataTabBarNotification{

    [_myTableView.header beginRefreshing];

}



- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSLog(@"%@",SYGData);
    
    [leftBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl,SYGData[@"shopinfo"][@"logo"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"mrtx1"]];
    
}
@end
