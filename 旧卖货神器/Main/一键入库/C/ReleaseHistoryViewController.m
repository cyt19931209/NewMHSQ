//
//  ReleaseHistoryViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ReleaseHistoryViewController.h"
#import "MJRefresh.h"
#import "ReleaseHistoryCell.h"
#import "RepertoryPublishCell.h"
#import "ReleaseHistoryModel.h"
#import "SelectPhotoViewController.h"
#import "ReleaseDetailsViewController.h"
#import "MyPartnerViewController.h"



@interface ReleaseHistoryViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UIActionSheetDelegate,UITextFieldDelegate>{
    
    UITextField *findTextField;
    
    NSInteger page;
    
    NSInteger page1;
    
    NSInteger page2;


    
    NSInteger row;
    
    UIImageView *BQimageV;
    
    UILabel* BQlabel;

    UIView *selectView;
    
    UIButton *selectButton;
    
    BOOL isOnePhoto;
    
    float offsetY;
    
    UIButton *rightBtn;
    
    UISearchBar *searchBar;
    
    UIButton *tureButton;
    
//    BOOL isFriend;

    
    UIView *searchView;
    
    UITextField *searchTextFieldS;
    
    UIButton *searchButton;
    
    UIView *bgView;
    
    BOOL isSPSL;
    //历史搜索
    UIView *searchHistoryView;
    
}
//商品数量
@property (strong, nonatomic) UILabel *SPSLLabel;


@property (nonatomic,strong) UICollectionView *collectionView;
//我的商品
@property (nonatomic,strong) NSMutableArray *dataArr;
//伙伴商品
@property (nonatomic,strong) NSMutableArray *dataArr1;
//全部商品
@property (nonatomic,strong) NSMutableArray *dataArr2;


@property (nonatomic,strong) NSMutableArray *cellHeightArr;

@property (nonatomic,strong) NSMutableArray *cellHeightArr1;

@property (nonatomic,strong) NSMutableArray *cellHeightArr2;


@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,copy) NSString *keyword;


@end

