//
//  MyPartnerViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/4.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "MyPartnerViewController.h"
#import "NewPartnerViewController.h"
#import "PartnerDetailsViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface MyPartnerViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,AVCaptureMetadataOutputObjectsDelegate>{
    
    UITextField *findTextField;
    
    UIView *bgView;
    
    UIView *popUpView;
    
    
    UIView *addView;
    
    UIView *sendView;

    UIView *tureView;
    
    UIView *codeView;
    
    
    UITextField *addTextField;
    
    UIImageView *BQimageV;
    
    UILabel* BQlabel;

    UIButton *BQButton;
    
    UIView *whiteView;
    
//    UIButton *newButton;

    NSString *shop_id;
    
    NSString *apply_count;
    
    UIButton *homeButton;
    
    
    NSString *type;
    
    NSInteger page;
    
    NSInteger selectIndex;
    
    BOOL isTure;
    
    AVCaptureSession * session;//输入输出的中间桥梁

}

@property (nonatomic,strong) NSMutableArray *dataArr;

//@property (nonatomic,strong) NSArray *dataArr1;

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,copy) NSString *keyword;




@end

@implementation MyPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _keyword = @"";
    
    type = @"all";
    
    page = 1;
    
    selectIndex = 0;
    
    _dataArr = [NSMutableArray array];
    
    self.navigationItem.title = @"我的同行";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FollowNotification) name:@"FollowNotification" object:nil];

    
    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];

    
    popUpView = [[UIView alloc]initWithFrame:CGRectMake(20, kScreenHeight/2 - 100, kScreenWidth - 40, 200)];
    
    popUpView.hidden = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:popUpView];

    homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    homeButton.frame = CGRectMake(0, 0, 90, 22);
    
    [homeButton setTitleColor:[RGBColor colorWithHexString:@"949DFF"] forState:UIControlStateNormal];
    
    [homeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0, 13)];
    
    [homeButton setImageEdgeInsets:UIEdgeInsetsMake(0,77, 0,0)];
    
    homeButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [homeButton setImage:[UIImage imageNamed:@"jtdown"] forState:UIControlStateNormal];
    
    [homeButton setTitle:@"全部" forState:UIControlStateNormal];
    
    
    [homeButton addTarget:self action:@selector(homeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = homeButton;

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn setImage:[UIImage imageNamed:@"fbtj"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteView];
    
    
    findTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 34)];
    
    findTextField.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
    
    findTextField.font = [UIFont systemFontOfSize:16];
    
    findTextField.placeholder = @"请输入你要查找的内容";
    findTextField.delegate = self;
    
    findTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    findTextField.returnKeyType = UIReturnKeySearch;
    
    findTextField.clearButtonMode = UITextFieldViewModeAlways;

    [whiteView addSubview:findTextField];
    
//    [findTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, 1)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
    
    [whiteView addSubview:lineV];
    
    
//    newButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    
//    newButton.backgroundColor = [RGBColor colorWithHexString:@"#bfc4ff"];
//    
//    newButton.frame = CGRectMake(0, 56, kScreenWidth, 28);
//    
//    [newButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//    
//    newButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    
//    [newButton addTarget:self action:@selector(newButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:newButton];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 56, kScreenWidth, kScreenHeight - 56 - 64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    [self.view addSubview:_myTableView];
    
    _myTableView.sectionIndexColor = [RGBColor colorWithHexString:@"#666666"];
    
    _myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    _myTableView.tableFooterView = [[UIView alloc]init];
    
    [self loadData];
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.view addGestureRecognizer:singleRecognizer];
    
}

//筛选
- (void)homeButtonAction{
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部",@"互相关注",@"我关注的",@"关注我的", nil];
    
    [actionSheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [homeButton setTitle:@"全部" forState:UIControlStateNormal];
        
        type = @"all";

        [self loadData];

        
    }else if (buttonIndex == 1){
        
        [homeButton setTitle:@"互相关注" forState:UIControlStateNormal];
        
        type = @"me_follow_me";

        [self loadData];

        
    }else if (buttonIndex == 2){
        
        [homeButton setTitle:@"我关注的" forState:UIControlStateNormal];
        
        type = @"me_follow";

        
        [self loadData];
        
        
    }else if (buttonIndex == 3){
        
        [homeButton setTitle:@"关注我的" forState:UIControlStateNormal];
        
        type = @"follow_me";

        [self loadData];

    }
    
}


