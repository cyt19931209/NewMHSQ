//
//  SelectPhotoViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "SelectPhotoCell.h"
#import "GeneratedPuzzlesViewController.h"
#import "MBProgressHUD.h"
#import "SharedItem.h"
#import "MJRefresh.h"
#import "TheTemplateSelectionViewController.h"

@interface SelectPhotoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) NSMutableArray *selectArr;


@property (nonatomic,assign) NSInteger item;


@property (nonatomic,strong) NSMutableArray *newdataArr;


@end

@implementation SelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _newdataArr = [NSMutableArray arrayWithArray:_dataArr];
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];

    _selectArr = [NSMutableArray array];
    
    _item = 0;
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    
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
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[RGBColor colorWithHexString:@"#ffffff"]];
    
    //    //注册Cell，必须要有
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"SelectPhotoCell"];
    
    [self.view addSubview:self.collectionView];
    
    
    __weak SelectPhotoViewController *weakSelf = self;

    //上拉加载
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
        
        [weakSelf loadData];
        
    }];
    
    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [tureButton setTitle:@"生成拼图" forState:UIControlStateNormal];
    
    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    tureButton.frame = CGRectMake(kScreenWidth - 92, kScreenHeight - 38 - 64, 82, 28);
    
    tureButton.layer.cornerRadius = 4;
    
    tureButton.layer.masksToBounds = YES;
    
    tureButton.layer.borderWidth = 1;
    
    tureButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    
    [tureButton addTarget:self action:@selector(tureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tureButton];
    
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    sendButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [sendButton setTitle:@"发朋友圈" forState:UIControlStateNormal];
    
    [sendButton setTitleColor:[RGBColor colorWithHexString:@"#3cb034"] forState:UIControlStateNormal];
    
    sendButton.frame = CGRectMake(kScreenWidth - 92 - 92, kScreenHeight - 38 - 64, 82, 28);
    
    sendButton.layer.cornerRadius = 4;
    
    sendButton.layer.masksToBounds = YES;
    
    sendButton.layer.borderWidth = 1;
    
    sendButton.layer.borderColor = [RGBColor colorWithHexString:@"#3cb034"].CGColor;
    
    [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sendButton];

    
}


- (void)loadData{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    
    [params setObject:[NSString stringWithFormat:@"%ld",_page] forKey:@"page"];
    
    
    NSString *url = @"";
    
    url = Shareget_goods_listhtml;
    
    [params setObject:@"12" forKey:@"pagesize"];
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if (_page == 1) {
            
            [_newdataArr removeAllObjects];
            
        }
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            BOOL isCopy = NO;
            
            for (NSDictionary *dic1 in _newdataArr) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
                    
                    isCopy = YES;
                }
            }
            
            
            if (!isCopy) {
                
       
                [_newdataArr addObject:dic];
            }
            
        }
        
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        [_collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
        NSLog(@"%@",error);
        
    }];
    
}



//发朋友圈
- (void)sendButtonAction{

    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
    
    for (NSDictionary *dic1 in _selectArr) {
        
        [urlStr addObject:dic1[@"img"][0][@"image_url"]];
        
        [imageArr addObject:@""];
        
    }
    
    NSLog(@"%@",urlStr);
    
    __block NSInteger item1 = 0;
    
    for (int i = 0 ; i < urlStr.count; i++) {
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            NSLog(@"");
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            item1++;
            [hud hide:YES];
            
            if (item1 == urlStr.count) {
                
                __block NSInteger item2 = 0;
                
                for (int j = 0 ; j < urlStr.count; j++) {
                    
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr[j]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        NSLog(@"");
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                        item2++;
                        
                        NSLog(@"%d",j);
                        
                        if (error) {
                            
                        }
                        if (image) {
                            
                            [imageArr replaceObjectAtIndex:j withObject:image];
                            
                            if (item2 == urlStr.count) {
                                
                                [self WXpush:imageArr];
                                
                            }
                        }
                    }];
                }
            }
        }];
    }


}