@implementation ReleaseHistoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataNotification:) name:@"UpDataNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextViewNotification:) name:@"TextViewNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TypeSelectNotification:) name:@"TypeSelectNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DelegateNotification:) name:@"DelegateNotification" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataNotification:) name:@"editPhotoNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NewPartnerNotification:) name:@"NewPartnerNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DLTextViewNotification:) name:@"DLTextViewNotification" object:nil];


    _dataArr = [NSMutableArray array];
    
    _dataArr1 = [NSMutableArray array];

    _dataArr2 = [NSMutableArray array];

    _cellHeightArr = [NSMutableArray array];
    
    _cellHeightArr1 = [NSMutableArray array];
    
    _cellHeightArr2 = [NSMutableArray array];

    
    _keyword = @"";
    
    page = 1;
    
    page1 = 1;
    
    page1 = 2;

    
    if ([_is_delete isEqualToString:@"1"]) {
        
        self.navigationItem.title = @"回收站";
        
    }else{
//        self.navigationItem.title = @"我的商品";
    }
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    if (_IsSearch) {
        
        [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        rightBtn.hidden = NO;
        leftBtn.hidden = YES;
        
    }else{
    
        [rightBtn setTitle:@"同行" forState:UIControlStateNormal];
        rightBtn.hidden = YES;
        leftBtn.hidden = NO;
    }
    
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
//    rightBtn.hidden = YES;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteView];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    
    lineV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
    
    if (_IsSearch) {
        
        whiteView.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];

    }else{
    
        whiteView.backgroundColor = [UIColor whiteColor];

    }
    
    
    [whiteView addSubview:lineV];

    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"ReleaseHistoryCell" bundle:nil] forCellReuseIdentifier:@"ReleaseHistoryCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"RepertoryPublishCell" bundle:nil] forCellReuseIdentifier:@"RepertoryPublishCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个item的大小，
    //    flowLayout.itemSize = CGSizeMake(120, 160);
    //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    // 设置列的最小间距
    flowLayout.minimumInteritemSpacing = 5;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 5;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 98 - 49 - 6) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    _collectionView.hidden = YES;
    [self.collectionView setBackgroundColor:[RGBColor colorWithHexString:@"#f1f2fa"]];
    
    //    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EdiitPhotoCell"];
    
    [self.view addSubview:self.collectionView];
    
    __weak ReleaseHistoryViewController *weakSelf = self;
    
    
    
    if (!_IsSearch) {

        //下拉刷新
        
        _myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            if (_isFriend) {
                
                page1 = 1;
                
                [weakSelf loadData1];
                
                
            }else if (_isALL){
                
                page2 = 1;
                
                [weakSelf loadData2];
                
                
                
            }else{
                
                page = 1;
                
                [weakSelf loadData];
                
            }
            
        }];

        //下拉刷新
        
        _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (_isFriend) {
                
                page1 = 1;
                
                [weakSelf loadData1];
                
                
            }else if (_isALL){
                
                page2 = 1;
                
                [weakSelf loadData2];
                
                
            }else{
                
                page = 1;
                
                [weakSelf loadData];
                
            }
        }];
        
    }
    
    
    //上拉加载
    
    _myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if ([_typeStr isEqualToString:@"friend"]) {
            
            page1 ++;
            
            [weakSelf loadData1];
            
        }else if ([_typeStr isEqualToString:@"all"]){
            
            
            page2 ++;
            
            [weakSelf loadData2];
            
        }else{
            
            page ++;
            
            [weakSelf loadData];
            
            
        }

        
    }];
    
    //上拉加载
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (_isFriend) {
            
            page1 ++;
            
            [weakSelf loadData1];
            
            
        }else if (_isALL){
            
            page2 ++;
            
            [weakSelf loadData2];
            
            
        }else{
            
            page ++;
            
            [weakSelf loadData];
            
        }

    }];
    
    if (_isNotifation) {
        [self pushNotifation];
    }else if(_IsSearch){
        
    }else{
        
        [self loadData];

    }
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.view addGestureRecognizer:singleRecognizer];
    
    
    if ([_is_delete isEqualToString:@"1"]) {
        
        
        rightBtn.hidden = YES;
        
        whiteView.height = 54;
        
        _myTableView.top = 54;
        
        lineV.top = 53;
        _myTableView.height = kScreenHeight - 120;
        
        findTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 80, 34)];
        
        findTextField.backgroundColor = [RGBColor colorWithHexString:@"#f7f7f7"];
        
        findTextField.font = [UIFont systemFontOfSize:16];
        
        findTextField.placeholder = @"请输入你要查找的内容";
        
        findTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        findTextField.clearButtonMode = UITextFieldViewModeAlways;
        
        [whiteView addSubview:findTextField];
        
        UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        findButton.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
        
        findButton.frame = CGRectMake(kScreenWidth - 60 , 10, 50, 34);
        [findButton setTitle:@"查找" forState:UIControlStateNormal];
        findButton.titleLabel.font = [UIFont systemFontOfSize:16];
        findButton.layer.cornerRadius = 8;
        findButton.layer.masksToBounds = YES;
        [findButton addTarget:self action:@selector(findButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:findButton];
        
        
    }else{

        NSArray *titleArr = nil;
        
        if (_IsSearch) {
            
            titleArr = @[@"九图模式",@"单图模式",@"相册模式"];
            
            searchView = [[UIView alloc]initWithFrame:CGRectMake(10, 8, kScreenWidth - 70, 28)];
            
            searchView.backgroundColor = [RGBColor colorWithHexString:@"#f8f8f8"];
            
            searchView.layer.cornerRadius = 4;
            
            searchView.layer.masksToBounds = YES;
            
            [self.navigationController.navigationBar addSubview:searchView];


            searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            searchButton.frame = CGRectMake(5, 0, 60, 28);
            
            
            if ([_typeStr isEqualToString:@"friend"]) {
                
                [searchButton setTitle:@"同行商品" forState:UIControlStateNormal];
                
            }else if ([_typeStr isEqualToString:@"all"]){
                
                [searchButton setTitle:@"全部商品" forState:UIControlStateNormal];
                
            }else{
                
                [searchButton setTitle:@"我的商品" forState:UIControlStateNormal];
                
            }
            
            searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [searchButton setTitleColor:[RGBColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            
            
            [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
            [searchView addSubview:searchButton];
            
            
            UIImageView *XLImageV = [[UIImageView alloc]initWithFrame:CGRectMake(70, 11, 8, 7)];
            XLImageV.image = [UIImage imageNamed:@"下拉箭头1"];
            
            [searchView addSubview:XLImageV];
            
            searchTextFieldS = [[UITextField alloc]initWithFrame:CGRectMake(85, 7, kScreenWidth - 160, 14)];
            
            searchTextFieldS.delegate = self;
            
            searchTextFieldS.textColor = [RGBColor colorWithHexString:@"#333333"];
            
            searchTextFieldS.clearButtonMode = UITextFieldViewModeAlways;

            searchTextFieldS.placeholder = @"输入内容";
            
            searchTextFieldS.returnKeyType = UIReturnKeySearch;
            
            searchTextFieldS.font = [UIFont systemFontOfSize:14];
            
            [searchView addSubview:searchTextFieldS];

            [searchTextFieldS becomeFirstResponder];
            
        }else{
        
            titleArr = @[@"我的商品",@"同行商品",@"九图模式"];
            
            searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(67, 8, kScreenWidth - 135, 28)];
            
            searchBar.delegate = self;
            
            searchBar.barTintColor = [RGBColor colorWithHexString:@"#f8f8f8"];
            
            UITextField *searchTextField = [[[searchBar.subviews firstObject] subviews] lastObject];
            searchTextField.clearButtonMode = UITextFieldViewModeAlways;
            
            [searchTextField setBackgroundColor:[RGBColor colorWithHexString:@"#f8f8f8"]];      //修改输入框的颜色
            
            [searchTextField setValue:[RGBColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
            
            searchBar.placeholder = @"请输入搜索内容";
            
            [self.navigationController.navigationBar addSubview:searchBar];
            
            
        }
        
        
//        for (int i = 0; i < 3; i++) {
//            
//            if (i == 0) {
//                
//                selectView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/6 - 38, 7, 76, 26)];
//                
//                selectView.layer.cornerRadius = 13;
//                if (_IsSearch) {
//                    selectView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
//
//                }else{
//                    selectView.backgroundColor = [RGBColor colorWithHexString:@"#949dff"];
//                
//                }
//                [whiteView addSubview:selectView];
//                
//            }
//            
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            
//            
//            [button setTitle:titleArr[i] forState:UIControlStateNormal];
//            
//            if (_IsSearch) {
//                
//                [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//                
//            }else{
//                
//                [button setTitleColor:[RGBColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
//
//            }
//            
//            
//            button.tag = 100 + i;
//            
//            button.titleLabel.font = [UIFont systemFontOfSize:14];
//            
//            button.frame = CGRectMake(i * kScreenWidth/3, 0, kScreenWidth/3, 40);
//            
//            
//            [button addTarget:self action:@selector(SelectTheSchemaAction:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [whiteView addSubview:button];
//            
////            if (_isFriend) {
////                
////                if (i == 1) {
////                    
////                    button.selected = YES;
////                    
////                    selectButton = button;
////                    
////                    selectView.left = selectView.left + kScreenWidth/3;
////
////                    [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
////                }
////                
////            }else{
////                
////
////            }
//            
//            if (i == 0) {
//                
//                button.selected = YES;
//                
//                selectButton = button;
//                
//                if (_IsSearch) {
//                    
//                    [button setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
//                    
//                }else{
//                
//                [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//                }
//            }
//
//            
//
//            if (i == 2&&!_IsSearch){
//                
//                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 20)];
//                    
//                    view.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
//                    
//                    [button addSubview:view];
//                    
//                    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 16, 16)];
//                    
//                    imageV1.image = [UIImage imageNamed:@"jiutu"];
//                    
//                    imageV1.tag = 103;
//                    
//                    [button addSubview:imageV1];
//                    
//                    
//                    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3 - 22, 14, 12, 12)];
//                    
//                    imageV2.image = [UIImage imageNamed:@"xiala"];
//                    
//                    [button addSubview:imageV2];
//            }
//            
//            if (i == 1&&!_IsSearch) {
//                
//                _SPSLLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3 - 15 - 23, 5, 15, 15)];
//                
//                _SPSLLabel.backgroundColor = [RGBColor colorWithHexString:@"#ee0303"];
//                
//                _SPSLLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
//                
//                _SPSLLabel.font = [UIFont systemFontOfSize:10];
//                
//                _SPSLLabel.textAlignment = NSTextAlignmentCenter;
//                
//                _SPSLLabel.layer.cornerRadius = 7.5;
//                
//                _SPSLLabel.layer.masksToBounds = YES;
//                
//                _SPSLLabel.text = @"";
//                
//                _SPSLLabel.hidden = YES;
//                
//                [button addSubview:_SPSLLabel];
//                
//                if (kScreenWidth < 375) {
//                    
//                    _SPSLLabel.left = kScreenWidth/3 - 23 - 5;
//                    
//                }else{
//                    
//                    if (kScreenWidth < 400) {
//                        
//                        _SPSLLabel.left = kScreenWidth/3 - 15 - 23;
//
//                    }else{
//                        _SPSLLabel.left = kScreenWidth/3 - 15 - 23 - 5;
//
//                    }
//                    
//                }
//
//                [self SPSLAction];
//                
//
//            }
        
            
//        }
        
    }
    
    
//    tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    tureButton.hidden = YES;
//    
//    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
//    
//    [tureButton setTitle:@"选择图片" forState:UIControlStateNormal];
//    
//    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
//    
//    tureButton.frame = CGRectMake(kScreenWidth - 92, kScreenHeight - 38 - 64, 82, 28);
//    
//    tureButton.layer.cornerRadius = 4;
//    
//    tureButton.layer.masksToBounds = YES;
//    
//    tureButton.layer.borderWidth = 1;
//    
//    tureButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
//    
//    [tureButton addTarget:self action:@selector(tureButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:tureButton];
    
    //遮罩视图
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    //    bgView.alpha = .4;
    bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];

    UIImageView *selectSPImageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 84, 110)];
    
    selectSPImageV.image = [UIImage imageNamed:@"menu copy(1)"];
    
    selectSPImageV.userInteractionEnabled = YES;
    
    [bgView addSubview:selectSPImageV];
    
    
    NSArray *selectTitleArr = @[@"我的商品",@"同行商品",@"全部商品"];


    for (int i = 0; i < 3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = 200+i;
        
        button.frame = CGRectMake(0, i * 34 + 8, 84, 34);
        
        [button setTitle:selectTitleArr[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(selectSPAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [selectSPImageV addSubview:button];
        
    }
    
    if (_IsSearch) {
        
        [self SearchHistory];

    }
    
    
}

//历史搜索
- (void)SearchHistory{


    searchHistoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    searchHistoryView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:searchHistoryView];
    
    
    UILabel *historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
    
    historyLabel.text = @"历史搜索";
    
    historyLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    [searchHistoryView addSubview:historyLabel];
    
    CGFloat left = 20;
    
    CGFloat top = 40;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

    NSArray *selectTypeArr = [defaults objectForKey:[NSString stringWithFormat:@"%@Search",SYGData[@"id"]]];

    for (int i = 0; i < selectTypeArr.count; i++) {
        
        CGRect rect = [selectTypeArr[i] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (left + rect.size.width > kScreenWidth - 40) {
            top = top +30;
            left = 20;
        }
        button.frame = CGRectMake(left, top, rect.size.width+10, 20);
        
        [button setTitle:selectTypeArr[i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        button.backgroundColor = [UIColor whiteColor];
        
        button.layer.cornerRadius = 3;
        
        button.layer.masksToBounds = YES;
        
        button.layer.borderWidth = 1;
        
        button.layer.borderColor = [RGBColor colorWithHexString:@"#d9d9d9"].CGColor;
        
        button.tag = i + 300;
        
        [button setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(searchbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [searchHistoryView addSubview:button];
        
        left = left + rect.size.width + 20;
        
        
        if (i == selectTypeArr.count - 1) {
            
            top = top+30;
            left = 20;
        }
        
    }

    searchHistoryView.height = top;

}

//历史搜索按钮
- (void)searchbuttonAction:(UIButton*)bt{

    searchHistoryView.hidden = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableArray *selectTypeArr = [NSMutableArray arrayWithArray:[defaults objectForKey:[NSString stringWithFormat:@"%@Search",SYGData[@"id"]]]];
    
    searchTextFieldS.text  = selectTypeArr[bt.tag - 300];
    
    _keyword = searchTextFieldS.text;
    
    if ([_typeStr isEqualToString:@"friend"]) {
        page1 = 1;
        
        [self loadData1];
        
    }else if ([_typeStr isEqualToString:@"all"]){
        
        page2 = 1;
        
        [self loadData2];
        
    }else{
        
        page = 1;
        
        [self loadData];
        
    }

    [selectTypeArr removeObject:_keyword];

    
    [selectTypeArr insertObject:_keyword atIndex:0];
    
    if (selectTypeArr.count > 10) {
        
        [selectTypeArr removeLastObject];
    }
    
    
    [defaults setObject:[selectTypeArr copy] forKey:[NSString stringWithFormat:@"%@Search",SYGData[@"id"]]];
    
    
    [defaults synchronize];

    
}


//伙伴商品数量
- (void)SPSLAction{
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    

    [DataSeviece requestUrl:get_recently_friend_goods_counthtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"data"][@"count"] integerValue] == 0) {
            
            _SPSLLabel.hidden = YES;
            
            isSPSL = NO;
            
        }else if ([result[@"result"][@"data"][@"count"] integerValue] > 99){
            
            _SPSLLabel.hidden = NO;
            
            _SPSLLabel.text = @"99";
            
            isSPSL = YES;

            
        }else{
            
            _SPSLLabel.hidden = NO;
            
            _SPSLLabel.text = result[@"result"][@"data"][@"count"];
            
            isSPSL = YES;

            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];


}

//确定搜索模式
- (void)selectSPAction:(UIButton*)bt{
    
    bgView.hidden = YES;
    
//    searchTextFieldS.text = @"";
    
    NSArray *selectTitleArr = @[@"我的商品",@"同行商品",@"全部商品"];

    [searchButton setTitle:selectTitleArr[bt.tag - 200] forState:UIControlStateNormal];
    
    if (bt.tag == 200) {

        _typeStr = @"me";
    }else if (bt.tag == 201){
    
        _typeStr = @"friend";
        
    }else if (bt.tag == 202){
    
        _typeStr = @"all";
    }
    
    
    if ([_typeStr isEqualToString:@"friend"]) {
        page1 = 1;
        
        [self loadData1];
        
    }else if ([_typeStr isEqualToString:@"all"]){
        
        page2 = 1;
        
        [self loadData2];
        
    }else{
        
        page = 1;
        
        [self loadData];
    }

    
    
}

//选择搜索模式
- (void)searchButtonAction{
    
    bgView.hidden = NO;

}


- (void)bgButtonAction{

    bgView.hidden = YES;

}



//选择图片
- (void)tureButtonAction{
    
    
    SelectPhotoViewController *SelectPhotoVC = [[SelectPhotoViewController alloc]init];
    
    SelectPhotoVC.page = page;
    
    SelectPhotoVC.dataArr = _dataArr;
    
    [self.navigationController pushViewController:SelectPhotoVC animated:YES];
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
 
    NSInteger index = 0;

    UIButton *button = [self.view viewWithTag:102];
    
    UIImageView *imageV = [button viewWithTag:103];
    
    NSArray *cellArr = nil;
    
    
    if (_isFriend) {
        cellArr = [_cellHeightArr1 copy];
        
    }else if (_isALL){
        cellArr = [_cellHeightArr2 copy];
        
    }else{
        cellArr = [_cellHeightArr copy];
        
    }
    
    if (!_myTableView.hidden&&!isOnePhoto) {
        
        for (int i = 0; i < cellArr.count; i++) {
            
            ReleaseHistoryModel *model = cellArr[i];
            
            NSLog(@"%lf",model.cellHeight);
            
            if (offsetY - model.cellHeight - 10 > 0 ) {
                
                offsetY = offsetY - model.cellHeight - 10;
                
            }else{
                
                index = i;
                
                break;
                
            }
        }
        
    }else if (!_myTableView.hidden&&isOnePhoto) {
        
        index = offsetY/105;
        
    }else if (!_collectionView.hidden){
        
        index = offsetY/((kScreenWidth - 20) /3 + 5) * 3;
        
    }
    NSLog(@"%ld",index);
    
    

    if (buttonIndex == 0) {
        
        [button setTitle:@"九图模式" forState:UIControlStateNormal];

        imageV.image = [UIImage imageNamed:@"jiutu"];
        
        tureButton.hidden = YES;
        _collectionView.hidden = YES;
        _myTableView.hidden = NO;
        
        isOnePhoto = NO;
        
        NSLog(@"%ld",index);
        
        [_myTableView reloadData];
        
        CGFloat height = 0;
        
        for (int i = 0; i < index; i++) {
            
            ReleaseHistoryModel *model = cellArr[i];
            
            height = height + model.cellHeight + 10;
        }
        
        if (cellArr.count != 0) {
            
            offsetY = height;
            
            [_myTableView setContentOffset:CGPointMake(0, height)];
            
        }

        
        
        
    }else if (buttonIndex == 1){
        
        [button setTitle:@"单图模式" forState:UIControlStateNormal];
        
        imageV.image = [UIImage imageNamed:@"dantu"];
        
        
        tureButton.hidden = YES;
        _collectionView.hidden = YES;
        _myTableView.hidden = NO;
        
        isOnePhoto = YES;
        
        NSLog(@"%ld",index);
        [_myTableView reloadData];
        
        if (cellArr.count != 0) {
            
            offsetY = index * 105;
            
            [_myTableView setContentOffset:CGPointMake(0, index * 105)];
            
        }

    }else if (buttonIndex == 2){
        
        
        [button setTitle:@"相册模式" forState:UIControlStateNormal];
        
        imageV.image = [UIImage imageNamed:@"xiangce"];
        
        if (_isFriend) {
            
            tureButton.hidden = YES;
            
            _collectionView.height = kScreenHeight - 98 - 6;
            
        }else{
            
            tureButton.hidden = NO;
            
            _collectionView.height = kScreenHeight - 98 - 49 - 6;

        }
        
        _collectionView.hidden = NO;
        _myTableView.hidden = YES;
        
        [_collectionView reloadData];
        
        if (cellArr.count != 0) {
            
            offsetY = index/3 * ((kScreenWidth - 20) /3 + 5);
            
            [_collectionView setContentOffset:CGPointMake(0, index/3 * ((kScreenWidth - 20) /3 + 5))];
            
        }
        
        
    }
    
}


//选择模式
- (void)SelectTheSchemaAction:(UIButton*)bt{
    
    
    if (_IsSearch) {
        
        NSInteger index = 0;
        
        if (bt != selectButton) {
            
            NSArray *cellArr = nil;

            if (_isFriend) {
                cellArr = [_cellHeightArr1 copy];
                
            }else if (_isALL){
                cellArr = [_cellHeightArr2 copy];

            }else{
                cellArr = [_cellHeightArr copy];

            }

            
            selectButton.selected = NO;
            
            [bt setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
            
            [selectButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
            
            bt.selected = YES;

            if (selectButton.tag == 100) {
                
                for (int i = 0; i < cellArr.count; i++) {
                    
                    ReleaseHistoryModel *model = cellArr[i];
                    
                    NSLog(@"%lf",model.cellHeight);
                    
                    if (offsetY - model.cellHeight - 10 > 0 ) {
                        
                        offsetY = offsetY - model.cellHeight - 10;
                        
                    }else{
                        
                        index = i;
                        
                        break;
                        
                    }
                }
                
            }else if (selectButton.tag == 101) {
                
                index = offsetY/105;
                
            }else if (selectButton.tag == 102){
                
                index = offsetY/((kScreenWidth - 20) /3 + 5) * 3;
                
            }
            NSLog(@"%ld",index);

            
            if (bt.tag == 100) {
                
                selectView.left = kScreenWidth/6 - 38;
                
                isOnePhoto = NO;
                
                _myTableView.hidden = NO;
                
                _collectionView.hidden = YES;
                
                
                
                CGFloat height = 0;
                
                for (int i = 0; i < index; i++) {
                    
                    ReleaseHistoryModel *model = cellArr[i];

                    height = height + model.cellHeight + 10;
                }
                
                if (cellArr.count != 0) {
                    
                    offsetY = height;
                    
                    [_myTableView setContentOffset:CGPointMake(0, height)];
                    
                }
                
                
            }else if (bt.tag == 101){
                
                selectView.left = kScreenWidth/6 - 38 + kScreenWidth/3;
                
                isOnePhoto = YES;
                
                _myTableView.hidden = NO;
                
                _collectionView.hidden = YES;
                

                if (cellArr.count != 0) {
                    
                    offsetY = index * 105;

                    [_myTableView setContentOffset:CGPointMake(0, index * 105)];

                }
                
            }else if (bt.tag == 102){
                
                selectView.left = kScreenWidth/6 - 38 + kScreenWidth/3 * 2;
                
                isOnePhoto = NO;
                
                _myTableView.hidden = YES;
                
                _collectionView.hidden = NO;
                
                if (cellArr.count != 0) {
                    
                    offsetY = index/3 * ((kScreenWidth - 20) /3 + 5);
                    
                    [_collectionView setContentOffset:CGPointMake(0, index/3 * ((kScreenWidth - 20) /3 + 5))];
                    
                }
                
                _collectionView.height = kScreenHeight - 98 - 6;
                
            }
            
            [_myTableView reloadData];
            
            [_collectionView reloadData];

            
//            if (cellArr.count != 0) {
//                
//                if (_collectionView.hidden) {
//                    
//                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//                    
//                    [_myTableView scrollToRowAtIndexPath:indexPath
//                                        atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//                }else{
//                    
//                    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//                    
//                    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
//
//                }
//
//                
//            }

            
            selectButton = bt;
            
        }

        
    }else{
    

        if (bt != selectButton && bt.tag != 102) {
            
            [BQimageV removeFromSuperview];
            [BQlabel removeFromSuperview];
            
            UIButton *button = [self.view viewWithTag:102];
            
            UIImageView *imageV = [button viewWithTag:103];
            
            selectButton.selected = NO;
            
            [bt setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
            
            
            [selectButton setTitleColor:[RGBColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            
            bt.selected = YES;
            
            
            if (bt.tag == 100) {
                
                [self SPSLAction];
                
                selectView.left = selectView.left - kScreenWidth/3;
                
                _isFriend = NO;
                
                if (_dataArr.count == 0) {
                    
                    page = 1;
                    
                    [self loadData];
                }
                
                
                [_myTableView reloadData];
                
                [_collectionView reloadData];
                
            }else if (bt.tag == 101){
                
                _SPSLLabel.hidden = YES;
                
                selectView.left = selectView.left + kScreenWidth/3;
                
                _isFriend = YES;
                
                if (_dataArr1.count == 0||isSPSL) {
                    
                    isSPSL = NO;
                    
                    page1 = 1;
                    
                    [self loadData1];
                }
                
                [_myTableView reloadData];
                
                [_collectionView reloadData];
                
            }
            
            selectButton = bt;
            
            [button setTitle:@"九图模式" forState:UIControlStateNormal];
            
            imageV.image = [UIImage imageNamed:@"jiutu"];
            
            tureButton.hidden = YES;
            _collectionView.hidden = YES;
            _myTableView.hidden = NO;
            
            isOnePhoto = NO;
            
            
            [_myTableView reloadData];
            
            
        }
        
        if (bt.tag == 102) {
            
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"九图模式",@"单图模式",@"相册模式",nil];
            
            [actionSheet showInView:self.view];
            
        }
        
    }
    
}

#pragma mark - UIScrollViewDelegate 委托

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;

    offsetY = offset.y;
    
    NSLog(@"%lf",offset.y);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"滑动开始");
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    

    
    NSLog(@"滑动结束");
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (_isFriend) {
        return _dataArr1.count;
    }else if (_isALL){
        return _dataArr2.count;

    }else{
        return _dataArr.count;

    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"EdiitPhotoCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth - 20)/3, (kScreenWidth - 20)/3)];
    
    imageV.backgroundColor = [RGBColor colorWithHexString:@"#d8d8d8"];
    
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    
    imageV.clipsToBounds = YES;
    
    [cell.contentView addSubview:imageV];
    
    NSArray *imageArr = nil;
    
    if (_isFriend) {
        imageArr = _dataArr1[indexPath.row][@"img"];

    }else if (_isALL){
        imageArr = _dataArr2[indexPath.row][@"img"];

    }else{
        imageArr = _dataArr[indexPath.row][@"img"];

    }
    
    if (imageArr.count != 0) {
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageArr[0][@"thumbnail"]]]];
        
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        imageV.clipsToBounds = YES;

    }else{
    
        imageV.image = [UIImage imageNamed:@"MRLG"];
    
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ReleaseDetailsViewController *ReleaseDetailsVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"ReleaseDetailsViewController"];
    
    ReleaseDetailsVC.index = indexPath.item;    
    if (_isFriend) {
        ReleaseDetailsVC.isFriend = YES;

        ReleaseDetailsVC.share_id = _dataArr1[indexPath.row][@"id"];

    }else if (_isALL){
        ReleaseDetailsVC.isFriend = YES;
        
        ReleaseDetailsVC.share_id = _dataArr2[indexPath.row][@"id"];
        
    }else{
        
        ReleaseDetailsVC.isGoods = YES;
        ReleaseDetailsVC.share_id = _dataArr[indexPath.row][@"id"];

    }
    
    [self.navigationController pushViewController:ReleaseDetailsVC animated:YES];
    

}



#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - 20)/3, (kScreenWidth - 20)/3);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)singleAction{
    
    [searchTextFieldS resignFirstResponder];
    
    [searchBar resignFirstResponder];
    
    [findTextField resignFirstResponder];
    
}

- (void)findButtonAction{
    
    [findTextField resignFirstResponder];
    
    [_myTableView setContentOffset:CGPointMake(0,0) animated:NO];

    _keyword = findTextField.text;
    
    page = 1;
    
    [self loadData];
    
}

- (void)NewPartnerNotification:(NSNotification*)noti{
    
    NSString *str = [noti object];
    
    if ([str isEqualToString:@"1"]) {
        
        page1 = 1;
        
        [self loadData1];
        
        [self applyCount];
        
    }else{
    
        [self applyCount];

    }
    
    
  
    
}

//通知跳转
- (void)pushNotifation{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_goods_id forKey:@"goods_id"];
    
    
    [params setObject:_is_delete forKey:@"is_delete"];
    
    [DataSeviece requestUrl:get_goods_positionhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        page = [result[@"result"][@"data"][@"page"] integerValue];
        
        row = [result[@"result"][@"data"][@"row"] integerValue];
        
        [self loadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

- (void)loadData{
    
    [BQimageV removeFromSuperview];
    [BQlabel removeFromSuperview];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];

    
    NSString *url = @"";
    
    if ([_is_delete isEqualToString:@"1"]) {
        
        url = ShareGoodsget_goods_listhtml;
        
        [params setObject:_is_delete forKey:@"is_delete"];

        [params setObject:_keyword forKey:@"keyword"];
        
        [params setObject:@"me" forKey:@"type"];

    }else{
    
        if (_IsSearch) {
            
            
//            [params setObject:_is_delete forKey:@"is_delete"];
            
            [params setObject:_keyword forKey:@"keyword"];
            
            [params setObject:_typeStr forKey:@"type"];

        }else{
        
            url = Shareget_goods_listhtml;
            
            [params setObject:@"12" forKey:@"pagesize"];

        }
    }
    
    url = ShareGoodsget_goods_listhtml;
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if (page == 1) {
            
            [_dataArr removeAllObjects];
            
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            BOOL isCopy = NO;
            
            for (NSDictionary *dic1 in _dataArr) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
                    isCopy = YES;
                }
            }
            
            if (!isCopy) {
                
                ReleaseHistoryModel *model = [[ReleaseHistoryModel alloc]init];
                
                model.dic = dic;
                
                [_cellHeightArr addObject:model];
                
                [_dataArr addObject:dic];
            }
            
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_myTableView reloadData];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        [_collectionView reloadData];
        
//        NSUInteger ii[2] = {0, rowCount - 1};
//        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
        
        if (_isNotifation) {
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:row - 1 ];
            
            
            if (_dataArr.count < row) {
                
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"该商品已删除或不存在" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertV show];
                
                return ;
                
            }
            
            [_myTableView scrollToRowAtIndexPath:indexPath
                                atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        if (_dataArr.count == 0) {
            
            BQimageV.hidden = NO;
            BQlabel.hidden = NO;
            
            BQimageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 80, 128, 128)];
            BQimageV.image = [UIImage imageNamed:@"bq@2x"];
            
            [self.view addSubview:BQimageV];
            
            BQlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BQimageV.bottom+10, kScreenWidth, 20)];
            
            BQlabel.text = @"没有搜索到数据";
            
            BQlabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            BQlabel.font = [UIFont systemFontOfSize:16];
            BQlabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:BQlabel];
            
        }else{
        
            BQimageV.hidden = YES;
            BQlabel.hidden = YES;
        }
        
    } failure:^(NSError *error) {
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
        NSLog(@"%@",error);
        
    }];
    

    [self applyCount];
    
}

