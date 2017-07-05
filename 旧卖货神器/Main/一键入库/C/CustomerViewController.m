//
//  CustomerViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/3/24.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "CustomerViewController.h"
#import "MJRefresh.h"

@interface CustomerViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{


    UITextField *searchTextField;
    //    BOOL isType;
    NSInteger page;
    
    NSString *keyword;
    
    UIView *bgView;

}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *customerTableView;


@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArr = [NSMutableArray array];
    
    keyword = @"";
    
    page = 1;

    
    self.navigationItem.title = @"客户选择";
    
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];

    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    
    //右边Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"949dff"] forState:UIControlStateNormal];
    
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(12, 6, kScreenWidth - 92, 32)];
    searchTextField.backgroundColor = [RGBColor colorWithHexString:@"f5f5f5"];
    searchTextField.layer.cornerRadius = 5;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.delegate = self;
    
    searchTextField.placeholder = @"搜索";
    
    [view addSubview:searchTextField];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchButton.frame = CGRectMake(kScreenWidth - 70, 7, 60, 32);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    searchButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.layer.cornerRadius = 5;
    searchButton.layer.masksToBounds = YES;
    searchButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [view addSubview:searchButton];
    
    _customerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50 - 64) style:UITableViewStylePlain];
    
    _customerTableView.delegate = self;
    _customerTableView.dataSource = self;
    _customerTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    [self.view addSubview:_customerTableView];

    
    [_customerTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomerInformationCell"];
    
    _customerTableView.tableFooterView = [[UIView alloc]init];
    
    //上拉加载
    
    _customerTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        
        [self loadData];
        
    }];
    
    //下拉刷新
    
    _customerTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        
        [self loadData];
        
    }];
    
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    //
    //    _dataArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
    //
    
    [self loadData];
    //    [_customerTableView reloadData];
    

//    
//
//    //右边Item
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 40, 30);
//    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    
//    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
//    
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
//    
//    
//    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 50, 28)];
//    
//    searchBar.delegate = self;
//    
//    searchBar.barTintColor = [RGBColor colorWithHexString:@"#f8f8f8"];
//    
//    UITextField *searchTextField = [[[searchBar.subviews firstObject] subviews] lastObject];
//    searchTextField.clearButtonMode = UITextFieldViewModeAlways;
//    
//    [searchTextField setBackgroundColor:[RGBColor colorWithHexString:@"#f8f8f8"]];      //修改输入框的颜色
//    
//    [searchTextField setValue:[RGBColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
//    
//    searchBar.placeholder = @"填写客户名称。若无记录点击确定即可添加";
//    
//    self.navigationItem.titleView = searchBar;
//    
//    
//    _customerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
//    
//    _customerTableView.delegate = self;
//    _customerTableView.dataSource = self;
//    _customerTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
//    [self.view addSubview:_customerTableView];
//    
//    _customerTableView.tableFooterView = [[UIView alloc]init];
//
//    [_customerTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomerInformationCell"];
//    
//
//    
//    //上拉加载
//    
//    _customerTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//        page++;
//        
//        [self loadData];
//        
//    }];
//    
//    //下拉刷新
//    
//    _customerTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        page = 1;
//        
//        [self loadData];
//        
//    }];
//
//
//    [self loadData];

}

- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}

//查找
- (void)searchAction{
    
    [searchTextField resignFirstResponder];
    
    keyword = searchTextField.text;
    
    page = 1;
    
    [self loadData];
}
//添加
- (void)addAction{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写客户名称" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [alert show];

    
}

- (void)loadData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:keyword forKey:@"keyword"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    
    [DataSeviece requestUrl:get_customerhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if (page == 1) {
            [_dataArr removeAllObjects];
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            [_dataArr addObject:[NULLHandle NUllHandle:dic]];
        }
        
        [_customerTableView reloadData];
        
        [_customerTableView.header endRefreshing];
        
        [_customerTableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [_customerTableView.header endRefreshing];
        [_customerTableView.footer endRefreshing];
        
    }];
    
}

////确定
//- (void)rightBtnAction{
//    
//    if ([searchBar.text isEqualToString:@""]) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    
//    [params setObject:searchBar.text forKey:@"name"];
//    
//
//    [DataSeviece requestUrl:add_customerhtml params:params success:^(id result) {
//        
//        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
//        
//        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomerNotication" object:@{@"id":result[@"result"][@"data"][@"id"],@"name":searchBar.text}];
//
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
//
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerInformationCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomerInformationCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row][@"name"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomerNotication" object:_dataArr[indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];

}

//是否可以编辑，如果返回值是no，不可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//具体实现添加或删除，执行的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"id"] isEqualToString:@"1"]) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该客户不能删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        return;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    
    [params setObject:_dataArr[indexPath.row][@"id"] forKey:@"id"];
    
    [DataSeviece requestUrl:delete_customerhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [_dataArr removeObjectAtIndex:indexPath.row];
            
            [_customerTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];




}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//    NSLog(@"%@",searchBar.text);
//
//}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    

    keyword = searchBar.text;
    
    page = 1;
    
    [self loadData];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    keyword = searchBar.text;
    
    page = 1;
    
    [self loadData];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *txt = [alertView textFieldAtIndex:0];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:txt.text forKey:@"name"];

    
    [DataSeviece requestUrl:add_customerhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomerNotication" object:@{@"id":result[@"result"][@"data"][@"id"],@"name":txt.text}];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
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
    
}

@end
