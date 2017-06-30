//
//  SelectTheAddressCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SelectTheAddressCell.h"

@implementation SelectTheAddressCell


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;

    _nameLabel.text = _dic[@"contactName"];
    
    _phoneLabel.text = _dic[@"phone"];
    
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@",_dic[@"city"],_dic[@"address"]];
    
}


@end