//伙伴商品
- (void)loadData1{
    
    [BQimageV removeFromSuperview];
    [BQlabel removeFromSuperview];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page1] forKey:@"page"];
    
    [params setObject:_keyword forKey:@"keyword"];
    
    [params setObject:_typeStr forKey:@"type"];

    
    [DataSeviece requestUrl:ShareGoodsget_goods_listhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if (page1 == 1) {
            
            [_dataArr1 removeAllObjects];
            
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            BOOL isCopy = NO;
            
            for (NSDictionary *dic1 in _dataArr1) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
                    isCopy = YES;
                }
            }
            
            if (!isCopy) {
                
                ReleaseHistoryModel *model = [[ReleaseHistoryModel alloc]init];
                
                model.dic = dic;
                
                [_cellHeightArr1 addObject:model];
                
                [_dataArr1 addObject:dic];
            }
            
        }
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_myTableView reloadData];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        [_collectionView reloadData];
        
        //        NSUInteger ii[2] = {0, rowCount - 1};
        //        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
        
        if (_isNotifation) {
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:row - 1 ];
            
            [_myTableView scrollToRowAtIndexPath:indexPath
                                atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        if (_dataArr1.count == 0) {
            
            BQimageV.hidden = NO;
            BQlabel.hidden = NO;
            
            BQimageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 80, 128, 128)];
            BQimageV.image = [UIImage imageNamed:@"bq@2x"];
            
            [self.view addSubview:BQimageV];
            
            BQlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BQimageV.bottom+10, kScreenWidth, 20)];
            
            BQlabel.text = @"没有搜索到数据";
            
            BQlabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            BQlabel.font = [UIFont systemFontOfSize:16];
            BQlabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:BQlabel];
            
        }else{
            
            BQimageV.hidden = YES;
            BQlabel.hidden = YES;
        }
        
    } failure:^(NSError *error) {
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
        NSLog(@"%@",error);
        
    }];
    
}

