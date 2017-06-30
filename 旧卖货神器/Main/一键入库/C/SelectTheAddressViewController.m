//
//  SelectTheAddressViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SelectTheAddressViewController.h"
#import "SelectTheAddressCell.h"
#import "AddTheAddressViewController.h"

@interface SelectTheAddressViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation SelectTheAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationAddress:) name:@"NotificationAddress" object:nil];
    
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
    
    [_myTableView registerNib:[UINib nibWithNibName:@"SelectTheAddressCell" bundle:nil] forCellReuseIdentifier:@"SelectTheAddressCell"];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 72)];
    
    footView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    UIButton *footButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    
    footButton.frame = CGRectMake(kScreenWidth/2 - 145, 24, 290, 48);
    
    footButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
    
    [footButton addTarget:self action:@selector(footButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    
    footButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    footButton.layer.cornerRadius = 4;
    footButton.layer.masksToBounds = YES;
    
    [footButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    
    [footView addSubview:footButton];
    
    _myTableView.tableFooterView = footView;
    
    [self loadData];
    
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    for (NSDictionary *dic in _dataArr) {
        
        if ([dic[@"addressId"] intValue] ==  [_addressId integerValue]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"POPNotificationAddress" object:dic];

        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//加载
- (void)loadData{
    
    [_dataArr removeAllObjects];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:@"newshang" forKey:@"type"];
    
    [params setObject:@"address" forKey:@"param_name"];

    
    [DataSeviece requestUrl:get_platform_paramhtml params:params success:^(id result) {
        
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            [_dataArr addObject:dic];
        }
        
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)footButtonAction{
    
    AddTheAddressViewController *AddTheAddressVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"AddTheAddressViewController"];
    
    [self.navigationController pushViewController:AddTheAddressVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectTheAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectTheAddressCell" forIndexPath:indexPath];

    cell.dic = _dataArr[indexPath.row];
    
    NSDictionary *dic  = _dataArr[indexPath.row];
    
    
    if ([dic[@"addressId"] integerValue] == [_addressId integerValue]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        

    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _addressId = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"addressId"]];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPNotificationAddress" object:_dataArr[indexPath.row]];

    [_myTableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"选择地址";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
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

- (void)NotificationAddress:(NSNotification*)noti{

    
    _addressId = [noti object];

    [self loadData];
    
}

@end