- (void)FollowNotification{
    
//    NSString *str = [noti object];
    
//    if ([str isEqualToString:@"1"]) {
    
        page = 1;
    
        [self loadData];

//    }
    
}





-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


//新的伙伴
- (void)newButtonAction{

    NewPartnerViewController *newPartnerVC = [[NewPartnerViewController alloc]init];

    
    [self.navigationController pushViewController:newPartnerVC animated:YES];
    
}


//添加伙伴
- (void)rightBtnAction{
    
    
    addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popUpView.width, 180)];
    
    addView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    addView.layer.cornerRadius = 4;
    
    addView.layer.masksToBounds = YES;
    
    [popUpView addSubview:addView];
    
    
    UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    delectButton.frame = CGRectMake(addView.width - 30, 5, 27, 27);
    
    [delectButton setImage:[UIImage imageNamed:@"wr1"] forState:UIControlStateNormal];
    
    
    [delectButton addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:delectButton];

    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, addView.width, 16)];
    textLabel.text = @"请输入同行的帐关注";
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    textLabel.font = [UIFont systemFontOfSize:16];
    
    [addView addSubview:textLabel];

    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(20, 42, kScreenWidth - 80, 34)];
    
    textView.layer.cornerRadius = 4;
    
    textView.layer.masksToBounds = YES;
    
    textView.layer.borderWidth = 1;
    
    textView.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    
    [addView addSubview:textView];
    
    
    UIImageView *textImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 22, 22)];
    
    textImageV.image = [UIImage imageNamed:@"账号"];
    
    [textView addSubview:textImageV];
    
    addTextField = [[UITextField alloc]initWithFrame:CGRectMake(42, 7, textView.width - 52, 20)];
    
    addTextField.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    addTextField.placeholder = @"请输入要添加的用户的帐号";
    
    addTextField.font = [UIFont systemFontOfSize:18];
    
    addTextField.returnKeyType = UIReturnKeySend;
    
    addTextField.delegate = self;
    
    [textView addSubview:addTextField];
    
    
    
    UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    codeButton.frame = CGRectMake(0, 97, textView.width, 20);
    
    
    [codeButton setTitleColor:[RGBColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    
    [codeButton setImage:[UIImage imageNamed:@"2code"] forState:UIControlStateNormal];
    
    codeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"或扫描同行二维码关注" attributes:attribtDic];
    
    //设置下划线颜色...
    [attribtStr addAttribute:NSForegroundColorAttributeName value:[RGBColor colorWithHexString:@"666666"]  range:NSMakeRange(0,[attribtStr length])];
    
    [attribtStr addAttribute:NSUnderlineColorAttributeName value:[RGBColor colorWithHexString:@"666666"] range:(NSRange){0,[attribtStr length]}];
    [codeButton setAttributedTitle:attribtStr forState:UIControlStateNormal];

    [codeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];

    
    [codeButton addTarget:self action:@selector(creatCodeView) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:codeButton];

    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.frame = CGRectMake(0, 138, kScreenWidth - 40, 20);
    
    [tureButton setTitle:@"确定" forState:UIControlStateNormal];

    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [tureButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [addView addSubview:tureButton];

    bgView.hidden = NO;
    
    popUpView.hidden = NO;

}

//搜索好友
- (void)searchFriend{
    
    [addTextField resignFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:addTextField.text forKey:@"keyword"];
    
    [DataSeviece requestUrl:search_friendhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        [tureView removeFromSuperview];
        
        [sendView removeFromSuperview];
        
        [addView removeFromSuperview];

        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            shop_id = result[@"result"][@"data"][@"friend_shop_id"];
            
            [self sendView:[NULLHandle NUllHandle:result[@"result"][@"data"]]];
            
        }else{
        
            [self tureView:result[@"result"][@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];


}

- (void)sendView:(NSDictionary*)dic{
    
    
    sendView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popUpView.width, 190)];
    
    sendView.backgroundColor = [RGBColor colorWithHexString:@"#f7f7fb"];
    
    sendView.layer.cornerRadius = 4;
    
    sendView.layer.masksToBounds = YES;
    
    [popUpView addSubview:sendView];
    
    
    UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    delectButton.frame = CGRectMake(sendView.width - 30, 5, 27, 27);
    
    [delectButton setImage:[UIImage imageNamed:@"wr1"] forState:UIControlStateNormal];
    
    
    [delectButton addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [sendView addSubview:delectButton];
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, addView.width, 20)];
    textLabel.text = dic[@"mobile"];
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    textLabel.textColor = [RGBColor colorWithHexString:@"#949dff"];
    
    textLabel.font = [UIFont systemFontOfSize:18];
    
    [sendView addSubview:textLabel];
    
    
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(10, 38, kScreenWidth - 40, 78)];
    
    textView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    textView.layer.cornerRadius = 4;
    
    textView.layer.masksToBounds = YES;
    
    textView.layer.borderWidth = 1;
    
    textView.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    
    [sendView addSubview:textView];
    
    UIImageView *textImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 62, 62)];
    
    [textImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl,dic[@"logo"]]]];
    
    textImageV.layer.cornerRadius = 4;
    
    textImageV.layer.masksToBounds = YES;
    
    [textView addSubview:textImageV];
    
    UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(82, 8, textView.width - 92, 16)];
    textLabel1.text = dic[@"shop_name"];
    
    textLabel1.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    textLabel1.font = [UIFont systemFontOfSize:16];
    
    [textView addSubview:textLabel1];
    
    UILabel *textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(82, textLabel1.bottom + 10, textView.width - 92, 12)];
    
    textLabel2.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"province_name"],dic[@"city_name"],dic[@"area_name"]];
    
    textLabel2.textColor = [RGBColor colorWithHexString:@"#999999"];
    
    textLabel2.font = [UIFont systemFontOfSize:12];
    
    [textView addSubview:textLabel2];


    UILabel *textLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(82, textLabel2.bottom + 10, textView.width - 92, 16)];
    
    textLabel3.text = dic[@"address"];
    
    textLabel3.textColor = [RGBColor colorWithHexString:@"#999999"];
    
    textLabel3.font = [UIFont systemFontOfSize:12];
    
    [textView addSubview:textLabel3];
    
    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.frame = CGRectMake(79, 136, sendView.width - 158, 34);
    
    [tureButton setTitle:@"确定关注" forState:UIControlStateNormal];
    
    tureButton.layer.borderWidth = 1;
    
    tureButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    
    tureButton.layer.cornerRadius = 4;
    
    tureButton.layer.masksToBounds = YES;
    
    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [tureButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [sendView addSubview:tureButton];

}
//二维码
- (void)creatCodeView{
    
    [tureView removeFromSuperview];
    
    [sendView removeFromSuperview];
    
    [addView removeFromSuperview];
    
    popUpView.height = 350;
    
    codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popUpView.width, 350)];
    
    codeView.backgroundColor = [RGBColor colorWithHexString:@"f7f7fb"];
    
    [popUpView addSubview:codeView];
    

    UIView *QGView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, popUpView.width - 30, 270)];
    
    QGView.backgroundColor = [RGBColor colorWithHexString:@"d8d8d8"];
    
    [codeView addSubview:QGView];

    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 300, popUpView.width, 16);
    label.text = @"扫一扫";
    label.font = [UIFont fontWithName:@".PingFangSC-Regular" size:16];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    label.textAlignment = NSTextAlignmentCenter;
    
    [codeView addSubview:label];
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=QGView.bounds;
    [QGView.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    
//    imageV.image = [UIImage imageNamed:@"扫码背景.png"];
//    
//    [self.view addSubview:imageV];
    
    output = [[AVCaptureMetadataOutput alloc]init];
    CGSize size = self.view.bounds.size;
    CGRect cropRect = CGRectMake(50, 160, 220, 220);
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.; //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                           cropRect.origin.x/size.width,
                                           cropRect.size.height/fixHeight,
                                           cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                           (cropRect.origin.x + fixPadding)/fixWidth,
                                           cropRect.size.height/size.height,
                                           cropRect.size.width/fixWidth);
    }

    
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count>0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        [session stopRunning];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:metadataObject.stringValue forKey:@"qrcode_str"];
        
        [DataSeviece requestUrl:search_friendhtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            [tureView removeFromSuperview];
            
            [sendView removeFromSuperview];
            
            [addView removeFromSuperview];
            
            [codeView removeFromSuperview];
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                shop_id = result[@"result"][@"data"][@"friend_shop_id"];
                
                [self sendView:[NULLHandle NUllHandle:result[@"result"][@"data"]]];
                
            }else{
                
                [self tureView:result[@"result"][@"msg"]];
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
        

    }
}


