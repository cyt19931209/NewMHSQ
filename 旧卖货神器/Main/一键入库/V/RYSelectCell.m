//
//  RYSelectCell.m
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import "RYSelectCell.h"

@implementation RYSelectCell



- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _nameLabel.text = _dic[@"nickname"];
    
    if ([_dic[@"status"] isEqualToString:@"1"]) {
    
        _stateImageV.image = [UIImage imageNamed:@"talk"];
        
        _stateLabel.textColor = [RGBColor colorWithHexString:@"666666"];
        
        _stateLabel.text = @"在线";
        
        _nameLabel.textColor = [RGBColor colorWithHexString:@"949DFF"];

    }else{
        
        _stateImageV.image = [UIImage imageNamed:@"ly"];
        
        _stateLabel.textColor = [RGBColor colorWithHexString:@"999999"];
        
        _stateLabel.text = @"离线";
    
        _nameLabel.textColor = [RGBColor colorWithHexString:@"333333"];
    }
    
    if ([_dic[@"is_master_role"] isEqualToString:@"1"]) {
        
        _typeLabel.hidden = NO;
        
        _nameLeft.constant = 54;
        
    }else{
    
        _typeLabel.hidden = YES;

        _nameLeft.constant = 8;

    }
    
    

}

@end
