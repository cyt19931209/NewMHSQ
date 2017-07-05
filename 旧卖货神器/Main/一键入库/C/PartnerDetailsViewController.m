//
//  PartnerDetailsViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/5.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "PartnerDetailsViewController.h"
#import "MJRefresh.h"
#import "RepertoryPublishCell.h"
#import "ReleaseDetailsViewController.h"
#import "PeerHeaderView.h"
#import "ReleaseHistoryCell.h"

@interface PartnerDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UISearchBarDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
    
    
    NSInteger page;
    
    
    UIImageView *logoImageV;
    
    UILabel *TELLabel;
    
    UILabel *WXHLabel;
    
    UISearchBar *searchBar;
    
    
    PeerHeaderView *peerHeadrV;
    

    
}
@property (nonatomic,copy) NSString *keyword;


@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;


@property (nonatomic,strong) UIButton *logoButton;


@end

@implementation PartnerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _keyword = @"";
    
    
    _dataArr = [NSMutableArray array];
    
    
    self.navigationItem.title = @"Ta的商品";
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 20, 20);
//    [rightBtn setImage:[UIImage imageNamed:@"mrw"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
//    
    
//    UIImageView *topImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background10.png"]];
//    
//    topImageV.frame = CGRectMake(0, 0, kScreenWidth, 380.0/720.0*kScreenWidth);
//    
//    [self.view addSubview:topImageV];
//    
//    
//    logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 92, 68, 68)];
//    
//    logoImageV.layer.cornerRadius = 34;
//    
//    logoImageV.layer.masksToBounds = YES;
//    
//    [topImageV addSubview:logoImageV];
//    
//    _logoButton = [[UIButton alloc]initWithFrame:CGRectMake(27, 89, 74, 74)];
//    
//    _logoButton.layer.borderWidth = 3;
//    
//    _logoButton.layer.cornerRadius = 37;
//    
//    _logoButton.layer.masksToBounds = YES;
//    
//    _logoButton.layer.borderColor = [UIColor colorWithWhite:255 alpha:.4].CGColor;
//    
//    [topImageV addSubview:_logoButton];
//
//    
//    TELLabel = [[UILabel alloc]initWithFrame:CGRectMake(118, 106, 200, 16)];
//    
//    TELLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
//    
//    TELLabel.font = [UIFont systemFontOfSize:14];
//    
//    [topImageV addSubview:TELLabel];
//    
//    WXHLabel = [[UILabel alloc]initWithFrame:CGRectMake(118, TELLabel.bottom + 10, 200, 16)];
//    
//    WXHLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
//    
//    WXHLabel.font = [UIFont systemFontOfSize:14];
//    
//    [topImageV addSubview:WXHLabel];
//    
//    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    searchView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    [self.view addSubview:searchView];
    
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 8, kScreenWidth - 70, 28)];
    
    searchBar.layer.cornerRadius = 4;
    
    searchBar.layer.masksToBounds = YES;
    
    searchBar.layer.borderWidth = 1;
    
    searchBar.layer.borderColor = [RGBColor colorWithHexString:@"#d8d8d8"].CGColor;
    
    searchBar.delegate = self;
    
    searchBar.barTintColor = [RGBColor colorWithHexString:@"#f8f8f8"];
    
    UITextField *searchTextField = [[[searchBar.subviews firstObject] subviews] lastObject];
    
    [searchTextField setBackgroundColor:[RGBColor colorWithHexString:@"#f8f8f8"]];      //修改输入框的颜色
    searchTextField.clearButtonMode = UITextFieldViewModeAlways;

//    searchTextField.delegate = self;
    
    [searchTextField setValue:[RGBColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
    
    searchBar.placeholder = @"请输入搜索内容";
    
    [searchView addSubview:searchBar];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    
    [searchButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    searchButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    searchButton.frame = CGRectMake(searchBar.right + 10, 8, 40, 28);
    
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [searchView addSubview:searchButton];

    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44 , kScreenWidth , kScreenHeight  - 64 - 44) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ReleaseHistoryCell" bundle:nil] forCellReuseIdentifier:@"ReleaseHistoryCell"];
    
    __weak PartnerDetailsViewController *weakSelf = self;
    
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
    
    
    peerHeadrV = [[[NSBundle mainBundle]loadNibNamed:@"PeerHeaderView" owner:self options:nil] lastObject];
    
    peerHeadrV.isMyFriend = YES;
    _myTableView.tableHeaderView = peerHeadrV;
    
    [self loadData];
    
    [self loadData1];
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.view addGestureRecognizer:singleRecognizer];
    
}

- (void)singleAction{


    [searchBar resignFirstResponder];
}

- (void)searchButtonAction{

    [searchBar resignFirstResponder];
    
    _keyword = searchBar.text;
    
    page = 1;
    
    [self loadData];

}

//详细信息
- (void)loadData1{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_shop_id forKey:@"shop_id"];
    
    [DataSeviece requestUrl:get_friend_shop_detailshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
//        [logoImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgUrl,result[@"result"][@"data"][@"logo"]]] placeholderImage:[UIImage imageNamed:@"mrtx"]];
//        
//        TELLabel.text = [NSString stringWithFormat:@"Tel:%@",result[@"result"][@"data"][@"mobile"]];
//        
//        WXHLabel.text = [NSString stringWithFormat:@"微信号:%@",result[@"result"][@"data"][@"wechat"]];
        
        peerHeadrV.dic = result[@"result"][@"data"];


    } failure:^(NSError *error) {
        
  
        NSLog(@"%@",error);
        
    }];
    
}

//列表信息
- (void)loadData{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    [params setObject:_shop_id forKey:@"shop_id"];
    
    [params setObject:_keyword forKey:@"keyword"];

    [DataSeviece requestUrl:get_shop_goods_listhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
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

                [_dataArr addObject:dic];
            }
            
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        NSLog(@"%@",error);
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ReleaseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseHistoryCell" forIndexPath:indexPath];

    cell.isFriend = YES;
    
    cell.is_delete = @"0";
    cell.index = indexPath.section;
    
    cell.dic = _dataArr[indexPath.section];
    
    return cell;
    
//    RepertoryPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepertoryPublishCell" forIndexPath:indexPath];
//    
//    
//    cell.dic = _dataArr[indexPath.section];
//    
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

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    
    view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReleaseDetailsViewController *ReleaseDetailsVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"ReleaseDetailsViewController"];
    ReleaseDetailsVC.index = indexPath.section;
    ReleaseDetailsVC.isFriend = YES;
    ReleaseDetailsVC.share_id = _dataArr[indexPath.section][@"id"];
    
    [self.navigationController pushViewController:ReleaseDetailsVC animated:YES];

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
    
    height = height + 10;
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.00001f;
}



- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)rightBtnAction{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //改变导航栏标题的字体颜色和大小
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {


    if (buttonIndex == 1) {
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:_shop_id forKey:@"friend_shop_id"];

        [DataSeviece requestUrl:remove_friendhtml params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPartnerNotification" object:@"1"];
                
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
//                alertV.message = result[@"result"][@"msg"];
//                [alertV show];
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定解除同行关系" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertV show];
        
        
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
}

#pragma mark - UISearchBarDelegate 委托



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    _keyword = searchBar.text;
    
    page = 1;
    
    [self loadData];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    NSLog(@"%@",searchText);
    
    if ([searchBar.text isEqualToString:@""]) {
        
        _keyword = @"";
        
        page = 1;
        
        [self loadData];

        
    }
    
}

//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    
//    
//    
//    _keyword = @"";
//    
//    page = 1;
//    
//    [self loadData];
//    
//    return YES;
//    
//}



@end
