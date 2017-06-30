//
//  EdiitPhotoViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/11/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "EdiitPhotoViewController.h"

@interface EdiitPhotoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger item;
@end

@implementation EdiitPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArr = [NSMutableArray array];
    
    
    for (int i = 0; i < _imageURLArr.count; i++) {
        
        [_dataArr addObject:@"0"];

    }
    
    _item = 0;
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个item的大小，
//    flowLayout.itemSize = CGSizeMake(120, 160);
    //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    // 设置列的最小间距
    flowLayout.minimumInteritemSpacing = 10;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 10;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[RGBColor colorWithHexString:@"#f1f2fa"]];
    
//    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EdiitPhotoCell"];
    
    [self.view addSubview:self.collectionView];

    
}


#pragma mark -- UICollectionViewDataSource

//// 返回分区数
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return 1;
//}
//

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSLog(@"%ld",_imageURLArr.count);
    return _imageURLArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"EdiitPhotoCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth - 40)/3, (kScreenWidth - 40)/3)];
    
    imageV.backgroundColor = [RGBColor colorWithHexString:@"#d8d8d8"];
    
    [cell.contentView addSubview:imageV];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_imageURLArr[indexPath.row]]]];
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth - 40)/3, (kScreenWidth - 40)/3)];
    bgV.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    bgV.alpha = .4;
    [cell.contentView addSubview:bgV];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 40)/6 - 12, (kScreenWidth - 40)/6 - 12, 24, 24)];
    
    label.backgroundColor = [RGBColor colorWithHexString:@"#000000"];
    label.alpha = .4;
    label.text = @"1";
    label.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 12;
    label.layer.masksToBounds = YES;
    [cell.contentView addSubview:label];
    
    if ([_dataArr[indexPath.row] isEqualToString:@"0"]) {
        
        bgV.hidden = YES;
        label.hidden = YES;
        
    }else{
        bgV.hidden = NO;
        label.hidden = NO;
        label.text = _dataArr[indexPath.row];
    }
    
    return cell;
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - 50)/3, (kScreenWidth - 50)/3);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row] isEqualToString:@"0"]) {
        _item++;
        [_dataArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%ld",(long)_item]];
        
        if (_item == _dataArr.count - 1) {
            
            for (int i = 0 ; i < _dataArr.count; i++) {
                
                if ([_dataArr[i] isEqualToString:@"0"]) {
                    _item++;
                    [_dataArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",(long)_item ]];
                }

            }
        }
        
    }else{
    
        NSInteger index = [_dataArr[indexPath.row] integerValue];

        for (int i = 0; i < _dataArr.count; i++) {

            if ([_dataArr[i] integerValue] > index) {
                
                [_dataArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",[_dataArr[i] integerValue]-1]];
                
            }
            
        }

        [_dataArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
        
        _item--;
        
    }
    [collectionView reloadData];
    
}

//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)editAction{

    BOOL isEdit = NO;
    
    NSMutableArray *editArr = [NSMutableArray array];

    
    for (NSString *str in _dataArr) {
    
        [editArr addObject:@""];
        
        if ([str integerValue] == _dataArr.count) {
            
            isEdit = YES;
            
        }
    }
    
    if (isEdit) {
        
        for (int i = 0; i < _dataArr.count; i++) {
            [editArr replaceObjectAtIndex:[_dataArr[i] integerValue] - 1 withObject:_imageURLArr[i]];
        }

        
        NSString *phoneStr = @"";
        
        for (NSString *str in editArr) {
            
            
            phoneStr = [NSString stringWithFormat:@"%@,%@",phoneStr,[str substringFromIndex:imgUrl.length + 1]];


            
        }

        if (phoneStr.length != 0) {
            phoneStr  = [phoneStr substringFromIndex:1];
        }
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];

        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:@"goods" forKey:@"category"];

        [params setObject:_share_id forKey:@"object_id"];
        
        [params setObject:phoneStr forKey:@"photo"];

        [DataSeviece requestUrl:sort_photohtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"editPhotoNotification" object:[editArr copy]];

            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        NSLog(@"%@ \n%@",_imageURLArr,editArr);

    }else{
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"还未选择完图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertV show];
        
    }

}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"图片顺序";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

@end
