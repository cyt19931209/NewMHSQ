//
//  PeerHeaderView.m
//  奢易购3.0
//
//  Created by CYT on 2017/6/6.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "PeerHeaderView.h"
#import "PartnerDetailsViewController.h"
#import "UIView+Controller.h"
//#import <Hyphenate/Hyphenate.h>
//#import "EaseMessageViewController.h"
#import <CommonCrypto/CommonDigest.h>


@implementation PeerHeaderView


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _nameLabel.text = _dic[@"shop_name"];
    
    _WXLabel.text = [NSString stringWithFormat:@"微信：%@",_dic[@"wechat"]];
    
    _phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",_dic[@"mobile"]];

    [_imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl,_dic[@"logo"]]] placeholderImage:[UIImage imageNamed:@"ytx"]];
    
    _imageV.backgroundColor = [RGBColor colorWithHexString:@"D8D8D8"];
    
    _imageV.layer.cornerRadius = 28;
    
    _imageV.layer.masksToBounds = YES;
    
    
    if ([_dic[@"is_follow"] isEqualToString:@"1"]) {
        
        _DYLabel.text = @"取消关注";
        
        _DYButton.selected = YES;
        
    }else{
        
        _DYLabel.text = @"关注";
        
        _DYButton.selected = NO;
        
    }

}

- (IBAction)SubscribeAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    if (![_dic[@"is_follow"] isEqualToString:@"1"]) {
        
        alertV.message = @"是否确定关注";
        
    }else{
        
        alertV.message = @"是否确定取消关注";
    }
    
    [alertV show];

    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        NSString *url = @"";
        
        if (![_dic[@"is_follow"] isEqualToString:@"1"]) {
            
            url = follow_shophtml;
            
            
        }else{
            
            url = unfollow_shophtml;
            
            NSLog(@"%@",_dic);
            
            
        }
        
        if (_isMyFriend) {
            
            [params setObject:_dic[@"friend_shop_id"] forKey:@"friend_shop_id"];
            
        }else{
            
            [params setObject:_dic[@"shop_id"] forKey:@"friend_shop_id"];
            
        }
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        
        [DataSeviece requestUrl:url params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dic];
                
                if (![_dic[@"is_follow"] isEqualToString:@"1"]) {
                    
                    [dic setObject:@"1" forKey:@"is_follow"];
                    
                    _DYLabel.text = @"取消关注";
                    
                    _DYButton.selected = YES;
                    
                }else{
                    
                    [dic setObject:@"2" forKey:@"is_follow"];
                    
                    _DYLabel.text = @"关注";
                    
                    _DYButton.selected = NO;
                    
                }
                
                _dic = [dic copy];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FollowNotification" object:nil];
                
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
    }
}

- (IBAction)copyWXAction:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = _dic[@"wechat"];
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    alertV.message = @"复制微信号成功";
    
    [alertV show];
    

    
}
- (IBAction)copyPhoneAction:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = _dic[@"mobile"];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    alertV.message = @"复制手机号成功";
    
    [alertV show];

}
//
- (IBAction)pushAction:(id)sender {
    
    if (!_isMyFriend) {
        
        PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
        
        PartnerDetailsVC.hidesBottomBarWhenPushed = YES;
        
        PartnerDetailsVC.shop_id = _dic[@"shop_id"];
        
        [self.viewController.navigationController pushViewController:PartnerDetailsVC animated:YES];
    }

}

//聊天
- (IBAction)chatAction:(id)sender {
    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    
//    [params setObject:_dic[@"shop_id"] forKey:@"shop_id"];
//
//
//    
//    [DataSeviece requestUrl:get_shop_user_listhtml params:params success:^(id result) {
//        
//        NSLog(@"%@",result);
    
//        NSString *userName = [NSString stringWithFormat:@"%@%@",HXUserName,SYGData[@"id"]];
//        
//        NSString *password = [self md5HexDigest:[self md5HexDigest:userName]];
//        
//        
//        [[EMClient sharedClient] loginWithUsername:userName
//                                          password:password
//                                        completion:^(NSString *aUsername, EMError *aError) {
//                                            if (!aError) {
//                                                
//                                                NSLog(@"");
//                                                
//                                                EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
//                                                
//                                            } else {
//                                                NSLog(@"登录失败");
//                                            }
//                                        }];
//        

//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//    }];
    
    
}

- (NSString*)md5HexDigest:(NSString*)input{
    
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}



@end
