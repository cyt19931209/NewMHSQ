//
//  ProductParametersViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/2/15.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "ProductParametersViewController.h"

@interface ProductParametersViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *selectArr;

@property (nonatomic,strong) UITableView *myTableView;


@end

@implementation ProductParametersViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([_typeStr isEqualToString:@"1"]) {
        
        self.navigationItem.title = @"材质";

    }else if ([_typeStr isEqualToString:@"2"]){
    
        self.navigationItem.title = @"功能";

    }else if ([_typeStr isEqualToString:@"3"]){
        
        self.navigationItem.title = @"附件";
        
    }else if ([_typeStr isEqualToString:@"4"]){
        
        self.navigationItem.title = @"系列";
        
    }else if ([_typeStr isEqualToString:@"5"]){
        
        self.navigationItem.title = _typeName;
        
    }
    
    _selectArr = [NSMutableArray array];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    //右边Item
    if ([_typeStr isEqualToString:@"1"]||[_typeStr isEqualToString:@"2"]||[_typeStr isEqualToString:@"3"]) {
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 35, 30);
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        
    }
    
    if ([_typeStr isEqualToString:@"4"]) {
        
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    }else{
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];

    }
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    
    [self.view addSubview:_myTableView];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    if ([_typeStr isEqualToString:@"4"]||[_typeStr isEqualToString:@"5"]) {
        
        
        if ([_typeStr isEqualToString:@"4"]) {
            
            [self loadData1];
        }
        
        [_myTableView reloadData];
        
    }else{
        
        [self loadData];
    }
    
//    NSLog(@"%@",_dataArr);
    
}

- (void)loadData{
    
    for (NSDictionary *dic in _dataArr) {
        
        for (NSDictionary *dic1 in _oldArr) {

            if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {

                [_selectArr addObject:dic];
            }
            
        }
    }
}

- (void)loadData1{
    
    
//    NSLog(@"%@",_dataArr);
    
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSString *str = [_dataArr[i][@"name"] substringToIndex:1].uppercaseString;
        
        if (i == 0 ) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:str forKey:@"title"];
            
            NSMutableArray *array = [NSMutableArray array];
            
            [array addObject:_dataArr[i]];
            
            [dic setObject:array forKey:@"item"];
            
            [array1 addObject:dic];
            
        }else{
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[array1 lastObject]];
            
            NSString *str1 = dic[@"title"];
            
            if ([str1.uppercaseString isEqualToString:str]) {
                
                NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"item"]];
                
                [array addObject:_dataArr[i]];
                
                [dic setObject:array forKey:@"item"];
                
                [array1 replaceObjectAtIndex:array1.count - 1 withObject:dic];
                
            }else{
                
                NSMutableArray *array = [NSMutableArray array];
                
                [array addObject:_dataArr[i]];
                
                [dic setObject:array forKey:@"item"];
                
                [dic setObject:str forKey:@"title"];
                
                [array1 addObject:dic];
                
            }
        }
    }
    
    _dataArr = [array1 copy];
    
    
//    NSLog(@"%@------------ %@",_selectArr,_dataArr);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([_typeStr isEqualToString:@"4"]) {

        return _dataArr.count;

    }
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([_typeStr isEqualToString:@"4"]) {
        
        
        NSArray *arr = _dataArr[section][@"item"];
        
        return arr.count;

    }
    
    return _dataArr.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductParametersCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductParametersCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    }

    
    if ([_typeStr isEqualToString:@"5"]) {
        
        cell.textLabel.text = _dataArr[indexPath.row][@"category_name"];

    }else{
    
        if ([_typeStr isEqualToString:@"4"]) {
            
            cell.textLabel.text = _dataArr[indexPath.section][@"item"][indexPath.row][@"name"];

        }else{
        
            cell.textLabel.text = _dataArr[indexPath.row][@"name"];
            
        }
    
    }
    
    if ([_typeStr isEqualToString:@"4"]) {

        if ([_selectArr containsObject:_dataArr[indexPath.section][@"item"][indexPath.row]]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        
        }
        
    }else{

        
        if ([_selectArr containsObject:_dataArr[indexPath.row]]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if ([_typeStr isEqualToString:@"4"]) {

        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductParametersNotification" object:@{_typeStr:_dataArr[indexPath.section][@"item"][indexPath.row]}];

        [self.navigationController popViewControllerAnimated:YES];

    }else if ([_typeStr isEqualToString:@"5"]) {
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SortConditionNotification" object:_dataArr[indexPath.row]];
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
        
        
    }else{
        
        NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[indexPath.row]];
        
        
        
        if ([_selectArr containsObject:selectDic]) {
            
            [_selectArr removeObject:selectDic];
            
        }else{
        
            [_selectArr addObject:selectDic];
        }
        
            
        [tableView reloadData];
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([_typeStr isEqualToString:@"4"]) {
        
        return 22;

    }
    return 0.01f;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ProductHeaderView"];
    
    if ([_typeStr isEqualToString:@"4"]) {

        if (!headerView) {
            
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"ProductHeaderView"];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 20)];
            
            label.textColor = [RGBColor colorWithHexString:@"#999999"];
            
            label.font = [UIFont systemFontOfSize:14];
            
            label.tag = 200;
            
            [headerView.contentView addSubview:label];
            
            headerView.contentView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
            
        }
        
        UILabel *label = [headerView.contentView viewWithTag:200];
        
        label.text = _dataArr[section][@"title"];
        
    }
    
    return headerView;
    
}



- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if ([_typeStr isEqualToString:@"4"]) {

    
        NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in _dataArr) {
            
            [toBeReturned addObject:dic[@"title"]];
            
        }
        
        return toBeReturned;
        
    }
    
    return nil;
}


- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    
    if ([_typeStr isEqualToString:@"4"]) {
     
        NSInteger num = 0;
        for (int i = 0; i < index; i++) {
            
            NSArray *itemArr = _dataArr[i][@"item"];
            
            num = num + itemArr.count;
            
        }
        
        NSInteger y= num *48 +index *22;
        
        [tableView setContentOffset:CGPointMake(0, y) animated:NO];
        
        return NSNotFound;

    }
    
    return NSNotFound;

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
    
    if (![_typeStr isEqualToString:@"4"]) {
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductParametersNotification" object:@{_typeStr:_selectArr}];
        
    }
    
    
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
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    
}
@end
