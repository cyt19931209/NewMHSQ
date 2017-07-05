//
//  AppDelegate.h
//  旧卖货神器
//
//  Created by CYT on 2017/6/16.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"ee6f5e23388c39b64a803ece";
static NSString *channel = @"APP store";
static BOOL isProduction = NO;


@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>
{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;




@end