//全部商品
- (void)loadData2{
    
    [BQimageV removeFromSuperview];
    [BQlabel removeFromSuperview];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",page2] forKey:@"page"];
    
    [params setObject:_keyword forKey:@"keyword"];
    
    [params setObject:_typeStr forKey:@"type"];
    
    [DataSeviece requestUrl:ShareGoodsget_goods_listhtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if (page2 == 1) {
            
            [_dataArr2 removeAllObjects];
            
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            BOOL isCopy = NO;
            
            for (NSDictionary *dic1 in _dataArr2) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
                    isCopy = YES;
                }
            }
            
            if (!isCopy) {
                
                ReleaseHistoryModel *model = [[ReleaseHistoryModel alloc]init];
                
                model.dic = dic;
                
                [_cellHeightArr2 addObject:model];
                
                [_dataArr2 addObject:dic];
            }
        }
        
        NSLog(@"%@",_dataArr2);
        
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_myTableView reloadData];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        [_collectionView reloadData];
        
        if (_dataArr2.count == 0) {
            
            BQimageV.hidden = NO;
            
            BQlabel.hidden = NO;
            
            BQimageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 128)/2, 80, 128, 128)];
            BQimageV.image = [UIImage imageNamed:@"bq@2x"];
            
            [self.view addSubview:BQimageV];
            
            BQlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BQimageV.bottom+10, kScreenWidth, 20)];
            
            BQlabel.text = @"没有搜索到数据";
            
            BQlabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            BQlabel.font = [UIFont systemFontOfSize:16];
            BQlabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:BQlabel];
            
        }else{
            
            BQimageV.hidden = YES;
            BQlabel.hidden = YES;
        }
        
    } failure:^(NSError *error) {
        
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
        NSLog(@"%@",error);
        
    }];
    
}


