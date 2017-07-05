//
//  AppDelegate.m
//  旧卖货神器
//
//  Created by CYT on 2017/6/16.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "OnePublishingViewController.h"
#import "NoticeViewController.h"
#import "AFHTTPSessionManager.h"
#import "BaseTabBarController.h"
#import <RongIMKit/RongIMKit.h>
#import "RYDataManager.h"
#import "BaseChatViewController.h"
#import "MWApi.h"
#import "PartnerDetailsViewController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>


#endif


@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;

@end

@interface AppDelegate ()<JPUSHRegisterDelegate,RCIMUserInfoDataSource>

@end

@implementation AppDelegate

@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    if (serviceData) {
        
        if ([serviceData[@"is_ios_online"] isEqualToString:@"1"]) {
            
            [self waitAction];
            
        }else{
        
            [self serviceData];

            [self performSelector:@selector(waitAction) withObject:nil afterDelay:.1];
            
            
        }
        
    }else{
    
        serviceData = @{@"BaseUrl":@"http://test.sheyigou.com/index.php?s=/Api/",
                        @"WDUrl":@"http://test.sheyigou.com",
                        @"imgUrl_API":@"http://images.sheyigou.com",
                        @"RYUserId":@"sheyigou_",
                        @"RYAPPKey":@"tdrvipksthqs5",
                        @"is_ios_online":@"2"
                        };
        
        [defaults setObject:serviceData forKey:@"ServiceData"];
        
        [defaults synchronize];
        
        [self serviceData];
        
        [self performSelector:@selector(waitAction) withObject:nil afterDelay:.1];

    }
    
    
    [WeiboSDK registerApp:kAppKey];

    
    [MWApi registerMLinkHandlerWithKey:@"home" handler:^(NSURL *url, NSDictionary *params) {
        [self pushHomeAction:params[@"shopId"]];
        
    }];
    
    

    [defaults removeObjectForKey:@"Text"];
    
    
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        
        [application registerUserNotificationSettings:settings];
        
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        
        if (remoteNotification) {
            
            NSLog(@"推送消息==== %@",remoteNotification);
            
            [self goToMssageViewControllerWith:remoteNotification];
        }

    }
    
    [application setApplicationIconBadgeNumber:0];   //清除角标
    
    [MWApi registerApp:MWAppKey];

    
    return YES;
}

//等待线程
- (void)waitAction{

    //融云
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    NSLog(@"%@",serviceData[@"RYAPPKey"]);
    
    [[RCIM sharedRCIM] initWithAppKey:serviceData[@"RYAPPKey"]];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    BaseTabBarController *baseTabBarC = [[BaseTabBarController alloc]init];
        
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    if (SYGData[@"id"]) {
        
        self.window.rootViewController = baseTabBarC;
        
        [RYDataManager RYTokenAndLogin];
        
    }else{
        
        //登录界面
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
        self.window.rootViewController = loginVC;
    }

    

}

//服务器域名

- (void)serviceData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:is_ios_onlinehtml parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *serviceData = nil;
        
        if ([responseObject[@"result"][@"data"][@"is_ios_online"] isEqualToString:@"1"]) {
            
            serviceData = @{@"BaseUrl":@"http://test.sheyigou.com/index.php?s=/Api/",
                            @"WDUrl":@"http://test.sheyigou.com",
                            @"imgUrl_API":@"http://images.sheyigou.com",
                            @"RYUserId":@"sheyigou_",
                            @"RYAPPKey":@"tdrvipksthqs5",
                            @"is_ios_online":@"1"
                            };
            
        }else{
            
            serviceData = @{@"BaseUrl":@"http://syg.hpdengshi.com/index.php?s=/Api/",
                            @"WDUrl":@"http://syg.sheyigou.com",
                            @"imgUrl_API":@"http://imagetest.sheyigou.com",
                            @"RYUserId":@"sheyigoudebug_",
                            @"RYAPPKey":@"k51hidwqk9nqb",
                            @"is_ios_online":@"2"
                            };
        }
        
        [defaults setObject:serviceData forKey:@"ServiceData"];
        
        [defaults synchronize];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    NSLog(@"%@",token);
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}


//融云实现代理方法，个人信息
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];

    NSLog(@"%@",userId);
    
    if (SYGData) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        NSString *RYUserId = serviceData[@"RYUserId"];
        
        NSLog(@"%@",RYUserId);
        
        [params setObject:[userId substringWithRange:NSMakeRange(RYUserId.length, userId.length - RYUserId.length)] forKey:@"user_id"];

        [DataSeviece requestUrlNOHUD:get_user_infohtml params:params success:^(id result) {

            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                NSLog(@"%@",result[@"result"][@"data"][@"headimg"]);
                
//                return completion([[RCUserInfo alloc] initWithUserId:userId name:@"" portrait:@""]);
                
                return completion([[RCUserInfo alloc] initWithUserId:userId name:result[@"result"][@"data"][@"nickname"] portrait:result[@"result"][@"data"][@"headimg"]]);
                
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
    }

}


- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    NSDictionary *msgDic = [notification.userInfo objectForKey:@"rc"];
    
    NSLog(@"%@",msgDic);

    if ([msgDic[@"cType"] isEqualToString:@"PR"]) {
        
        BaseChatViewController *conversationVC = [[BaseChatViewController alloc]init];
        
        conversationVC.hidesBottomBarWhenPushed = YES;
        
        conversationVC.conversationType = ConversationType_PRIVATE;
        
        conversationVC.targetId = msgDic[@"tId"] ;
        
        conversationVC.title = @"消息";
        
        NSLog(@"%@",self.window.rootViewController);
        
        BaseTabBarController *baseTabC = (BaseTabBarController*)self.window.rootViewController;
        
        baseTabC.selectedIndex = 2;
        
        [baseTabC.viewControllers[2] pushViewController:conversationVC animated:YES];
        
    }else if ([msgDic[@"cType"] isEqualToString:@"SYS"]) {
    
        
        NoticeViewController *noticeVC = [[NoticeViewController alloc]init];
        
        noticeVC.hidesBottomBarWhenPushed = YES;
        
        BaseTabBarController *baseTabC = (BaseTabBarController*)self.window.rootViewController;
        
        baseTabC.selectedIndex = 2;
        
        [baseTabC.viewControllers[2] pushViewController:noticeVC animated:YES];
        
    }

    
//    [self goToMssageViewControllerWith:msgDic];

    
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    if (SYGData) {
        
        if ([msgDic[@"rc"][@"cType"] isEqualToString:@"PR"]) {
            
            BaseChatViewController *conversationVC = [[BaseChatViewController alloc]init];
            
            conversationVC.hidesBottomBarWhenPushed = YES;
            
            conversationVC.conversationType = ConversationType_PRIVATE;
            
            conversationVC.targetId = msgDic[@"rc"][@"tId"] ;
            
            conversationVC.title = @"消息";
            
            NSLog(@"%@",self.window.rootViewController);
            
            BaseTabBarController *baseTabC = (BaseTabBarController*)self.window.rootViewController;
            
            baseTabC.selectedIndex = 2;
            
            [baseTabC.viewControllers[2] pushViewController:conversationVC animated:YES];
            
        }else if ([msgDic[@"rc"][@"cType"] isEqualToString:@"SYS"]) {
            
            NoticeViewController *noticeVC = [[NoticeViewController alloc]init];
            
            noticeVC.hidesBottomBarWhenPushed = YES;
            
            noticeVC.isNotifation = YES;
            
            noticeVC.noticeId = msgDic[@"appData"];
            
            BaseTabBarController *baseTabC = (BaseTabBarController*)self.window.rootViewController;
            
            baseTabC.selectedIndex = 2;
            
            [baseTabC.viewControllers[2] pushViewController:noticeVC animated:YES];
            
        }

    }
    
}

- (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    [application setApplicationIconBadgeNumber:0];   //清除角标
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    NSLog(@"---applicationDidBecomeActive----");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    
    [manager GET:[NSString stringWithFormat:@"%@%@%@",serviceData[@"WDUrl"],versionjson,timeString] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        NSString *version = responseObject[@"iOS_version"][@"version"];
        
        //        NSLog(@"%@ %@",[appCurVersion substringFromIndex:appCurVersion.length - 1],[version substringFromIndex:version.length - 1]);
        //
        NSInteger oldVersion = [[appCurVersion substringFromIndex:appCurVersion.length - 1] integerValue];
        
        NSInteger newVersion = [[version substringFromIndex:version.length - 1] integerValue];
        
        //        NSLog(@"%ld %ld",oldVersion,newVersion);
        
        if (oldVersion < newVersion &&[responseObject[@"iOS_version"][@"force_update"] integerValue] == 1) {
            
            //进入前台
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            
            bgView.backgroundColor = [RGBColor colorWithHexString:@"#9999999"];
            
            [_window addSubview:bgView];
            
            UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(20, kScreenHeight/2 -90, kScreenWidth - 40, 180)];
            
            whiteV.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
            
            [bgView addSubview:whiteV];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 40 - 62)/2, 20, 62, 49)];
            
            imageV.image = [UIImage imageNamed:@"earth"];
            
            [whiteV addSubview:imageV];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 84, whiteV.width, 14)];
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label.textColor = [RGBColor colorWithHexString:@"#666666"];
            
            label.font = [UIFont systemFontOfSize:14];
            
            label.text = @"请更新奢易购最新版本再使用";
            
            [whiteV addSubview:label];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(0, 122, kScreenWidth -40, 58);
            
            [button setTitle:@"立即更新" forState:UIControlStateNormal];
            
            [button setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            
            [whiteV addSubview:button];

        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
}

- (void)buttonAction{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/mai-huo-shen-qi/id1181779041?mt=8"]];
    
}

//微博分享
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博授权成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博授权失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }

}

//iOS9以下
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //必写
    [MWApi routeMLink:url];
    
    return YES;
}

//iOS9+
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
    //必写
    [MWApi routeMLink:url];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    //如果使用了Universal link ，此方法必写
    
    return [MWApi continueUserActivity:userActivity];
}

//跳转个人主页
- (void)pushHomeAction:(NSString *)shop_id{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    if (SYGData) {
        
        PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
        
        PartnerDetailsVC.shop_id = shop_id;
        
        PartnerDetailsVC.hidesBottomBarWhenPushed = YES;
        
        BaseTabBarController *baseTabC = (BaseTabBarController*)self.window.rootViewController;
        
        [baseTabC.viewControllers[baseTabC.selectedIndex] pushViewController:PartnerDetailsVC animated:YES];
        
    
    }
    
    
}



//// 支持所有iOS系统
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//    
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//    
//}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
