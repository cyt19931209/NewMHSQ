//
//  WebViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>


//@property (nonatomic,weak) JSContext * context;


@end

@implementation WebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [webView setUserInteractionEnabled:YES];//是否支持交互

    if (_isNotifation) {
        //左边Item
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 10, 19);
        [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        
        
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];

    }else{
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSLog(@"%@",SYGData);
        
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/Share/Oauth2/k1/%@/k2/%@/k4/vdian",WDUrl,SYGData[@"shop_id"],SYGData[@"id"]]]]];
        NSLog(@"%@/Api/Share/Oauth2/k1/%@/k2/%@/k4/vdian",imgUrl,SYGData[@"shop_id"],SYGData[@"id"]);
    
    }
    
    webView.delegate=self;
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕

    [self.view addSubview:webView];
    
    //获取js的运行环境
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"javascript:window.app.close"] = ^() {
        NSLog(@"点击");
    };
    
    
}

- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSData * data = [NSData dataWithContentsOfURL:webView.request.URL];
    NSString *theXML = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    NSLog(@"parseHtml:  %@",theXML);
    
    
}




@end