//伙伴请求数量
- (void)applyCount{
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
//    
//    
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    
//    
//    [DataSeviece requestUrl:get_apply_counthtml params:params success:^(id result) {
//        
//        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
//        
//        if (!_IsSearch) {
//            
//            
//            UILabel *label = [rightBtn viewWithTag:10000];
//            
//            if (!label) {
//                
//                label = [[UILabel alloc]initWithFrame:CGRectMake(rightBtn.width - 12, 0, 12, 12)];
//                
//                label.tag = 10000;
//            }
//            
//            if ([result[@"result"][@"data"][@"apply_count"] integerValue] != 0) {
//                
//                
//                label.hidden = NO;
//                
//                label.textAlignment = NSTextAlignmentCenter;
//                
//                label.layer.cornerRadius = 6;
//                
//                label.layer.masksToBounds = YES;
//                
//                label.backgroundColor = [RGBColor colorWithHexString:@"#ee0303"];
//                
//                label.textColor = [RGBColor colorWithHexString:@"#ffffff"];
//                
//                label.font = [UIFont systemFontOfSize:10];
//                
//                [rightBtn addSubview:label];
//                
//                label.text = result[@"result"][@"data"][@"apply_count"];
//                
//            }else{
//                
//                label.hidden = YES;
//                
//            }
//            
//        }
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
//    
    
}



