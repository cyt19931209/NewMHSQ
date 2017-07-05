//
//  ChatListViewController.m
//  旧卖货神器
//
//  Created by CYT on 2017/6/19.
//  Copyright © 2017年 CYT. All rights reserved.
//

#import "ChatListViewController.h"
#import "BaseChatViewController.h"
#import "NoticeViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM)]];
    
    self.navigationItem.title = @"消息";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    NSString *RYUserId = serviceData[@"RYUserId"];

    [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_SYSTEM targetId:[NSString stringWithFormat:@"%@1",RYUserId] isTop:YES];

    self.topCellBackgroundColor = [UIColor clearColor];
    
    self.conversationListTableView.tableFooterView = [[UIView alloc]init];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];

}


- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%@",model.targetId);
    
    if (indexPath.row == 0) {
        
        NoticeViewController *noticeVC = [[NoticeViewController alloc]init];
        
        noticeVC.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:noticeVC animated:YES];
        
    }else{
        
        BaseChatViewController *conversationVC = [[BaseChatViewController alloc]init];
        
        conversationVC.hidesBottomBarWhenPushed = YES;
        
        conversationVC.conversationType = model.conversationType;
        
        conversationVC.targetId = model.targetId;
        
        conversationVC.title = @"消息";
        
        [self.navigationController pushViewController:conversationVC animated:YES];
        
    }
}


@end
