//
//  WDSortViewController.h
//  奢易购3.0
//
//  Created by Andy on 2016/11/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDSortViewController : UIViewController


@property (nonatomic,copy) NSString *idStr;


@property (nonatomic,copy) NSString *nameStr;

@property (nonatomic,assign) BOOL isMaterial;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSArray *oldArr;


@end