#pragma mark --UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    if ([_typeStr isEqualToString:@"friend"]) {
        return _dataArr1.count;
    }else if ([_typeStr isEqualToString:@"all"]){
        
        return _dataArr2.count;
    }
    
    return _dataArr.count;

    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    if ([_typeStr isEqualToString:@"friend"]) {
        dic = _dataArr1[indexPath.section];
    }else if ([_typeStr isEqualToString:@"all"]){
        
        dic = _dataArr2[indexPath.section];
    }else{
        dic = _dataArr[indexPath.section];
    }

    

    if (isOnePhoto) {
        
        RepertoryPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepertoryPublishCell" forIndexPath:indexPath];

        cell.dic = dic;
        
        return cell;

    }else{
        
        ReleaseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseHistoryCell" forIndexPath:indexPath];
        cell.is_delete = _is_delete;
        cell.index = indexPath.section;

        cell.dic = dic;

        
//        if ([SYGData[@"shop_id"] isEqualToString:dic[@"shop_id"]]||!dic[@"shop_id"]) {
//        }else{
//        
//            cell.dic1 = dic;
//        }
        
        
        return cell;
    }
    
    return nil;
    
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

- (void)leftBtnAction{
    
    
    [searchBar removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightBtnAction{
    
    
    if (_IsSearch) {
     
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
    
        MyPartnerViewController *MyPartnerVC = [[MyPartnerViewController alloc]init];
        
        
        [self.navigationController pushViewController:MyPartnerVC animated:YES];
    
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (isOnePhoto) {
        
        
        NSDictionary *dic = nil;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        
        
        if ([_typeStr isEqualToString:@"friend"]) {
            dic = _dataArr1[indexPath.section];
        }else if ([_typeStr isEqualToString:@"all"]){
            
            dic = _dataArr2[indexPath.section];
        }else{
            dic = _dataArr[indexPath.section];
        }

        
        ReleaseDetailsViewController *ReleaseDetailsVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"ReleaseDetailsViewController"];
        ReleaseDetailsVC.index = indexPath.section;
        
        if (_isFriend) {
            
            ReleaseDetailsVC.isFriend = YES;
            ReleaseDetailsVC.share_id = _dataArr1[indexPath.section][@"id"];

        }else if (_isALL){
        
            if ([SYGData[@"shop_id"] isEqualToString:dic[@"shop_id"]]||!dic[@"shop_id"]) {
                ReleaseDetailsVC.isGoods = YES;
                
            }else{
                
                ReleaseDetailsVC.isFriend = YES;
            }

            ReleaseDetailsVC.share_id = _dataArr2[indexPath.section][@"id"];
            
        }else{
            
            ReleaseDetailsVC.isGoods = YES;
            ReleaseDetailsVC.share_id = _dataArr[indexPath.section][@"id"];

        }
        
        [self.navigationController pushViewController:ReleaseDetailsVC animated:YES];
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (isOnePhoto) {
        
        return 100;
        
    }else{
    
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
        
        CGFloat height = 0;
        
        NSDictionary *dic = nil;
        
        NSArray *arr  = nil;
        
        if ([_typeStr isEqualToString:@"friend"]) {
            dic = _dataArr1[indexPath.section];
        }else if ([_typeStr isEqualToString:@"all"]){
            
            dic = _dataArr2[indexPath.section];
        }else{
            dic = _dataArr[indexPath.section];
        }
        
        arr = dic[@"img"];
        
        
        
        
        NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
        
        CGFloat emptylen = 20;
        paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
        
        CGRect rect = [dic[@"goods_description"] boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paraStyle01} context:nil];
        height = 80 + rect.size.height + 5;
        
        if (arr.count < 4) {
            
            height = height + kScreenWidth/4;
            
        }else if (arr.count > 3 && arr.count < 7){
            
            height = height + kScreenWidth/2 + 5;
            
        }else if (arr.count > 6){
            
            height = height + kScreenWidth/4 * 3 + 10;
            
        }
        
        NSArray *typeArr = @[@"ponhu",@"aidingmao",@"vdian",@"liequ",@"newshang",@"shopuu",@"xiaohongshu",@"aidingmaopro",@"aidingmaomer",@"jiuai"];
        
        NSMutableArray *unstatusArr = [NSMutableArray array];
        
        for (NSString *str in dic[@"unstatus"]) {
            
            if ([typeArr containsObject:str]) {
                
                [unstatusArr addObject:str];
            }
        }
        
        height = height + 10;
        
        if (unstatusArr.count != 0) {
            height = height + 80;
        }
        
        if ([dic[@"is_friend_goods"] isEqualToString:@"1"]) {
            
            height = height + 60;
        }
        
        
        return height;
    }
    return 0;
}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (isOnePhoto) {
        return 0.00001f;

    }else{
        return 10;

    }
    
    return 0.00001f;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (isOnePhoto) {
        return 5;
        
    }else{
        return 0.00001f;
    }
    

    
    return 0.00001f;
}




//通知
- (void)UpDataNotification:(NSNotification*)noti{

    page = 1;
    
    [self loadData];

}

- (void)DelegateNotification:(NSNotification*)noti{
    
    
    NSInteger index = [[noti object] integerValue];
    
    NSLog(@"%ld",index);
    
    if (_dataArr.count > index) {
        
        [_dataArr removeObjectAtIndex:index];
        
    }
    
    [_myTableView reloadData];
    
    [_collectionView reloadData];
    
}

- (void)TypeSelectNotification:(NSNotification*)noti{
    
    
    NSInteger index = [[noti object][@"index"] integerValue];
    
    NSLog(@"%ld",index);
    
    if (_dataArr.count > index) {

        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
        
        [dic setObject:[noti object][@"num"] forKey:[noti object][@"type"]];
        
        NSLog(@"%@",dic);
        
        [_dataArr replaceObjectAtIndex:index withObject:[dic copy]];
        
        [_myTableView reloadData];
        
        [_collectionView reloadData];

    }
    
}

- (void)TextViewNotification:(NSNotification*)noti{

    NSDictionary *dic = [noti object];
    
    NSInteger index = [dic[@"1"] integerValue];
    
    if (_dataArr.count > index) {
     
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[[dic[@"1"] integerValue]]];
        
        NSLog(@"%@",mutableDic);
        
        [mutableDic setObject:dic[@"2"] forKey:@"goods_description"];
        
        [_dataArr replaceObjectAtIndex:[dic[@"1"] integerValue] withObject:[mutableDic copy]];
        
        [_myTableView reloadData];
        
        [_collectionView reloadData];

    }
    
}

