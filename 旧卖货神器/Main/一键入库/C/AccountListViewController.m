//
//  AccountListViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/4.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AccountListViewController.h"
#import "AccountListCell.h"
#import "AccountBindingViewController.h"
#import "WebViewController.h"

@interface AccountListViewController ()<UITableViewDataSource,UITableViewDelegate>{


    NSArray *typeArr;
    
    NSArray *nameArr;
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation AccountListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _dataArr = [NSMutableArray array];
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar@2x"] forBarMetrics:UIBarMetricsDefault];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectTypeNotification) name:@"SelectTypeNotification" object:nil];

    typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"newshang",@"shopuu",@"aidingmaopro",@"aidingmaomer",@"jiuai",@"xiaohongshu",@"liequ"];
    
    nameArr = @[@"胖虎",@"爱丁猫",@"微店",@"心上",@"少铺",@"爱丁猫专业版",@"爱丁猫商家版",@"旧爱",@"小红书",@"猎趣"];

    NSInteger index = 0;

    for (int i = 0; i < typeArr.count; i++) {
        
        if ([_titleStr isEqualToString:typeArr[i]]) {
            
            index = i;
        }
    }
    
    self.navigationItem.title = nameArr[index];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    [self.view addSubview:_myTableView];

    [_myTableView registerNib:[UINib nibWithNibName:@"AccountListCell" bundle:nil] forCellReuseIdentifier:@"AccountListCell"];

    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 72)];
    
    footView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    UIButton *footButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    
    footButton.frame = CGRectMake(kScreenWidth/2 - 145, 24, 290, 48);
    
    footButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    
    [footButton addTarget:self action:@selector(footButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footButton setTitle:@"添加绑定" forState:UIControlStateNormal];
    
    footButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    footButton.layer.cornerRadius = 4;
    footButton.layer.masksToBounds = YES;
    
    [footButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    
    [footView addSubview:footButton];
    
    _myTableView.tableFooterView = footView;
    
}

//加载
- (void)loadData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:@"1" forKey:@"is_default"];

    [params setObject:_titleStr forKey:@"type"];
    
    [DataSeviece requestUrl:Shareget_share_accounthtml params:params success:^(id result) {
        
        [_dataArr removeAllObjects];

        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSArray *arr = result[@"result"][@"data"][@"item"];
        
        for (NSDictionary *dic in arr) {
            
            [_dataArr addObject:[dic copy]];
        }
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
}

- (void)footButtonAction{
    
    if ([_titleStr isEqualToString:@"vdian"]) {
        
        WebViewController *webVC = [[WebViewController alloc]init];
        
        [self.navigationController pushViewController:webVC animated:YES];

    }else{
    
        AccountBindingViewController *AccountBindingVC = [[AccountBindingViewController alloc]init];
        
        AccountBindingVC.dataDic = @{@"type":_titleStr};
        
        [self.navigationController pushViewController:AccountBindingVC animated:YES];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountListCell" forIndexPath:indexPath];
    

    if (![_titleStr isEqualToString:@"vdian"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (![_titleStr isEqualToString:@"vdian"]) {
        
        AccountBindingViewController *AccountBindingVC = [[AccountBindingViewController alloc]init];
        
        AccountBindingVC.dataDic = _dataArr[indexPath.row];
        
        [self.navigationController pushViewController:AccountBindingVC animated:YES];

        
    }else{
        
        if ([_dataArr[indexPath.row][@"is_default"] isEqualToString:@"1"]&&![_dataArr[indexPath.row][@"status"] isEqualToString:@"1"]) {
            
            WebViewController *webVC = [[WebViewController alloc]init];
            
            [self.navigationController pushViewController:webVC animated:YES];
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
}

- (void)SelectTypeNotification{
    
    [self loadData];

    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadData];

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountNotification" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