- (void)tureView:(NSString *)str{
    
    tureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, popUpView.width, 141)];
    
    tureView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    tureView.layer.cornerRadius = 4;
    
    tureView.layer.masksToBounds = YES;
    
    [popUpView addSubview:tureView];
    
    
    UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    delectButton.frame = CGRectMake(tureView.width - 30, 5, 27, 27);
    
    [delectButton setImage:[UIImage imageNamed:@"wr1"] forState:UIControlStateNormal];
    
    
    [delectButton addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [tureView addSubview:delectButton];
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, tureView.width, 16)];
    
    textLabel.text = str;
    
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    textLabel.font = [UIFont systemFontOfSize:18];
    
    [tureView addSubview:textLabel];
    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.frame = CGRectMake(0, 103, kScreenWidth - 40, 20);
    
    [tureButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [tureButton addTarget:self action:@selector(tureAction) forControlEvents:UIControlEventTouchUpInside];
    
    [tureView addSubview:tureButton];
    
}

//添加确定
- (void)addAction{
    
    
    [addView removeFromSuperview];
    
    
    if ([addTextField.text isEqualToString:@""]) {
        
        [self tureView:@"搜索账号不能为空"];

    }else{
    
        [self searchFriend];
        
        
        [addTextField resignFirstResponder];
        
        [addView removeFromSuperview];
    
    }
    
}

