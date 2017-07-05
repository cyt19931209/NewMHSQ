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
#import <CommonCrypto/CommonDigest.h>
#import "BaseChatViewController.h"



@implementation PeerHeaderView


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _nameLabel.text = _dic[@"shop_name"];
    
    _WXLabel.text = [NSString stringWithFormat:@"微信：%@",_dic[@"wechat"]];
    

    if ([_dic[@"wechat"] isEqualToString:@""]) {
        
        _WXLabel.hidden = YES;
        
        _WXButton.hidden = YES;
    }else{
        _WXLabel.hidden = NO;
        
        _WXButton.hidden = NO;
        
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    NSString *imgUrl_API = serviceData[@"imgUrl_API"];
    

    _phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",_dic[@"mobile"]];

    [_imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl_API,_dic[@"logo"]]] placeholderImage:[UIImage imageNamed:@"ytx"]];
    
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
    
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    if ([SYGData[@"shop_id"] isEqualToString:_dic[@"shop_id"]]) {
        
        _chatLabel.hidden = YES;
        
        _chatButton.hidden = YES;
        
        _DYLabel.hidden = YES;
        
        _DYButton.hidden = YES;
        
    }else{
    
        _chatLabel.hidden = NO;
        
        _chatButton.hidden = NO;
        
        _DYLabel.hidden = NO;
        
        _DYButton.hidden = NO;
    
    }
    
}

- (IBAction)SubscribeAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    if (!_DYButton.selected) {
        
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
        
        if (!_DYButton.selected) {
            
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
                
                
                if (!_DYButton.selected) {
                    
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    if (_isMyFriend) {
        
        [params setObject:_dic[@"friend_shop_id"] forKey:@"shop_id"];
        
    }else{
        
        [params setObject:_dic[@"shop_id"] forKey:@"shop_id"];
        
    }

    
    
    [DataSeviece requestUrl:get_shop_user_listhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            NSArray *arr = result[@"result"][@"data"][@"user"];
            
            //遮罩视图
            bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
            bgView.alpha = .4;
            [[UIApplication sharedApplication].keyWindow addSubview:bgView];
            
            UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bgButton.frame = bgView.frame;
            [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
            [bgView addSubview:bgButton];

            RYView = [[RYSelectListView alloc]initWithFrame:CGRectMake(18, (kScreenHeight - (arr.count + 1) * 50)/2, kScreenWidth - 36, (arr.count + 1) * 50)];
            
            RYView.dataDic = result[@"result"][@"data"];
            
            RYView.backBlock = ^(NSInteger index) {
              
                [self bgButtonAction];
                
                NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
                
                NSString *RYUserId = serviceData[@"RYUserId"];

                
                //新建一个聊天会话View Controller对象,建议这样初始化
                BaseChatViewController *chat = [[BaseChatViewController alloc] initWithConversationType:ConversationType_PRIVATE
                                                                                                           targetId:[NSString stringWithFormat:@"%@%@",RYUserId,result[@"result"][@"data"][@"user"][index][@"id"]]];
                
                chat.hidesBottomBarWhenPushed = YES;
                
                
                //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
                //            chat.conversationType = ConversationType_PRIVATE;
                //            //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
                //            chat.targetId = @"targetIdYouWillChatIn";
                //
                //设置聊天会话界面要显示的标题
                chat.title = result[@"result"][@"data"][@"user"][index][@"nickname"];
                
                //显示聊天会话界面
                [self.viewController.navigationController pushViewController:chat animated:YES];
                
            };
            
            [[UIApplication sharedApplication].keyWindow addSubview:RYView];

            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
//
- (void)bgButtonAction{

    bgView.hidden = YES;

    RYView.hidden = YES;

    [bgView removeFromSuperview];
    
    [RYView removeFromSuperview];
    
}




@end