- (void)DLTextViewNotification:(NSNotification*)noti{
    
    NSDictionary *dic = [noti object];
    
    NSInteger index = [dic[@"1"] integerValue];
    
    if (_dataArr.count > index) {
        
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[[dic[@"1"] integerValue]]];
        
        NSLog(@"%@",mutableDic);
        
        [mutableDic setObject:dic[@"2"] forKey:@"agency_price"];
        
        [_dataArr replaceObjectAtIndex:[dic[@"1"] integerValue] withObject:[mutableDic copy]];
        
        [_myTableView reloadData];
        
        [_collectionView reloadData];
        
    }
    
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
    
    searchBar.text = @"";
    
    if (_IsSearch) {
        
//        rightBtn.hidden = NO;
        
        
        searchBar.hidden = YES;
        
        searchView.hidden = NO;

        [searchBar becomeFirstResponder];

    }else{
    
        searchBar.hidden = NO;
        
        searchView.hidden = YES;


//        rightBtn.hidden = YES;
        
    }

}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    searchBar.hidden = YES;
    
    searchView.hidden = YES;
    
    [searchTextFieldS resignFirstResponder];
    
    [searchBar resignFirstResponder];

}



#pragma mark - UISearchBarDelegate 委托


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    if (_IsSearch) {
        
        
    }else{
        
        ReleaseHistoryViewController *ReleaseHistoryVC = [[ReleaseHistoryViewController alloc]init];
        ReleaseHistoryVC.is_delete = @"2";
        ReleaseHistoryVC.IsSearch = YES;
        
        ReleaseHistoryVC.isFriend = _isFriend;
        
        [self.navigationController pushViewController:ReleaseHistoryVC animated:YES];
    
    }
    
    
    return YES;
}


