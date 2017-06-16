//
//  DetailViewController.h
//  旧卖货神器
//
//  Created by CYT on 2017/6/16.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

