//
//  RYSelectListView.m
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import "RYSelectListView.h"
#import "RYSelectCell.h"

@implementation RYSelectListView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        _myTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    
        
        _myTableView.delegate = self;
        
        _myTableView.dataSource = self;
        
        [self addSubview:_myTableView];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"RYSelectCell" bundle:nil] forCellReuseIdentifier:@"RYSelectCell"];
        
    }
    
    return self;

}


- (void)setDataDic:(NSDictionary *)dataDic{

    _dataDic = dataDic;
    
    NSArray *arr = _dataDic[@"user"];

    
    self.width = kScreenWidth - 36;
    
    
    self.height = (arr.count + 1) * 50;
    
    self.top = (kScreenHeight - self.height)/2;
    
    self.left = 18;
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 50)];
    
    headerLabel.textColor = [RGBColor colorWithHexString:@"333333"];
    
    headerLabel.text = [NSString stringWithFormat:@"%@的店铺",_dataDic[@"shop_name"]];
    
    headerLabel.font = [UIFont systemFontOfSize:18];
    
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    _myTableView.tableHeaderView = headerLabel;
    
    [_myTableView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *arr = _dataDic[@"user"];

    return arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RYSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RYSelectCell" forIndexPath:indexPath];
    
    NSArray *arr = _dataDic[@"user"];

    cell.dic = arr[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _backBlock(indexPath.row);
}



@end
