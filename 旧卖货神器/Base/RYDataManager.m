//
//  RYDataManager.m
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import "RYDataManager.h"
#import <RongIMKit/RongIMKit.h>



@implementation RYDataManager


+ (void)RYTokenAndLogin{

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_user_tokenhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        NSString *token = result[@"result"][@"data"][@"token"];
        
        [[RCIM sharedRCIM] connectWithToken:token     success:^(NSString *userId) {
            
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);

            dispatch_sync(dispatch_get_main_queue(), ^{

                int number = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
                
                if (number > 0 ) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNumberNotification" object:nil];
                    
                }
                
            });

            
        } error:^(RCConnectErrorCode status) {
            
            NSLog(@"登陆的错误码为:%d", status);
            
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
    

}







@end
