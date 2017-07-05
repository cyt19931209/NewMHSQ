//
//  NewPartnerCell.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/5.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "NewPartnerCell.h"

@implementation NewPartnerCell


- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    _nameLabel.text = _dic[@"shop_name"];
    
    _imageV.layer.cornerRadius = 4;
    
    _imageV.layer.masksToBounds = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    NSString *imgUrl_API = serviceData[@"imgUrl_API"];
    

    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgUrl_API,_dic[@"logo"]]]];
    
    _HLButton.layer.cornerRadius = 4;
    _HLButton.layer.masksToBounds = YES;
    _HLButton.layer.borderWidth = 1;
    _HLButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;

    _TYButton.layer.cornerRadius = 4;
    _TYButton.layer.masksToBounds = YES;
    
    if ([_dic[@"status"] isEqualToString:@"1"]) {
        
        _HLLabel.hidden = YES;
        _HLButton.hidden = NO;
        _TYButton.hidden = NO;
        
    }else if ([_dic[@"status"] isEqualToString:@"2"]){
        
        _HLLabel.hidden = NO;
        _HLLabel.text = @"已接受";
        _HLButton.hidden = YES;
        _TYButton.hidden = YES;
    }else if ([_dic[@"status"] isEqualToString:@"3"]){
        
        _HLLabel.hidden = NO;
        _HLLabel.text = @"已忽略";
        _HLButton.hidden = YES;
        _TYButton.hidden = YES;
    }else if ([_dic[@"status"] isEqualToString:@"4"]){
        
        _HLLabel.hidden = NO;
        _HLLabel.text = @"已解除";
        _HLButton.hidden = YES;
        _TYButton.hidden = YES;
        
    }

    
}

- (IBAction)TYAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"friend_shop_id"] forKey:@"friend_shop_id"];
    
    
    [DataSeviece requestUrl:apply_friendhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            

            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPartnerNotification" object:@"1"];
            
        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
}
- (IBAction)HLAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_dic[@"friend_shop_id"] forKey:@"friend_shop_id"];
    
    [params setObject:@"1" forKey:@"refuse"];

    
    [DataSeviece requestUrl:apply_friendhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPartnerNotification" object:@"2"];
            
        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
    
}

@end
