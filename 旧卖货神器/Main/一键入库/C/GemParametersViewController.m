//
//  GemParametersViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/3/24.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "GemParametersViewController.h"

@interface GemParametersViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *selectArr;

@property (nonatomic,strong) UITableView *myTableView;


@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation GemParametersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectArr = [NSMutableArray array];
    
    _dataArr = [NSMutableArray array];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    
    self.navigationItem.title = _typeName;
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    //右边Item
    if ([_typeStr isEqualToString:@"3"]&&_isDrill) {
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 35, 30);
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        
    }
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    
    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    [self loadData];
    
}

- (void)loadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSString *url = @"";
    
    if ([_typeStr isEqualToString:@"1"]) {
        
        url = get_share_gemstonehtml;
        
        [params setObject:@"22" forKey:@"category_pid"];

    }else if ([_typeStr isEqualToString:@"2"]){
        
        url = get_share_gemstone_attributehtml;
        
        [params setObject:@"density" forKey:@"type"];

        
    }else if ([_typeStr isEqualToString:@"3"]){
        
        url = get_share_gemstone_attributehtml;
        
        if (_isDrill) {
            
            [params setObject:@"color_drill_color" forKey:@"type"];

        }else{
        
            [params setObject:@"color" forKey:@"type"];

        }
    }else if ([_typeStr isEqualToString:@"4"]){
        
        url = get_share_gemstone_attributehtml;
        
        [params setObject:@"clarity" forKey:@"type"];
        
    }else if ([_typeStr isEqualToString:@"5"]){
        
        url = get_share_gemstone_attributehtml;
        
        [params setObject:@"cutter" forKey:@"type"];
        
    }else if ([_typeStr isEqualToString:@"6"]){
        
        url = get_share_gemstone_attributehtml;
        
        [params setObject:@"polishing" forKey:@"type"];
        
    }else if ([_typeStr isEqualToString:@"7"]){
        
        url = get_share_gemstone_attributehtml;
        
        [params setObject:@"symmetry" forKey:@"type"];
        
    }else if ([_typeStr isEqualToString:@"8"]){
        
        url = get_share_gemstone_attributehtml;
        
        [params setObject:@"fluorescence" forKey:@"type"];
        
    }
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            for (NSDictionary *dic1 in _oldArr) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {

                    [_selectArr addObject:dic];
                    
                }
            }
            
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductParametersCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductParametersCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row][@"name"];
    
    
    if ([_selectArr containsObject:_dataArr[indexPath.row]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([_typeStr isEqualToString:@"3"]&&_isDrill) {

        
        if ([_selectArr containsObject:_dataArr[indexPath.row]]) {
            
            [_selectArr removeObject:_dataArr[indexPath.row]];
            
        }else{
        
            [_selectArr addObject:_dataArr[indexPath.row]];
            
        }
        
        [_myTableView reloadData];

    }else{
    
        [_selectArr removeAllObjects];
        
        [_selectArr addObject:_dataArr[indexPath.row]];

        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GemParametersNotication" object:@{@"type":_typeStr,@"select":_selectArr}];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
//    if ([_typeStr isEqualToString:@"4"]) {
//        
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductParametersNotification" object:@{_typeStr:_dataArr[indexPath.row]}];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }else if ([_typeStr isEqualToString:@"5"]) {
//        
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SortConditionNotification" object:_dataArr[indexPath.row]];
//        
//        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
//        
//        
//    }else{
//        
//        NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[indexPath.row]];
//        
//        
//        
//        if ([_selectArr containsObject:selectDic]) {
//            
//            [_selectArr removeObject:selectDic];
//            
//        }else{
//            
//            [_selectArr addObject:selectDic];
//        }
//        
//        
//        [tableView reloadData];
//        
//    }
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


- (void)leftBtnAction{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)editAction{
    
    if ([_typeStr isEqualToString:@"3"]&&_isDrill) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GemParametersNotication" object:@{@"type":_typeStr,@"select":_selectArr}];
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
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
    
}
@end
