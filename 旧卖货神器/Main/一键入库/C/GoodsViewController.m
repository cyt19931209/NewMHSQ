//
//  GoodsViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/6/6.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "GoodsViewController.h"
#import "ReleaseHistoryCell.h"
#import "MJRefresh.h"
#import "ReleaseHistoryModel.h"
#import "PeerHeaderView.h"
#import "RepertoryPublishCell.h"
#import "MyPartnerViewController.h"
#import "OnePublishingViewController.h"
#import "PartnerDetailsViewController.h"
#import "HotFriendCell.h"
#import "OneButtonPublishingViewController.h"
#import "UIButton+Graphic.h"

@interface GoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{

    UIButton *rightBtn;

    NSInteger page;
    
    NSInteger page1;

    
    UIImageView *BQimageV;
    
    UILabel* BQlabel;
    
    UISearchBar *searchBar;
    
    NSString *keyword;
    
    
    

}
//货源
@property (nonatomic,strong) UITableView *myTableView;
//热门同行
@property (nonatomic,strong) UITableView *peerTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *dataArr1;

@property (nonatomic,strong) UIView *selectV;

@property (nonatomic,strong) UIButton *selectButton;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    keyword = @"";
    
    page = 1;
    
    page1 = 1;

    _dataArr = [NSMutableArray array];
    
    _dataArr1 = [NSMutableArray array];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FollowNotification) name:@"FollowNotification" object:nil];
    
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.view addGestureRecognizer:singleRecognizer];

    
    //右边
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 5, 22, 22);
    [rightBtn setImage:[UIImage imageNamed:@"fbtj"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    self.navigationItem.rightBarButtonItem = rightItem;
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth - 100, 28)];
    
    searchBar.delegate = self;
    
    searchBar.barTintColor = [RGBColor colorWithHexString:@"#F6F6F6"];
    
    UITextField *searchTextField = [[[searchBar.subviews firstObject] subviews] lastObject];
    
    searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    [searchTextField setBackgroundColor:[RGBColor colorWithHexString:@"#F6F6F6"]];      //修改输入框的颜色
    [searchTextField setValue:[RGBColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
    
    searchBar.placeholder = @"搜搜有没有你想要的货源";
    
    self.navigationItem.titleView = searchBar;

    [self creatUI];
    
    [self loadData];

}

- (void)singleAction{
    
    [searchBar resignFirstResponder];
}

//UI
- (void)creatUI{
    
    NSArray *titleArr = @[@"货源",@"热门同行"];
    
    NSArray *imageArr = @[@"ic-huo",@"ic-hot"];
    
    
    _selectV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 2)];
    
    _selectV.backgroundColor = [RGBColor colorWithHexString:@"949DFF"];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(i * kScreenWidth/2, 0, kScreenWidth/2, 49);
        
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        
        button.tag = 100 + i;
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitleColor:[RGBColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        [button setTitleColor:[RGBColor colorWithHexString:@"#949DFF"] forState:UIControlStateSelected];
        
        button.backgroundColor = [RGBColor colorWithHexString:@"ffffff"];
        
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xz",imageArr[i]]] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        20 21
        
//        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.height, -button.titleLabel.bounds.size.width, 0, 0);
//
//        
//        button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.bounds.size.height,0,0,-button.titleLabel.bounds.size.width);
//
        
//        button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.bounds.size.height,0,0,-button.titleLabel.bounds.size.width);
//
//        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.height, -button.titleLabel.bounds.size.width, 0, 0);
//
        [button verticalImageAndTitle:5];
        
        
        if (i == 0) {
            
            button.selected = YES;
            
            _selectButton = button;
            
            [button addSubview:_selectV];
            
            _selectV.center = button.center;
            
            _selectV.top = 47;

        }
        
        [self.view addSubview:button];

    }

    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"d8d8d8"];
    
    [self.view addSubview:lineV];
    
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,49, kScreenWidth, kScreenHeight - 64 - 49 - 49) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ReleaseHistoryCell" bundle:nil] forCellReuseIdentifier:@"ReleaseHistoryCell"];
    
    //下拉刷新
    
    __weak GoodsViewController *weakSelf = self;
    
    
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

//获取热门推荐店铺
- (void)loadData1{

    
    keyword  = searchBar.text;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page1] forKey:@"page"];
    
    
    [params setObject:keyword forKey:@"keyword"];


    [DataSeviece requestUrl:get_hot_shop_listhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if (page1 == 1) {
            
            [_dataArr1 removeAllObjects];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_dataArr1 addObject:dic];
        }
        
        
        [_peerTableView.header endRefreshing];
        [_peerTableView.footer endRefreshing];
        [_peerTableView reloadData];
        
    } failure:^(NSError *error) {
        
        [_peerTableView.header endRefreshing];
        
        [_peerTableView.footer endRefreshing];
        
        NSLog(@"%@",error);
        
    }];

    
        
}

