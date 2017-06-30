//
//  RepertoryPublishViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "RepertoryPublishViewController.h"
#import "RepertoryPublishCell.h"
#import "MJRefresh.h"
#import "ReleaseDetailsViewController.h"

@interface RepertoryPublishViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITextField *findTextField;
    
    NSInteger page;
    
    UIImageView *BQimageV;
    
    UILabel* BQlabel;
    
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

//@property (nonatomic,copy) NSString *keyword;


@end

@implementation RepertoryPublishViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    _dataArr = [NSMutableArray array];
    
    page = 1;
    
    self.navigationItem.title = @"发布历史";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    

    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"RepertoryPublishCell" bundle:nil] forCellReuseIdentifier:@"RepertoryPublishCell"];
    
    __weak RepertoryPublishViewController *weakSelf = self;
    
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
    
    [self loadData];
}

- (void)loadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    [params setObject:_goods_id forKey:@"goods_id"];
    
    [DataSeviece requestUrl:get_share_listhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if (page == 1) {
            
            [_dataArr removeAllObjects];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_dataArr addObject:dic];
            
            NSArray *imageArr = dic[@"img"];

            if (imageArr.count == 1) {
             
                
            }
            
        }
        
        [BQimageV removeFromSuperview];
        [BQlabel removeFromSuperview];
        
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
    
    RepertoryPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepertoryPublishCell" forIndexPath:indexPath];
    
    cell.dic = _dataArr[indexPath.section];
    
    return cell;
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
    
    
    ReleaseDetailsVC.share_id = _dataArr[indexPath.section][@"id"];
    
    [self.navigationController pushViewController:ReleaseDetailsVC animated:YES];

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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    // Dispose of any resources that can be recreated.
    
    //当收到内存警告时,移除当前没有在屏幕上显示的视图.
    
    //判断是否可以安全的移除视图控制器的view.
    
    //判断当前的视图控制器的view是否是屏幕上显示.self.view.window
    
    //判断当前视图控制器的view是否已经成功加载.isViewLoaded
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;//[_view release];_view = nil;
        
    }
    
    //NSLog(@"%@",self.view.window);
    
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}





@end
