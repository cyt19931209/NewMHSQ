//
//  FinanceCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "FinanceCell.h"

@implementation FinanceCell



- (void)setModel:(FinancialModel *)model{
    _model = model;

    _nameLabel.text = _model.use_name;

    _accountLabel.text = _model.account;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    
}

- (void)setModel1:(PersonelModel *)model1{
    _model1 = model1;

    _nameLabel.text = _model1.user_name;
    _accountLabel.text = _model1.mobile;
    
    _ZHButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    _ZHButton.layer.borderWidth = 1;
    
    if ([_model1.type isEqualToString:@"1"]) {
        _ZHButton.hidden = YES;
    }else if ([_model1.type isEqualToString:@"2"]){
        _ZHButton.hidden = NO;
    }else if ([_model1.type isEqualToString:@"3"]){
        _ZHButton.hidden = YES;

    }

    
    
}


@end