//发送申请
- (void)sendAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:shop_id forKey:@"friend_shop_id"];
    
    [DataSeviece requestUrl:follow_shophtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        [sendView removeFromSuperview];

        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [tureView removeFromSuperview];
            
            [addView removeFromSuperview];
            
            bgView.hidden = YES;
            
            popUpView.hidden = YES;
            
            page = 1;
            
            [self loadData];
            
        }else{
            
            [self tureView:result[@"result"][@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    

}

//确定
- (void)tureAction{
    
    [tureView removeFromSuperview];
    
    [sendView removeFromSuperview];
    
    [addView removeFromSuperview];
    
    bgView.hidden = YES;
    
    popUpView.hidden = YES;

}


//删除
- (void)delectAction{
    
    [addTextField resignFirstResponder];
    
    [tureView removeFromSuperview];
    
    [sendView removeFromSuperview];
    
    [addView removeFromSuperview];

    
    bgView.hidden = YES;
    
    popUpView.hidden = YES;
    
}

//隐藏视图
- (void)bgButtonAction{
    
    bgView.hidden = YES;
    
    popUpView.hidden = YES;
    
    [addTextField resignFirstResponder];

}

- (void)singleAction{
    
    [findTextField resignFirstResponder];
    
}

- (void)loadData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:type forKey:@"type"];
    
    [params setObject:_keyword forKey:@"keyword"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];

    [DataSeviece requestUrl:get_follow_shop_listhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        if (page == 1) {
            
            [_dataArr removeAllObjects];
        }
        

        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
        
            [_dataArr addObject:dic];
            
        }
        
//        
//        [BQimageV removeFromSuperview];
//        [BQlabel removeFromSuperview];
//        [BQButton removeFromSuperview];
//        
//        if (_dataArr.count == 0) {
//            
//            BQimageV.hidden = NO;
//            BQlabel.hidden = NO;
//            BQButton.hidden = NO;
//            
//            whiteView.hidden = YES;
//            
////            newButton.hidden = YES;
//            newButton.top = 0;
//
//            
//            BQimageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 160)/2, 31, 160, 160)];
//            BQimageV.image = [UIImage imageNamed:@"chHY"];
//            
//            [self.view addSubview:BQimageV];
//            
//            BQlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BQimageV.bottom+20, kScreenWidth, 20)];
//            
//            BQlabel.text = @"暂无好友,请点击添加";
//            
//            BQlabel.textColor = [RGBColor colorWithHexString:@"#666666"];
//            BQlabel.font = [UIFont systemFontOfSize:16];
//            BQlabel.textAlignment = NSTextAlignmentCenter;
//            [self.view addSubview:BQlabel];
//            
//            BQButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            
//            BQButton.frame = CGRectMake(kScreenWidth/2 - 34, BQlabel.bottom + 20, 78, 24);
//            
//            [BQButton setTitle:@"添加好友" forState:UIControlStateNormal];
//            
//            [BQButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
//            
//            BQButton.titleLabel.font = [UIFont systemFontOfSize:14];
//            
//            BQButton.layer.cornerRadius = 4;
//            
//            BQButton.layer.masksToBounds = YES;
//            
//            BQButton.layer.borderWidth = 1;
//            
//            BQButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
//            
//            [BQButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.view addSubview:BQButton];
//            
//        }else{
//            
//            whiteView.hidden = NO;
////            newButton.hidden = NO;
//            BQButton.hidden = YES;
//            BQimageV.hidden = YES;
//            BQlabel.hidden = YES;
//            
//            newButton.top = 56;
//        }
//
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
//    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
//    
//    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
//    
//    
//    [DataSeviece requestUrl:get_apply_counthtml params:params1 success:^(id result) {
//        
//        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
//        
//        apply_count = result[@"result"][@"data"][@"apply_count"];
//        
//        if ([apply_count integerValue] != 0) {
//            
//            newButton.hidden = NO;
//
//            [newButton setTitle:[NSString stringWithFormat:@"你现在有%@条好友申请",apply_count] forState:UIControlStateNormal];
//
//        }else{
//        
//            
//            
//            newButton.hidden = YES;
//            
//            _myTableView.top = 56;
//            
//            _myTableView.height = kScreenHeight - 56 - 64;
//            
//        }
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPartnerCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyPartnerCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 4, 36, 36)];
        
        imageV.tag = 101;
        
        imageV.backgroundColor = [RGBColor colorWithHexString:@"d8d8d8"];
        
        imageV.layer.cornerRadius = 4;
        
        imageV.layer.masksToBounds = YES;
        
        [cell.contentView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + 10, 14, kScreenWidth - 68, 14)];
        
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.tag = 102;
        
        [cell.contentView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(kScreenWidth - 33, 10, 23, 23);
        
        [button setImage:[UIImage imageNamed:@"addgz"] forState:UIControlStateSelected];
        
        [button setImage:[UIImage imageNamed:@"delgz"] forState:UIControlStateNormal];

        
//        button.backgroundColor = [RGBColor colorWithHexString:@"949DFF"];
//        
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        
//        button.layer.cornerRadius = 4;
//        
//        button.layer.masksToBounds = YES;
        
        button.tag = 103;
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:button];

        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 15, 60, 14)];
        
        label1.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        label1.font = [UIFont systemFontOfSize:14];
        
        label1.textAlignment = NSTextAlignmentRight;
        
        label1.tag = 104;
        
        [cell.contentView addSubview:label1];
        
    }
    
    cell.contentView.tag = 200 + indexPath.row;
    
    UIImageView *imageV = [cell.contentView viewWithTag:101];
    
    UILabel *label = [cell.contentView viewWithTag:102];
    
    UIButton *button = [cell.contentView viewWithTag:103];

    UILabel *label1 = [cell.contentView viewWithTag:104];

    
    [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl,_dataArr[indexPath.row][@"logo"]]] placeholderImage:[UIImage imageNamed:@"mrtx1"]];
    
    label.text = _dataArr[indexPath.row][@"shop_name"];
    
    if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"me_follow"]) {
        
//        [button setTitle:@"已关注" forState:UIControlStateNormal];
        
        label1.text = @"已关注";
        
        button.selected = NO;
        
    }else if ([_dataArr[indexPath.row][@"type"] isEqualToString:@"me_follow_me"]){
    
//        [button setTitle:@"互相关注" forState:UIControlStateNormal];
        
        label1.text = @"互相关注";
        
        button.selected = NO;


    }else{
    
        label1.text = @"加关注";
        
        button.selected = YES;

//        [button setTitle:@"关注" forState:UIControlStateNormal];
    }
    
    return cell;
    
}
//
- (void)buttonAction:(UIButton*)bt{
    
    
    isTure = bt.selected;
    
    selectIndex = bt.superview.tag - 200;
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    if (bt.selected) {

        alertV.message = @"是否确定关注";
        
    }else{
        
        alertV.message = @"是否确定取消关注";
    }
    
    [alertV show];

    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        
        NSDictionary *dic = _dataArr[selectIndex];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        NSString *url = @"";
        
        
        [params setObject:dic[@"friend_shop_id"] forKey:@"friend_shop_id"];

        
        if (isTure) {
            
            url = follow_shophtml;
            
        }else{
            
            url = unfollow_shophtml;
            
        }
        
        [DataSeviece requestUrl:url params:params success:^(id result) {
            
            NSLog(@"%@",result);
            
            page = 1;
            
            [self loadData];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PartnerDetailsViewController *PartnerDetailsVC = [[PartnerDetailsViewController alloc]init];
    
    PartnerDetailsVC.shop_id = _dataArr[indexPath.row][@"friend_shop_id"];
    
    [self.navigationController pushViewController:PartnerDetailsVC animated:YES];
    

}

- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    //改变导航栏标题的字体颜色和大小
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    
    [self.navigationController.navigationBar setShadowImage:nil];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

//- (NSString *)getFirstLetterFromString:(NSString *)aString
//{
//    //转成了可变字符串
//    NSMutableString *str = [NSMutableString stringWithString:aString];
//    //先转换为带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
//    //再转换为不带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
//    //转化为大写拼音
////    NSString *strPinYin = [str capitalizedString];
//    //获取并返回首字母
////    return [strPinYin substringToIndex:1];
//    return str;
//}
//
//- (NSArray *)searchWithFieldArray:(NSArray *)fieldArray
//                      inputString:(NSString *)inputString
//{
//    
//    NSMutableArray *backArray = [NSMutableArray array];
//
//    
//    for (NSDictionary *dic in _dataArr) {
//        
//        NSString *shop_name = dic[@"shop_name"];
//        
//        if ([shop_name rangeOfString:inputString].location != NSNotFound||[[self getFirstLetterFromString:shop_name] rangeOfString:inputString].location != NSNotFound) {
//            
//            [backArray addObject:dic];
//        }
//
//    }
//    
//    
//    return backArray;
//}


//- (void) textFieldDidChange:(id) sender {

//    
//    UITextField *_field = (UITextField *)sender;
//    
//    
//    if ([_field.text isEqualToString:@""]) {
//        
//        _dataArr1 = _dataArr;
//        
//    }else{
//    
//    NSMutableArray *arr = [NSMutableArray array];
//    
//    for (NSDictionary *dic in _dataArr) {
//        
//        [arr addObject:dic[@"shop_name"]];
//        
//    }
//
//   _dataArr1 = [self searchWithFieldArray:_dataArr inputString:_field.text];

    
//    NSLog(@"%@",_dataArr1);
//    }
//    
//    [_myTableView reloadData];

    
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];

    if (textField == findTextField) {
        
        _keyword = textField.text;
        
        [self loadData];
        
    }
    
    return YES;
}

//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    
//    
//    _dataArr1 = _dataArr;
//    
//    [_myTableView reloadData];
//
//    return YES;
//    
//}
//


@end