- (void)WXpush:(NSArray*)imageArr{
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    [params setObject:_dic[@"id"] forKey:@"goods_id"];
//    [params setObject:@"wechat" forKey:@"type"];
//    
//    [DataSeviece requestUrl:add_share_loghtml params:params success:^(id result) {
//        NSLog(@"%@ %@",result,result[@"rsult"][@"msg"]);
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    NSLog(@"%@",imageArr);
    
    for (int i = 0; i < imageArr.count; i++) {
        
        UIImage *imagerang = imageArr[i];
        
        //        imagerang = [self scaleFromImage:imagerang scaledToSize:CGSizeMake(500, 500)];
        
        //        printf("%lf %lf",imagerang.size.width,imagerang.size.height);
        NSLog(@"%lf %lf",imagerang.size.width,imagerang.size.height);
        
        NSString *path_sandox = NSHomeDirectory();
        
        NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/ShareWX%d.jpg",i]];
        [UIImagePNGRepresentation(imagerang) writeToFile:imagePath atomically:YES];
        
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        
        /** 这里做个解释 imagerang : UIimage 对象  shareobj:NSURL 对象 这个方法的实际作用就是 在吊起微信的分享的时候 传递给他 UIimage对象,在分享的时候 实际传递的是 NSURL对象 达到我们分享九宫格的目的 */
        
        SharedItem *item = [[SharedItem alloc] initWithData:imagerang andFile:shareobj];
        
        [array addObject:item];
        
    }
    
    NSLog(@"%@",array);
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:array
                                                                                        applicationActivities:nil];
    
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypeAirDrop];
    
    [self presentViewController:activityViewController animated:TRUE completion:nil];
    
    
}


//确定生成
- (void)tureButtonAction{
    
    if (_selectArr.count < 3) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选择的图片不能小于3个" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertV show];
        

        return;
    }
    TheTemplateSelectionViewController *GeneratedPuzzlesVC = [[TheTemplateSelectionViewController alloc]init];
    
    GeneratedPuzzlesVC.selectArr = [_selectArr copy];
    
    [self.navigationController pushViewController:GeneratedPuzzlesVC animated:YES];
    
    
    
  
}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _newdataArr.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectPhotoCell" forIndexPath:indexPath];

    cell.dic = _newdataArr[indexPath.row];

    NSDictionary *dic = _newdataArr[indexPath.row];

    
    for (int i = 0; i < _selectArr.count; i++) {
        
        if ([_selectArr[i] isEqualToDictionary:dic]) {
            
            cell.bgView.hidden = NO;
            cell.numLabel.hidden = NO;
            cell.selectImageV.image = [UIImage imageNamed:@"choisexcse"];
            
            cell.numLabel.text = [NSString stringWithFormat:@"%d",i + 1];

            break;
            
        }else{
        
            cell.bgView.hidden = YES;
            
            cell.numLabel.hidden = YES;

            cell.numLabel.text = @"";

            cell.selectImageV.image = [UIImage imageNamed:@"nochoise"];

        }
        
    }
    
    if (_selectArr.count == 0) {
        
        cell.bgView.hidden = YES;
        
        cell.numLabel.hidden = YES;
        
        cell.numLabel.text = @"";
        
        cell.selectImageV.image = [UIImage imageNamed:@"nochoise"];
        
        
    }
    
    
    return cell;
    
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

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = _newdataArr[indexPath.row];
    

    BOOL isSelect = NO;
    
    for (NSDictionary *dic1 in _selectArr) {
        
        if ([dic isEqualToDictionary:dic1]) {
            isSelect = YES;
        }
        
    }
    
    if (isSelect) {
        
        [_selectArr removeObject:dic];
        
    }else{
        
        NSArray *imageArr = dic[@"img"];
        
        if (imageArr.count == 0) {
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你选择的商品没有图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
            return;

        }
        
        
        if (_selectArr.count > 11) {
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选择的图片不能超过12个" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
            return;
        }else{
            
            [_selectArr addObject:dic];

        }
    }
    
    
    
    [collectionView reloadData];
    
}

//返回
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"选择图片";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

@end
