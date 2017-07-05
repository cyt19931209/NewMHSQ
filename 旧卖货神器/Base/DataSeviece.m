//
//  DataSeviece.m
//  RMXJY
//
//  Created by MacBooK on 16/3/4.
//  Copyright © 2016年 MacBooK. All rights reserved.
//

#import "DataSeviece.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "GHRSA.h"
#import "GHUtils.h"

@implementation DataSeviece


+(void)requestUrl:(NSString *)url
           params:(NSMutableDictionary *)param
          success:(void (^)(id result))successBlock
          failure:(void (^)(NSError *error))failBlock{

    //1.拼接url
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    
    url = [serviceData[@"BaseUrl"] stringByAppendingString:url];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@\n %@",url,param);
    
//    NSDictionary *parameters = @{@"data":param};
    
    NSString *reqBody = [GHUtils dictionaryToJson:param];
    
    NSString *encryptedString = [GHRSA encryptString:reqBody publicKey:RSASyg_Public_key_FORM];

    NSDictionary *dic = @{@"data":@{@"sign":encryptedString}};
    
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    NSLog(@"手机系统版本: %@", phoneVersion);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    
    manager.requestSerializer.timeoutInterval = 60;
    
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"deviceType"];
    
    [manager.requestSerializer setValue:@"appId" forHTTPHeaderField:@"com.sheyigou.client"];

    [manager.requestSerializer setValue:appCurVersion forHTTPHeaderField:@"appVersion"];

    [manager.requestSerializer setValue:@"22" forHTTPHeaderField:@"appVerCode"];

    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@,%@",deviceName,phoneVersion] forHTTPHeaderField:@"User-Agent"];


    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        successBlock(responseObject);
        
        [hud hide:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failBlock(error);
        [hud hide:YES];
    }];
    
}

+(void)requestUrlNOHUD:(NSString *)url
           params:(NSMutableDictionary *)param
          success:(void (^)(id result))successBlock
          failure:(void (^)(NSError *error))failBlock{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    //1.拼接url
    url = [serviceData[@"BaseUrl"] stringByAppendingString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@\n %@",url,param);
    
    //    NSDictionary *parameters = @{@"data":param};
    
    NSString *reqBody = [GHUtils dictionaryToJson:param];
    
    NSString *encryptedString = [GHRSA encryptString:reqBody publicKey:RSASyg_Public_key_FORM];
    
    NSDictionary *dic = @{@"data":@{@"sign":encryptedString}};
    
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    NSLog(@"手机系统版本: %@", phoneVersion);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    
    manager.requestSerializer.timeoutInterval = 60;
    
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"deviceType"];
    
    [manager.requestSerializer setValue:@"appId" forHTTPHeaderField:@"com.sheyigou.client"];
    
    [manager.requestSerializer setValue:appCurVersion forHTTPHeaderField:@"appVersion"];
    
    [manager.requestSerializer setValue:@"22" forHTTPHeaderField:@"appVerCode"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@,%@",deviceName,phoneVersion] forHTTPHeaderField:@"User-Agent"];
    
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        successBlock(responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failBlock(error);
    }];
    
}



@end
