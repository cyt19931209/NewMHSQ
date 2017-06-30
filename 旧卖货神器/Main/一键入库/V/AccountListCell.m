//
//  AccountListCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/4.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AccountListCell.h"

@implementation AccountListCell


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;

    _titleLabel.text = _dic[@"phone"];
    
    if ([_dic[@"is_default"] isEqualToString:@"1"]) {
        
        _slectImageV.image = [UIImage imageNamed:@"chs"];
        
        if ([_dic[@"status"] isEqualToString:@"1"]) {
            
            _JGImageV.hidden = YES;
        }else{
            _JGImageV.hidden = NO;

        }
        
        
    }else{
        _JGImageV.hidden = YES;

        _slectImageV.image = [UIImage imageNamed:@""];

    }
    
    if (![_dic[@"type"] isEqualToString:@"vdian"]) {
        
        _delectButton.hidden = YES;
        
    }else{
        
        _delectButton.hidden = NO;

    }
    
}

- (IBAction)delectAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_dic[@"id"] forKey:@"id"];
    [DataSeviece requestUrl:delete_share_accounthtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectTypeNotification" object:nil];

        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



- (IBAction)buttonAction1:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
//    if ([_dic[@"is_default"] isEqualToString:@"3"]) {
//        
//        alertV.message = @"授权过期,请重新绑定账号";
//        
//        [alertV show];
//        
//    }else{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"type"] forKey:@"type"];
    
    [params setObject:_dic[@"id"] forKey:@"id"];
    
    [DataSeviece requestUrl:default_accounthtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectTypeNotification" object:_dic];
            
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

//    }
}


@end