//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//
//    [searchBar resignFirstResponder];
//    
//    _keyword = searchBar.text;
//
//    if (_isFriend) {
//        page1 = 1;
//        
//        [self loadData1];
// 
//    }else{
//    
//        page = 1;
//        
//        [self loadData];
//    }
//
//}

#pragma mark - UITextFieldDelegate 委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    searchHistoryView.hidden = YES;
    
    [textField resignFirstResponder];
    
    _keyword = searchTextFieldS.text;
    
    if ([_typeStr isEqualToString:@"friend"]) {
        page1 = 1;
        
        [self loadData1];
        
    }else if ([_typeStr isEqualToString:@"all"]){
        
        page2 = 1;
        
        [self loadData2];
        
    }else{
        
        page = 1;
    
        [self loadData];
    }

    _keyword = [_keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([_keyword isEqualToString:@""]) {

    
    }else{
    
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableArray *selectTypeArr = [NSMutableArray arrayWithArray:[defaults objectForKey:[NSString stringWithFormat:@"%@Search",SYGData[@"id"]]]];
        
        BOOL isContains = NO;
        
        for (NSString *str in selectTypeArr) {
            
            if ([_keyword isEqualToString:str]) {
                isContains = YES;
            }
            
        }
        
        if (isContains) {
            [selectTypeArr removeObject:_keyword];
        }
        
        
        [selectTypeArr insertObject:_keyword atIndex:0];
        
        if (selectTypeArr.count > 10) {
            
            [selectTypeArr removeLastObject];
        }
        
        
        [defaults setObject:[selectTypeArr copy] forKey:[NSString stringWithFormat:@"%@Search",SYGData[@"id"]]];
        
        
        [defaults synchronize];
    
    
    }

    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{

    
    
    _keyword = @"";
    
    
    if (_isFriend) {
        page1 = 1;
        
        [self loadData1];
        
    }else if (_isALL){
        
        page2 = 1;
        
        [self loadData2];
        
    }else{
        
        page = 1;
        
        [self loadData];
        
    }

    
    
    return YES;

}


- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