//
- (void)creatPeerTableView{
    
    _peerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,50, kScreenWidth, kScreenHeight - 64 - 49 - 50) style:UITableViewStyleGrouped];
    
    _peerTableView.delegate = self;
    
    _peerTableView.dataSource = self;
    
    _peerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_peerTableView];
    
    [_peerTableView registerNib:[UINib nibWithNibName:@"HotFriendCell" bundle:nil] forCellReuseIdentifier:@"HotFriendCell"];
    
    //下拉刷新

    __weak GoodsViewController *weakSelf = self;
    
    _peerTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page1 = 1;
        
        [weakSelf loadData1];
        
    }];
    
    //上拉加载
    
    _myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page1 ++;
        
        [weakSelf loadData1];
        
    }];

}



//选择顶部视图
- (void)buttonAction:(UIButton*)bt{
    
    if (bt.selected == NO) {
        
        bt.selected = YES;
        
        [bt addSubview:_selectV];
        
        _selectButton.selected = NO;
        
        _selectButton = bt;
        
        if (bt.tag == 100) {
            
            _myTableView.hidden = NO;
            
            _peerTableView.hidden = YES;
            
        }else if(bt.tag == 101){
            
            if (_peerTableView == nil) {
                
                [self creatPeerTableView];
            }
            
            if (_dataArr1.count == 0) {
                
                page1 = 1;
                
                [self loadData1];
            }
            
            
            _myTableView.hidden = YES;
            
            _peerTableView.hidden = NO;
            
        }
        
    }
    
}

- (void)loadData{
    
    keyword  = searchBar.text;

    [BQimageV removeFromSuperview];
    [BQlabel removeFromSuperview];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];

    
    [params setObject:keyword forKey:@"keyword"];

    
    NSString *url = @"";
    
    url = get_goods_source_listhtml;
    
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
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
            
            [_myTableView addSubview:BQimageV];
            
            BQlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BQimageV.bottom+10, kScreenWidth, 20)];
            
            BQlabel.text = @"没有搜索到数据";
            
            BQlabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            BQlabel.font = [UIFont systemFontOfSize:16];
            BQlabel.textAlignment = NSTextAlignmentCenter;
            [_myTableView addSubview:BQlabel];
            
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
//添加
- (void)rightBtnAction{

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
    
    
    OneButtonPublishingVC.hidesBottomBarWhenPushed = YES;

    
    [self.navigationController pushViewController:OneButtonPublishingVC animated:YES];
    

    
//    OnePublishingViewController *onePublishingVC  = [[OnePublishingViewController alloc]init];
//    
//    onePublishingVC.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:onePublishingVC animated:YES];
//    


}

#pragma mark --UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (tableView == _myTableView) {
        
        return _dataArr.count;

    }

    return _dataArr1.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (tableView == _peerTableView) {
//
//        NSArray *arr = _dataArr1[section][@"goods"];
//        
//        return  arr.count;
//        
//    
//    }
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (tableView == _myTableView) {
        
        NSDictionary *dic = _dataArr[indexPath.section];

        ReleaseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseHistoryCell" forIndexPath:indexPath];
        
        cell.is_delete = @"0";
        cell.index = indexPath.section;
        
        cell.dic = dic;
        
        return cell;
        
    }else{
    
        HotFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotFriendCell" forIndexPath:indexPath];
        
        cell.dic = _dataArr1[indexPath.section];
        
        return cell;
        
    }
    
    
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (_peerTableView == tableView) {

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(0, 0, kScreenWidth, 36);
        
        button.backgroundColor = [UIColor whiteColor];
        
        [button setTitleColor:[RGBColor colorWithHexString:@"949DFF"] forState:UIControlStateNormal];
        
        button.tag = 100 + section;
        
        [button setTitle:[NSString stringWithFormat:@"%@的更多商品…",_dataArr1[section][@"shop_name"]] forState:UIControlStateNormal];

        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [button addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        return view;
        
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    return view;
    
}
//更多
- (void)moreAction:(UIButton*)bt{

    
    PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
    
    PartnerDetailsVC.hidesBottomBarWhenPushed = YES;
    
    PartnerDetailsVC.shop_id = _dataArr1[bt.tag - 100][@"shop_id"];
    
    [self.navigationController pushViewController:PartnerDetailsVC animated:YES];

}



- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (_peerTableView == tableView) {
        
        PeerHeaderView *peerHeadrV = [[[NSBundle mainBundle]loadNibNamed:@"PeerHeaderView" owner:self options:nil] lastObject];

        peerHeadrV.dic = _dataArr1[section];

        return peerHeadrV;
        
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    return view;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (tableView == _peerTableView) {
        
        return 44;
        
    }
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == _peerTableView) {
        
        return 98;
    }
    
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _myTableView) {
        
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
 
    return 144;
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

#pragma mark - UISearchBarDelegate 委托


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{


    [searchBar resignFirstResponder];
    
    if (_myTableView.hidden) {
        
        page1 = 1;
        
        [self loadData1];
    }else{
        
        page = 1;
        
        [self loadData];
    }
    
}
//
- (void)FollowNotification{
    
    
    page1 = 1;
    
    [self loadData1];
    
    
    
}

-(void)dealloc{

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
    
}


@end
