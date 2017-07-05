//
//  RYSelectListView.h
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYSelectListView : UIView<UITableViewDelegate,UITableViewDataSource>

typedef void (^BackBlock)(NSInteger index);

@property (nonatomic,copy) BackBlock backBlock;


@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,strong) UITableView *myTableView;


@end
