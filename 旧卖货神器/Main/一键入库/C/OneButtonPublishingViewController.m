//
//  OneButtonPublishingViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "OneButtonPublishingViewController.h"
#import "OneButtonPublishingCell.h"
#import "ZLPhoto.h"
#import "AFNetworking.h"
#import "BrandChoiceViewController.h"
#import "SortConditionViewController.h"
#import "GradeConditionViewController.h"
#import "ReleaseCompleteViewController.h"
#import "AccountBindingViewController.h"
#import "ScanViewController.h"
#import "ExpectedDeliveryType ViewController.h"
#import "AccountListViewController.h"
#import "WDSortViewController.h"
#import "SelectTheAddressViewController.h"
#import "UpdatePlatform ViewController.h"
#import "PlatformAccountViewController.h"
#import "ProductParametersViewController.h"
#import "GemParametersViewController.h"
#import "CustomerViewController.h"

@interface OneButtonPublishingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZLPhotoPickerViewControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

    
    UIPickerView *_mPickerView;
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *allName;
    NSString *province_name;
    NSString *city_name;
    NSString *area_name;

    
    NSString *allCode;
    UIView *_adressV;
    NSArray *jsonDataArr;

    
    UIView *bgView;
    
    UIView *feedBackV;
    
    CGFloat angle1;
    CGFloat angle2;
    CGFloat angle3;
    CGFloat angle4;
    CGFloat angle5;
    CGFloat angle6;
    CGFloat angle7;
    CGFloat angle8;
    CGFloat angle9;
    CGFloat angle10;

    BOOL isPHRotate;
    BOOL isADMRotate;
    BOOL isWBRotate;
    BOOL isLPHRotate;
    BOOL isXSRotate;
    BOOL isSPRotate;
    BOOL isZDRotate;
    BOOL isADMZYRotate;
    BOOL isADMSJRotate;
    BOOL isJARotate;
    
    NSString *PHmsg;
    NSString *ADMmsg;
    NSString *WBmsg;
    NSString *LPHmsg;
    NSString *XSmsg;
    NSString *SPmsg;
    NSString *ZDmsg;
    NSString *ADMZYmsg;
    NSString *ADMSJmsg;
    NSString *JAmsg;


    NSDictionary *addressDic;

    UIView *JMHSView;
    
    BOOL isDL; //代理价格
    
    NSString *MaterialId;
    
    NSString *MaterialName;

}

//朋友圈是否自动粘贴

@property (nonatomic,assign) BOOL isPYQCopy;

//商品参数显示
@property (nonatomic,assign) BOOL isSPCS;

@property (weak, nonatomic) IBOutlet UIImageView *updownImageV;

//系列
@property (weak, nonatomic) IBOutlet UITextField *seriesTextField;
//型号
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
//材质
@property (weak, nonatomic) IBOutlet UITextField *materialTextField;
//功能
@property (weak, nonatomic) IBOutlet UITextField *functionTextField;
//编号
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
//附件
@property (weak, nonatomic) IBOutlet UITextField *attachmentTextField;

@property (weak, nonatomic) IBOutlet UITextView *SPMSTextView;

@property (weak, nonatomic) IBOutlet UICollectionView *OnePublishCollectionV;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *imageStrArr;

@property (nonatomic,copy) NSString *brandId;
@property (nonatomic,copy) NSString *sortId;
@property (nonatomic,copy) NSString *gradeId;
@property (nonatomic,copy) NSString *expectedId;
@property (nonatomic,copy) NSString *WDSortId;
@property (nonatomic,copy) NSString *addressId;


@property (nonatomic,strong) NSMutableArray *brandDataArr;

@property (nonatomic,strong) NSDictionary *sortDic;

//所有材质
@property (nonatomic,strong) NSArray *ALLMaterialArr;
//材质
@property (nonatomic,strong) NSArray *materialArr;
//所有功能
@property (nonatomic,strong) NSArray *ALLFunctionArr;
//功能
@property (nonatomic,strong) NSArray *functionArr;
//所有附件
@property (nonatomic,strong) NSArray *ALLAttachmentArr;
//附件
@property (nonatomic,strong) NSArray *attachmentArr;
//所有系列
@property (nonatomic,strong) NSArray *seriesArr;
//系列
@property (nonatomic,strong) NSDictionary *seriesDic;

@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,strong) NSMutableArray *collectArr;
//宝石参数
@property (nonatomic,strong) NSArray *gemArr1;
@property (nonatomic,strong) NSArray *gemArr2;
@property (nonatomic,strong) NSArray *gemArr3;
@property (nonatomic,strong) NSArray *gemArr4;
@property (nonatomic,strong) NSArray *gemArr5;
@property (nonatomic,strong) NSArray *gemArr6;
@property (nonatomic,strong) NSArray *gemArr7;
@property (nonatomic,strong) NSArray *gemArr8;

//客户
@property (nonatomic,strong) NSDictionary *CustomerDic;

@end

@implementation OneButtonPublishingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _XHButton.layer.borderWidth = .5;
    
    _XHButton.layer.borderColor = [RGBColor colorWithHexString:@"949DFF"].CGColor;
    
    isDL = NO;
    
    MaterialId = @"";
    
    MaterialName = @"";
    
    _collectArr = [NSMutableArray array];

    for (int i = 0; i < 9; i++) {
        
        [_collectArr addObject:@"0"];
        
    }
    
    _viewWidth.constant = 54 * _typeArr.count + 11;
    
    _titleTextField.delegate = self;
    
    province_name = @"北京市";
    
    city_name = @"北京市";
    
    area_name = @"东城区";
    
    _brandId = @"";
    _sortId = @"";
    _gradeId = @"";
    _expectedId = @"";
    _WDSortId = @"";
    _addressId = @"";
    _goods_id = @"";
    
    _brandDataArr = [NSMutableArray array];
    
    _imageArr = [NSMutableArray array];
    
    _imageStrArr = [NSMutableArray array];
    
    _describeTextView.delegate = self;
    
    _WBImageV.hidden = YES;
    
    _PHImageV.hidden = YES;
    
    _ADMImageV.hidden = YES;
    
    _LPHImageV.hidden = YES;
    
    _XSImageV.hidden = YES;
    
    _SPImageV.hidden = YES;

    _ZDImageV.hidden = YES;
    
    _ADMZYImageV.hidden = YES;
    
    _ADMSJImageV.hidden = YES;
    
    _JAImageV.hidden = YES;
    

    ADMmsg = @"";
    
    PHmsg = @"";
    
    WBmsg = @"";
    
    LPHmsg = @"";
    
    XSmsg = @"";
    
    SPmsg = @"";
    
    ZDmsg = @"";
    
    ADMZYmsg = @"";
    
    ADMSJmsg = @"";
    
    JAmsg = @"";
    
    
    for (int i = 0; i < 9; i++) {
        
        [_imageStrArr addObject:@""];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GradeConditionNotification:) name:@"GradeConditionNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BrandChoiceNotification:) name:@"BrandChoiceNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SortConditionNotification:) name:@"SortConditionNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RemoveImageNotification:) name:@"RemoveImageNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExpectedDeliveryTypeNotification:) name:@"ExpectedDeliveryTypeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WDSorNotification:) name:@"WDSorNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(POPNotificationAddress:) name:@"POPNotificationAddress" object:nil];
    //商品参数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProductParametersNotification:) name:@"ProductParametersNotification" object:nil];
     //材质
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MaterialNotification:) name:@"MaterialNotification" object:nil];
    //宝石参数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GemParametersNotication:) name:@"GemParametersNotication" object:nil];
    //客户CustomerNotication
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CustomerNotication:) name:@"CustomerNotication" object:nil];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [_OnePublishCollectionV registerNib:[UINib nibWithNibName:@"OneButtonPublishingCell" bundle:nil] forCellWithReuseIdentifier:@"OneButtonPublishingCell"];
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    //给self.view添加一个手势监测；
    [self.tableView addGestureRecognizer:singleRecognizer];
    
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
    
    JMHSView = [[UIView alloc]initWithFrame:CGRectMake(35, kScreenHeight/2 - 80, kScreenWidth - 70, 88)];
    
    JMHSView.hidden = YES;
    
    JMHSView.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:JMHSView];
    
    //    地区选择器
    
    _adressV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
    _adressV.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    _adressV.hidden = YES;
    
    [self.view addSubview:_adressV];
    
    _mPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 300)];
    _mPickerView.delegate = self;
    _mPickerView.dataSource = self;
    [_adressV addSubview:_mPickerView];
    UIButton *trueButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    trueButton1.frame = CGRectMake(kScreenWidth-50, 0, 40, 40);
    [trueButton1 addTarget:self action:@selector(trueAction1) forControlEvents:UIControlEventTouchUpInside];
    [trueButton1 setTitle:@"确定" forState:UIControlStateNormal];
    [_adressV addSubview:trueButton1];
    UIButton *cancelButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton1.frame = CGRectMake(10, 0, 40, 40);
    [cancelButton1 setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton1 addTarget:self action:@selector(cancelAction1) forControlEvents:UIControlEventTouchUpInside];
    [_adressV addSubview:cancelButton1];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    jsonDataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    provinceArr = jsonDataArr;
    
    cityArr = jsonDataArr[0][@"city"];
    
    districtArr = jsonDataArr[0][@"city"][0][@"area"];
    
    allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:0] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    
    [self loadData1];

    if (_isOnePush) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *dic = [defaults objectForKey:@"Text"];
        
        if (dic) {
            
            _recordDic = dic;
        }
        
    }
    
    if (_recordDic) {
        
        _titleTextField.text = _recordDic[@"goods_name"];
        _describeTextView.text = _recordDic[@"goods_description"];
        _priceTextField.text = _recordDic[@"price"];
        _publicPriceTextField.text = _recordDic[@"market_price"];
        _agentPriceTextField.text = _recordDic[@"agency_price"];
        
        [self showImage];
        
        if (_recordDic[@"brand_id"]) {
            
            _brandId = _recordDic[@"brand_id"];

        }
        
        if (_recordDic[@"category_id"]) {
            
            if ([_recordDic[@"category_id"] integerValue] != 0) {
                
                _sortId = _recordDic[@"category_id"];
                
                NSLog(@"%@ %@ %@",_recordDic[@"category_id"],_recordDic[@"pid"],_recordDic[@"category_name"]);
                
                if (_recordDic[@"pid"]) {
                    
                    _sortDic = @{@"category_id":_recordDic[@"category_id"],@"pid":_recordDic[@"pid"],@"category_name":_recordDic[@"category_name"]};

                }else{
                
                    _sortDic = @{@"category_id":_recordDic[@"category_id"],@"pid":_recordDic[@"category_pid"],@"category_name":_recordDic[@"category_name"]};
                    
                }
            }
        }
        if (_recordDic[@"expected_delivery_type"]) {
            
            _expectedId = _recordDic[@"expected_delivery_type"];
        }
        
        if (_recordDic[@"grade"]) {
            _gradeId = _recordDic[@"grade"];
        }
        
        if (_recordDic[@"cate_id"]) {
            
            _WDSortId = _recordDic[@"cate_id"];
        }
        
        if (_recordDic[@"returnAddressId"]) {
            
            _addressId = _recordDic[@"returnAddressId"];
        }
        
        if ([_sortDic[@"pid"] isEqualToString:@"30"]) {
            
            _sizeLabel.text = @"表径:";
        }
        
        if (_recordDic[@"size"]) {
            _bagsizeTextField.text = _recordDic[@"size"];
        }
        
        if (_recordDic[@"size_x"]) {
            _bagsizeTextField.text = _recordDic[@"size_x"];

        }
        if (_recordDic[@"size_y"]) {
            _size_yTextField.text = _recordDic[@"size_y"];
            
        }
        if (_recordDic[@"size_z"]) {
            _size_zTextField.text = _recordDic[@"size_z"];
        }
        
        if ([_recordDic[@"type"] isEqualToString:@"HS"]) {
            _JMButton.selected = NO;
            _HSButton.selected = YES;
        }else if ([_recordDic[@"type"] isEqualToString:@"JM"]){
            _JMButton.selected = YES;
            _HSButton.selected = NO;
        }
        
        if (_recordDic[@"brand_name"]) {
            
            _KWDZTextField2.text = _recordDic[@"brand_name"];
        }
        
        if (_recordDic[@"province_name"]) {
            province_name = _recordDic[@"province_name"];
        }
        
        if (_recordDic[@"city_name"]) {
            province_name = _recordDic[@"city_name"];
        }
        
        if (_recordDic[@"area_name"]) {
            province_name = _recordDic[@"area_name"];
        }
        
        if (_recordDic[@"province_name"]&&_recordDic[@"city_name"]&&_recordDic[@"area_name"]) {
            _KWDZTextField1.text = [NSString stringWithFormat:@"%@ %@ %@",_recordDic[@"province_name"],_recordDic[@"city_name"],_recordDic[@"area_name"]];
        }
        
        if (_recordDic[@"material_name"]) {
            
            _materialTextField.text = _recordDic[@"material_name"];
            
            MaterialName = _recordDic[@"material_name"];
            
            MaterialId = _recordDic[@"material"];

        }
        
        if (_recordDic[@"function_name"]) {
            
            NSArray *arr1 = [_recordDic[@"function"] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            
            NSArray *arr2 = [_recordDic[@"function_name"] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (int i = 0; i < arr1.count; i++) {
                
                [array addObject:@{@"name":arr2[i],@"id":arr1[i]}];

            }
            
            _functionTextField.text = _recordDic[@"function_name"];
            
            _functionArr  = [array copy];
            
        }

        if (_recordDic[@"series_name"]) {
            
            _seriesTextField.text = _recordDic[@"series_name"];

            _seriesDic = @{@"id":_recordDic[@"series_name"],@"name":_recordDic[@"series_name"]};
        }
        
        if (_recordDic[@"adjunct_name"]) {
            
            NSArray *arr1 = [_recordDic[@"adjunct"] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            
            NSArray *arr2 = [_recordDic[@"adjunct_name"] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (int i = 0; i < arr1.count; i++) {
                
                [array addObject:@{@"name":arr2[i],@"id":arr1[i]}];

            }
            
            _attachmentTextField.text = _recordDic[@"adjunct_name"];
            
            _attachmentArr  = [array copy];
        }

        if (_recordDic[@"model"]) {
            
            _modelTextField.text = _recordDic[@"model"];
        }

        if (_recordDic[@"goodssn"]) {
            _numberTextField.text = _recordDic[@"goodssn"];
        }
        if (_recordDic[@"weight"]) {
            _ZLTF.text = _recordDic[@"weight"];
        }
        
        if (_recordDic[@"signet"]) {
            _KYTF.text = _recordDic[@"signet"];
        }
        
        if (_recordDic[@"note"]) {
            _SPMSTextView.text = _recordDic[@"note"];
        }

        if (_recordDic[@"customer"]) {
            
            _KHTF.text = _recordDic[@"customer_name"];
            
            _CustomerDic = @{@"name":_recordDic[@"customer_name"],@"id":_recordDic[@"customer"]};
            
        }

        if (_recordDic[@"customer_price"]) {
            _KHDSJTF.text = _recordDic[@"customer_price"];
        }

        
        if (_recordDic[@"article_number"]) {
            _HHTF.text = _recordDic[@"article_number"];
        }
        
        if (_recordDic[@"gem"]) {
            _BSTF.text = _recordDic[@"gem_name"];
            
            _gemArr1 = @[@{@"name":_recordDic[@"gem_name"],@"id":_recordDic[@"gem"]}];
        }
        
        if (_recordDic[@"density"]) {
            _SNDTF.text = _recordDic[@"density_name"];
            
            _gemArr2 = @[@{@"name":_recordDic[@"density_name"],@"id":_recordDic[@"density"]}];
        }
        
        if (_recordDic[@"color"]) {
            
            _YSTF.text = _recordDic[@"color_name"];
            
            NSArray *idArr = [_recordDic[@"color"] componentsSeparatedByString:@","];
            
            NSArray *nameArr = [_recordDic[@"color_name"] componentsSeparatedByString:@","];

            NSMutableArray *arr = [NSMutableArray array];
            
            for (int i = 0; i < idArr.count; i++) {
                
                NSDictionary *dic = @{@"id":idArr[i],@"name":nameArr[i]};
                
                [arr addObject:dic];
            }
            
            _gemArr3 = [arr copy];
        }

        if (_recordDic[@"clarity"]) {
            _JDTF.text = _recordDic[@"clarity_name"];
            
            _gemArr4 = @[@{@"name":_recordDic[@"clarity_name"],@"id":_recordDic[@"clarity"]}];
        }
        
        if (_recordDic[@"cutter"]) {
            _QGTF.text = _recordDic[@"cutter_name"];
            
            _gemArr5 = @[@{@"name":_recordDic[@"cutter_name"],@"id":_recordDic[@"cutter"]}];
        }

        if (_recordDic[@"polishing"]) {
            _PGTF.text = _recordDic[@"polishing_name"];
            
            _gemArr6 = @[@{@"name":_recordDic[@"polishing_name"],@"id":_recordDic[@"polishing"]}];
        }

        if (_recordDic[@"symmetry"]) {
            _DCXTF.text = _recordDic[@"symmetry_name"];
            
            _gemArr7 = @[@{@"name":_recordDic[@"symmetry_name"],@"id":_recordDic[@"symmetry"]}];
        }

        if (_recordDic[@"fluorescence"]) {
            _YGXTF.text = _recordDic[@"fluorescence_name"];
            
            _gemArr8 = @[@{@"name":_recordDic[@"fluorescence_name"],@"id":_recordDic[@"fluorescence"]}];
        }
        
        if (_recordDic[@"cost_price"]) {
            
            _CBJTF.text = _recordDic[@"cost_price"];
        }
    }

    //详细信息
    [self detailedData];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (IBAction)HSJMButtonAction:(UIButton *)sender {
    
    if (!sender.selected) {
        
        if (sender == _HSButton) {
            
            _JMButton.selected = NO;
        }else{
        
            _HSButton.selected = NO;

        }
        sender.selected = !sender.selected;
        
        [self.tableView reloadData];
    }
    
}

- (void)trueAction1{
    
    _adressV.hidden = YES;
    _KWDZTextField1.text = allName;
    
    
}

- (void)cancelAction1{
    
    _adressV.hidden = YES;
}
#pragma mark - UIPickerViewDataSource||UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger row = 0;
    switch (component)
    {
        case 0:
            row = [provinceArr count];
            break;
        case 1:
            row = [cityArr count];
            break;
        case 2:
            row = [districtArr count];
            break;
        default:
            break;
    }
    return row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    id item;
    switch (component)
    {
        case 0:
            item = [provinceArr objectAtIndex:row];
            provinceIndex = row;
            break;
        case 1:
            item = [cityArr objectAtIndex:row];
            cityIndex = row;
            break;
        case 2:
            item = [districtArr objectAtIndex:row];
            districtIndex = row;
            break;
        default:
            break;
    }
    if (item)
    {
        title = [item objectForKey:@"name"];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component)
    {

        cityArr = jsonDataArr[row][@"city"];
        
        districtArr = jsonDataArr[row][@"city"][0][@"area"];

        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        provinceIndex = row;
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:row] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
        
        area_name = [[districtArr objectAtIndex:0] objectForKey:@"name"];
        
        city_name = [[cityArr objectAtIndex:0] objectForKey:@"name"];
        
        province_name = [[provinceArr objectAtIndex:row] objectForKey:@"name"];
        
    }
    
    if (1 == component)
    {
        cityIndex = row;
        
        cityArr = jsonDataArr[provinceIndex][@"city"];
        districtArr = jsonDataArr[provinceIndex][@"city"][row][@"area"];
        
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:row] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
        
        area_name = [[districtArr objectAtIndex:0] objectForKey:@"name"];
        
        city_name = [[cityArr objectAtIndex:row] objectForKey:@"name"];
        
        province_name = [[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"];
        

    }
    
    if (2 == component) {
        
        districtIndex = row;
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:cityIndex] objectForKey:@"name"], [[districtArr objectAtIndex:row] objectForKey:@"name"]];
        
        area_name = [[districtArr objectAtIndex:row] objectForKey:@"name"];
        
        city_name = [[cityArr objectAtIndex:cityIndex] objectForKey:@"name"];
        
        province_name = [[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"];
        
    }
    
    NSLog(@"%@", allName);
}


- (void)bgButtonAction{

    bgView.hidden = YES;

    JMHSView.hidden = YES;

}

//隐藏键盘
- (void)singleAction{
    
    [_brandTextField resignFirstResponder];
    [_gradeTextField resignFirstResponder];
    [_sortTextField resignFirstResponder];
    [_titleTextField resignFirstResponder];
    [_publicPriceTextField resignFirstResponder];
    [_priceTextField resignFirstResponder];
    [_describeTextView resignFirstResponder];
    [_bagsizeTextField resignFirstResponder];
    [_size_yTextField resignFirstResponder];
    [_size_zTextField resignFirstResponder];
    [_KWDZTextField2 resignFirstResponder];
    [_numberTextField resignFirstResponder];
    [_modelTextField resignFirstResponder];
    [_SPMSTextView resignFirstResponder];
    [_agentPriceTextField resignFirstResponder];
    [_ZLTF resignFirstResponder];
    [_KYTF resignFirstResponder];
    [_KHTF resignFirstResponder];
    [_HHTF resignFirstResponder];
    [_CBJTF resignFirstResponder];

}

//复制平台检测
- (void)loadData1{
    
//    NSLog(@"%@ %@", _typeArr,_selectTypeArr);
    
    _PHLabel.hidden = YES;
    _PHLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _PHButton.selected = NO;
    _PHButton.hidden = YES;
    _PHImageV.hidden = YES;
    
    _ADMLabel.hidden = YES;
    _ADMLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _ADMButton.selected = NO;
    _ADMButton.hidden = YES;
    _ADMImageV.hidden = YES;

    _WBLabel.hidden = YES;
    _WBLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _WBButton.selected = NO;
    _WBButton.hidden = YES;
    _WBImageV.hidden = YES;
    
    _LPHLabel.hidden = YES;
    _LPHLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _LPHButton.selected = NO;
    _LPHButton.hidden = YES;
    _LPHImageV.hidden = YES;
    
    _XSLabel.hidden = YES;
    _XSLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _XSButton.selected = NO;
    _XSButton.hidden = YES;
    _XSImageV.hidden = YES;
    
    _SPLabel.hidden = YES;
    _SPLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _SPButton.selected = NO;
    _SPButton.hidden = YES;
    _SPImageV.hidden = YES;
    
    _ZDLabel.hidden = YES;
    _ZDLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _ZDButton.selected = NO;
    _ZDButton.hidden = YES;
    _ZDImageV.hidden = YES;
    
    _ADMZYLabel.hidden = YES;
    _ADMZYLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _ADMZYButton.selected = NO;
    _ADMZYButton.hidden = YES;
    _ADMZYImageV.hidden = YES;
    
    _ADMSJLabel.hidden = YES;
    _ADMSJLabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _ADMSJButton.selected = NO;
    _ADMSJButton.hidden = YES;
    _ADMSJImageV.hidden = YES;
    
    _JALabel.hidden = YES;
    _JALabel.textColor = [RGBColor colorWithHexString:@"999999"];
    _JAButton.selected = NO;
    _JAButton.hidden = YES;
    _JAImageV.hidden = YES;
    
    
    
    
    for(NSString *str in _typeArr) {
        
        if ([str isEqualToString:@"ponhu"]) {
            
            _PHButton.hidden = NO;
            _PHButton.selected = NO;
            _PHLabel.hidden = NO;
            
        }else if ([str isEqualToString:@"aidingmao"]){
        
            _ADMButton.hidden = NO;
            _ADMButton.selected = NO;
            _ADMLabel.hidden = NO;
            

        }else if ([str isEqualToString:@"vdian"]){
            
            _WBButton.hidden = NO;
            _WBButton.selected = NO;
            _WBLabel.hidden = NO;
            
            
        }else if ([str isEqualToString:@"liequ"]){
            
            _LPHButton.hidden = NO;
            _LPHButton.selected = NO;
            _LPHLabel.hidden = NO;
            
        }else if ([str isEqualToString:@"newshang"]){
            
            _XSButton.hidden = NO;
            _XSButton.selected = NO;
            _XSLabel.hidden = NO;
            
        }else if ([str isEqualToString:@"shopuu"]){
            
            _SPButton.hidden = NO;
            _SPButton.selected = NO;
            _SPLabel.hidden = NO;
            
        }else if ([str isEqualToString:@"xiaohongshu"]){
            
            _ZDButton.hidden = NO;
            _ZDButton.selected = NO;
            _ZDLabel.hidden = NO;
            
            
        }else if ([str isEqualToString:@"aidingmaopro"]){
            
            _ADMZYButton.hidden = NO;
            _ADMZYButton.selected = NO;
            _ADMZYLabel.hidden = NO;
            
        }else if ([str isEqualToString:@"aidingmaomer"]){
            _ADMSJButton.hidden = NO;
            _ADMSJButton.selected = NO;
            _ADMSJLabel.hidden = NO;
            
        }else if ([str isEqualToString:@"jiuai"]){
            _JAButton.hidden = NO;
            _JAButton.selected = NO;
            _JALabel.hidden = NO;
            
        }
    }
    
    
    for(NSString *str in _selectTypeArr) {
        
        if ([str isEqualToString:@"ponhu"]) {
            
            _PHImageV.hidden = NO;
            _PHButton.hidden = NO;
            _PHButton.selected = YES;
            _PHLabel.hidden = NO;
            _PHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            
        }else if ([str isEqualToString:@"aidingmao"]){
            
            _ADMImageV.hidden = NO;
            _ADMButton.hidden = NO;
            _ADMButton.selected = YES;
            _ADMLabel.hidden = NO;
            _ADMLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

            
        }else if ([str isEqualToString:@"vdian"]){
            
            _WBImageV.hidden = NO;
            _WBButton.hidden = NO;
            _WBButton.selected = YES;
            _WBLabel.hidden = NO;
            _WBLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

            
        }else if ([str isEqualToString:@"liequ"]){
            
            _LPHImageV.hidden = NO;
            _LPHButton.hidden = NO;
            _LPHButton.selected = YES;
            _LPHLabel.hidden = NO;
            _LPHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

        }else if ([str isEqualToString:@"newshang"]){
            
            _XSImageV.hidden = NO;
            _XSButton.hidden = NO;
            _XSButton.selected = YES;
            _XSLabel.hidden = NO;
            _XSLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

            
        }else if ([str isEqualToString:@"shopuu"]){
            
            _SPImageV.hidden = NO;
            _SPButton.hidden = NO;
            _SPButton.selected = YES;
            _SPLabel.hidden = NO;
            _SPLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

            
        }else if ([str isEqualToString:@"xiaohongshu"]){
            
            _ZDImageV.hidden = NO;
            _ZDButton.hidden = NO;
            _ZDButton.selected = YES;
            _ZDLabel.hidden = NO;
            _ZDLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

            
        }else if ([str isEqualToString:@"aidingmaopro"]){
            
            _ADMZYImageV.hidden = NO;
            _ADMZYButton.hidden = NO;
            _ADMZYButton.selected = YES;
            _ADMZYLabel.hidden = NO;
            _ADMZYLabel.textColor = [RGBColor colorWithHexString:@"#666666"];

        }else if ([str isEqualToString:@"aidingmaomer"]){
            _ADMSJImageV.hidden = NO;
            _ADMSJButton.hidden = NO;
            _ADMSJButton.selected = YES;
            _ADMSJLabel.hidden = NO;
            _ADMSJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            
        }else if ([str isEqualToString:@"jiuai"]){
            _JAImageV.hidden = NO;
            _JAButton.hidden = NO;
            _JAButton.selected = YES;
            _JALabel.hidden = NO;
            _JALabel.textColor = [RGBColor colorWithHexString:@"#666666"];
            
        }
        
    }

    
    
    if (_PHButton.hidden) {
        _ADMBLeft.constant = - 34;
    }else{
        _ADMBLeft.constant = 20;
    }
    
    if (_ADMButton.hidden) {
        _WDBLeft.constant =  - 34;
    }else{
        _WDBLeft.constant = 20;
    }
    
    if (_WBButton.hidden) {
        _LPHBLeft.constant =  - 34;
    }else{
        _LPHBLeft.constant = 20;
    }
    
    if (_LPHButton.hidden) {
        _XSBLeft.constant =  - 34;
    }else{
        _XSBLeft.constant = 20;
    }
    
    if (_XSButton.hidden) {
        _SPBLeft.constant =  - 34;
    }else{
        _SPBLeft.constant = 20;
    }
    
    if (_SPButton.hidden) {
        _ZDBLeft.constant =  - 34;
    }else{
        _ZDBLeft.constant = 20;
    }
    
    if (_ZDButton.hidden) {
        _ADMZYBLeft.constant =  - 34;
    }else{
        _ADMZYBLeft.constant = 20;
    }
    
    if (_ADMZYButton.hidden) {
        _ADMSJBLeft.constant =  - 34;
    }else{
        _ADMSJBLeft.constant = 20;
    }
    
    if (_ADMSJButton.hidden) {
        _JABLeft.constant =  - 34;
    }else{
        _JABLeft.constant = 20;
    }
    
    if (_JAButton.hidden) {
        _KKHBLeft.constant =  - 34;
    }else{
        _KKHBLeft.constant = 20;
    }
    

    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;

        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat contentOffsetY = scrollView.contentOffset.y;

    _adressV.transform = CGAffineTransformMakeTranslation(0, contentOffsetY);

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    OneButtonPublishingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneButtonPublishingCell" forIndexPath:indexPath];
    
    if (indexPath.item == 0) {
        cell.JBImageV.hidden = YES;
        cell.FMLabel.hidden = YES;
        cell.JBLabel.hidden = YES;
    }else {
        
        cell.JBImageV.hidden = NO;
        cell.JBLabel.hidden = NO;
        cell.JBLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
        
    }
    
    if (indexPath.item == 1) {
        
        cell.FMLabel.hidden = NO;
    }else{
        cell.FMLabel.hidden = YES;

    }
    
    if (indexPath.item == 0) {
        
        cell.imageV.image = [UIImage imageNamed:@"addphoto@2x.png"];
   
        cell.imageV.backgroundColor = [UIColor whiteColor];
        
        cell.progressV.hidden = YES;

    }else{
        
        if (_imageArr.count >=  indexPath.item) {
            
//            NSLog(@"%@",_imageArr[indexPath.item-1]);
            
            cell.imageV.backgroundColor = [UIColor whiteColor];
            
            cell.imageV.image = _imageArr[indexPath.item -1];
            
            cell.progressV.hidden = NO;

            cell.progressV.progress = [_collectArr[indexPath.item - 1] floatValue];
            

        }else{
            
            cell.imageV.backgroundColor = [RGBColor colorWithHexString:@"#d8d8d8"];
            
            cell.imageV.image = nil;
            
            cell.progressV.hidden = YES;
        }
    }
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item == 0) {
        
        // 创建控制器
        ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
        // 默认显示相册里面的内容SavePhotos
        // 最多能选9张图片
        pickerVc.isShowCamera = YES;
        pickerVc.topShowPhotoPicker = YES;
        pickerVc.status = PickerViewShowStatusCameraRoll;
        pickerVc.delegate = self;
        pickerVc.maxCount = 9 - _imageArr.count;
        [pickerVc showPickerVc:self];
        /**
         *
         传值可以用代理，或者用block来接收，以下是block的传值
         __weak typeof(self) weakSelf = self;
         pickerVc.callBack = ^(NSArray *assets){
         weakSelf.assets = assets;
         [weakSelf.tableView reloadData];
         };
         */
    
    }else{
        
        NSMutableArray *urlArr = [NSMutableArray array];
        
        for (NSString *str in _imageStrArr) {
            if (![str isEqualToString:@""]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
                
                NSString *imgUrl_API = serviceData[@"imgUrl_API"];
                
                

                [urlArr addObject:[NSString stringWithFormat:@"%@/%@",imgUrl_API,str]];
            }
        }
        
        if (![_imageStrArr[indexPath.item - 1] isEqualToString:@""]) {
            
            NSLog(@"%@",urlArr);
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
            ScanViewController *scanVC = [[ScanViewController alloc]init];
            scanVC.imageURLArr = urlArr;
            scanVC.currentIndexPath = path;
            scanVC.isDelegate = YES;
            [self.navigationController pushViewController:scanVC animated:YES];
            
        }
    }
    
}



#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    
    if (_imageArr.count + assets.count > 9) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertV.message = @"图片不能超过九张";
        
        [alertV show];
        
        return;
    }
    
    NSMutableArray *imageArr1 = [NSMutableArray array];
    
    NSMutableArray *itemArr = [NSMutableArray array];
    
    NSInteger item = _imageArr.count;
    
    __block NSInteger index = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    
    [DataSeviece requestUrl:get_qiniu_tokenhtml params:params1 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        for (NSInteger i = 0; i < assets.count ; i++) {
            
            if ([assets[i] isKindOfClass:[ZLPhotoAssets class]]) {
                
                ZLPhotoAssets *asset = assets[i];
                
                [_imageArr addObject:asset.originImage];
                
                [imageArr1 addObject:asset.originImage];
                
            }else{
                
                [_imageArr addObject:[self rotateImage:assets[i]]];
                
                [imageArr1 addObject:[self rotateImage:assets[i]]];
                
                NSLog(@"%@",assets[i]);
            }
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:result[@"result"][@"data"][@"qiniu_token"] forKey:@"token"];
            
            [params setObject:SYGData[@"shop_id"] forKey:@"x:shop_id"];
            
            
            AFHTTPRequestOperationManager* _manager = [AFHTTPRequestOperationManager manager];
            
            NSMutableURLRequest* request = [_manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:@"http://up-z2.qiniu.com" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *imgData = UIImageJPEGRepresentation(imageArr1[i], 1);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } error:nil];

            
            AFHTTPRequestOperation *operation = [_manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                NSLog(@"%@ %@",responseObject,responseObject[@"result"][@"msg"]);
                
                index ++;
                
                [_imageStrArr replaceObjectAtIndex:index + item - 1 withObject:responseObject[@"result"][@"data"][@"file_name"]];
                
                NSLog(@"%@",_imageStrArr);
                
                if (index == assets.count && itemArr.count != 0) {
                    
                    [self removeErrorImage:[itemArr copy]];
                    
                }
                
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);

                index ++;
                
                [itemArr addObject:[NSNumber numberWithInteger:item + i - 1]];
                
                if (index == assets.count && itemArr.count != 0) {
                    
                    [self removeErrorImage:[itemArr copy]];
                }
                
            }];
            
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                
                [_collectArr replaceObjectAtIndex:i+item withObject:[NSString stringWithFormat:@"%.0lf",(float)totalBytesWritten/totalBytesExpectedToWrite]];
                
                NSLog(@"%lf",(float)totalBytesWritten/totalBytesExpectedToWrite);
                
                [_OnePublishCollectionV reloadData];
                
            }];
            
            [operation start];
            
        }
        
        [_OnePublishCollectionV reloadData];

        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
    
    
    
    
}

//删除请求失败的图片
- (void)removeErrorImage:(NSArray*)itemArr{
    

    
    NSMutableArray *removeArr = [NSMutableArray array];
    
    for (NSNumber *item in itemArr) {
        
        [removeArr addObject:_imageArr[[item intValue]]];
        
    }
    
    NSLog(@"%@ %@",_imageArr,removeArr);

    
    for (UIImage *image in removeArr) {

        [_imageArr removeObject:image];
        
    }
    
    NSLog(@"%@",_imageArr);
    
    for(int i = 0; i < 9; i++) {
        
        if (_imageArr.count > i) {
            
            [_collectArr addObject:@"1"];
            
        }else{
        
            [_collectArr addObject:@"0"];
        }
        
    }
    
    [_OnePublishCollectionV reloadData];
    
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


//成色通知
- (void)GradeConditionNotification:(NSNotification*)noti{

    
    _gradeTextField.text = [noti object][@"title"];
    
    _gradeId = [noti object][@"id"];
    
    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
    }
    
}
//发货时间选择通知
- (void)ExpectedDeliveryTypeNotification:(NSNotification*)noti{
    
    _expectedTextField.text = [noti object][@"title"];
    
    _expectedId = [noti object][@"id"];

}

//类别通知
- (void)SortConditionNotification:(NSNotification*)noti{
    
    if (![_sortId isEqualToString:[noti object][@"id"]]) {
        
        _ALLAttachmentArr = nil;
        _materialArr = nil;
        _ALLFunctionArr = nil;
        _functionArr = nil;
        _ALLAttachmentArr = nil;
        _attachmentArr = nil;
        _attachmentTextField.text = @"";
        _functionTextField.text = @"";
        _attachmentTextField.text = @"";
        _brandId = @"";
        _brandTextField.text = @"";
        
        _bagsizeTextField.text = @"";
        _size_yTextField.text = @"";
        _size_zTextField.text = @"";
        
        _gemArr1 = nil;
        _gemArr2 = nil;
        _gemArr3 = nil;
        _gemArr4 = nil;
        _gemArr5 = nil;
        _gemArr6 = nil;
        _gemArr7 = nil;
        _gemArr8 = nil;
        
        _BSTF.text = @"";
        
        _SNDTF.text = @"";

        _YSTF.text = @"";

        _YGXTF.text = @"";

        _DCXTF.text = @"";

        _QGTF.text = @"";

        _PGTF.text = @"";
        
        _JDTF.text = @"";
        
        _seriesTextField.text = @"";
        
        _seriesArr = nil;
        
        _seriesDic = nil;
        
        _modelTextField.text = @"";
        
        _materialTextField.text = @"";
        
        _functionTextField.text = @"";
        
        _numberTextField.text = @"";
        
        _attachmentTextField.text = @"";
        
        _gradeId = @"1";
        
        _gradeTextField.text = @"全新(未使用)";
        
        if (!_isPYQCopy) {
            
            _describeTextView.text = @"";
        }
        
    }
    
    _sortId = [noti object][@"id"];

    _sortTextField.text = [noti object][@"category_name"];
    
    _sortDic = [noti object];

    
    if ([_sortDic[@"pid"] isEqualToString:@"30"]) {
        
        _sizeLabel.text = @"表径:";
        
    }else{
        
        _sizeLabel.text = @"尺寸:";
    }
    
    [self SPCSAction];
    
    
    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
    }

    [self.tableView reloadData];

}

- (void)SPCSAction{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_sortId forKey:@"category_id"];
    
    NSString *url = @"";
    
    for (int i = 0; i < 3; i++) {
        
        if (i == 0) {
            
            url = get_materialhtml;
        }else if (i == 1){
            
            url = get_functionhtml;
            
        }else if (i == 2){
            
            url = get_adjuncthtml;
        }
        
        [DataSeviece requestUrl:url params:params success:^(id result) {
            
//            NSLog(@"%@",result);
            
            NSArray *array = result[@"result"][@"data"][@"item"];
            
            if (array != 0) {
                
                if (i == 0) {
                    _ALLMaterialArr = array;
                }else if (i == 1){
                    _ALLFunctionArr = array;
                }else if (i == 2){
                    _ALLAttachmentArr = array;
                }
            }
            
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }

}

//微店类别通知
- (void)WDSorNotification:(NSNotification*)noti{
    
    NSArray *selectArr = [noti object];
    
    NSString *nameSte = @"";
    
    NSString *idStr = @"";
    
    for (NSDictionary *dic in selectArr) {
        
        nameSte = [NSString stringWithFormat:@"%@,%@",nameSte,dic[@"cate_name"]];
        
        idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"cate_id"]];

    }
    
    
    if (selectArr.count != 0) {
        nameSte =  [nameSte substringFromIndex:1];
        idStr = [idStr substringFromIndex:1];
    }
    
    _WDSortId = idStr;
    
    NSLog(@"%@",_WDSortId);
    
    _WDSordTextField.text = nameSte;
    
}


//品牌通知
- (void)BrandChoiceNotification:(NSNotification*)noti{
    
    
    if (![_brandId isEqualToString:[noti object][@"id"]]) {

        _seriesArr = nil;
        _seriesDic = nil;
        _seriesTextField.text = nil;
    }
        
    
    _brandId = [noti object][@"id"];
    _brandTextField.text = [noti object][@"brands_name"];
    
    _seriesArr = [noti object][@"series"];


    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
    }

    
    [self.tableView reloadData];
}


- (void)POPNotificationAddress:(NSNotification*)noti{

    addressDic = [noti object];

    _addressTextField.text = addressDic[@"city"];
    
}

//商品参数
- (void)ProductParametersNotification:(NSNotification*)noti{

    NSDictionary *dic = [noti object];

    if ([[[dic allKeys] lastObject] isEqualToString:@"1"]) {
        
        if (dic[@"1"]) {
            _materialArr = dic[@"1"];
        }
        
        NSString *nameStr = @"";

        for (NSDictionary *dic in _materialArr) {
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
        }
        
        if (_materialArr.count != 0) {
            nameStr =  [nameStr substringFromIndex:1];
        }

        _materialTextField.text = nameStr;
        
        
    }else if ([[[dic allKeys] lastObject] isEqualToString:@"2"]) {
        _functionArr = dic[@"2"];
        
        NSString *nameStr = @"";
        
        for (NSDictionary *dic in _functionArr) {
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
        }
        
        if (_functionArr.count != 0) {
            nameStr =  [nameStr substringFromIndex:1];
        }
        
        _functionTextField.text = nameStr;

    }else if ([[[dic allKeys] lastObject] isEqualToString:@"3"]) {
        
        _attachmentArr = dic[@"3"];
        
        NSString *nameStr = @"";
        
        for (NSDictionary *dic in _attachmentArr) {
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
        }
        
        if (_attachmentArr.count != 0) {
            nameStr =  [nameStr substringFromIndex:1];
        }
        
        _attachmentTextField.text = nameStr;        
    }else if ([[[dic allKeys] lastObject] isEqualToString:@"4"]) {
        
        _seriesDic = dic[@"4"];
        
        
        _seriesTextField.text = _seriesDic[@"name"];
        
        NSLog(@"%@",_seriesDic);
        
    }
    

    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
        
    }

    
}

//材质通知
- (void)MaterialNotification:(NSNotification*)noti{

    MaterialId = [noti object][@"id"];
    
    MaterialName = [noti object][@"name"];
    
    _materialTextField.text = MaterialName;
    
    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
    }

    
}
//宝石参数
- (void)GemParametersNotication:(NSNotification*)noti{

    NSDictionary *dic = [noti object];
    
    if ([dic[@"type"] integerValue] == 1) {
        
        _gemArr1 = dic[@"select"];
        
        if (_gemArr1.count > 0) {
            
            _BSTF.text = _gemArr1[0][@"name"];
            
            _SNDTF.text = @"";
            
            _YSTF.text = @"";
            
            _YGXTF.text = @"";
            
            _DCXTF.text = @"";
            
            _QGTF.text = @"";
            
            _PGTF.text = @"";
            
            _JDTF.text = @"";
            
        }
        
    }else if ([dic[@"type"] integerValue] == 2){
    
        _gemArr2 = dic[@"select"];
        
        if (_gemArr2.count > 0) {
            
            _SNDTF.text = _gemArr2[0][@"name"];
        }

    }else if ([dic[@"type"] integerValue] == 3){
        
        _gemArr3 = dic[@"select"];
        
        if (_gemArr3.count > 0) {
            
            NSString *nameStr = @"";
            
            for (NSDictionary *dic in _gemArr3) {
                
                nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
            }

            nameStr = [nameStr substringFromIndex:1];
            
            _YSTF.text = nameStr;

        }

    }else if ([dic[@"type"] integerValue] == 4){
        
        _gemArr4 = dic[@"select"];
        
        if (_gemArr4.count > 0) {
            
            _JDTF.text = _gemArr4[0][@"name"];
        }


    }else if ([dic[@"type"] integerValue] == 5){
        
        _gemArr5 = dic[@"select"];
        
        if (_gemArr5.count > 0) {
            
            _QGTF.text = _gemArr5[0][@"name"];
        }


    }else if ([dic[@"type"] integerValue] == 6){
        
        _gemArr6 = dic[@"select"];
        
        if (_gemArr6.count > 0) {
            
            _PGTF.text = _gemArr6[0][@"name"];
        }


    }else if ([dic[@"type"] integerValue] == 7){
        
        _gemArr7 = dic[@"select"];
        
        if (_gemArr7.count > 0) {
            
            _DCXTF.text = _gemArr7[0][@"name"];
        }

    }else if ([dic[@"type"] integerValue] == 8){
        _gemArr8 = dic[@"select"];

        if (_gemArr8.count > 0) {
            
            _YGXTF.text = _gemArr8[0][@"name"];
        }
        
    }

//    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    
    
    NSLog(@"%@",friendText);
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
        
    }


    [self.tableView reloadData];
    
}

//客户
- (void)CustomerNotication:(NSNotification*)noti{

    _CustomerDic = [noti object];
    
    _KHTF.text = _CustomerDic[@"name"];

}

//确定按钮
- (IBAction)tureAction:(id)sender {
    
    
    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    if (!_isPYQCopy) {
        
        _describeTextView.text = friendText;
        
    }
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([_sortId isEqualToString:@""]) {
        
        alertV.message = @"分类不能为空";
        
        [alertV show];
        
        return;
    }

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSMutableArray *selectTypeArr = [NSMutableArray array];
    
    if (_PHButton.selected == YES) {
        
        [selectTypeArr addObject:@"ponhu"];
    }
    if (_ADMButton.selected == YES) {
        
        [selectTypeArr addObject:@"aidingmao"];
    }
    if (_WBButton.selected == YES) {
        
        [selectTypeArr addObject:@"vdian"];
    }
    if (_LPHButton.selected == YES) {
        
        [selectTypeArr addObject:@"liequ"];
    }
    if (_XSButton.selected == YES) {
        
        [selectTypeArr addObject:@"newshang"];
    }
    if (_SPButton.selected == YES) {
        
        [selectTypeArr addObject:@"shopuu"];
    }
    if (_ZDButton.selected == YES) {
        
        [selectTypeArr addObject:@"xiaohongshu"];
    }
    if (_ADMZYButton.selected == YES) {
        
        [selectTypeArr addObject:@"aidingmaopro"];
    }
    if (_ADMSJButton.selected == YES) {
        
        [selectTypeArr addObject:@"aidingmaomer"];
    }
    if (_JAButton.selected == YES) {
        
        [selectTypeArr addObject:@"jiuai"];
    }
    
    __block NSInteger item = 0;
    
    __block BOOL isType = YES;
    
    
    for (int i = 0; i < selectTypeArr.count; i++) {
        
        [params setObject:selectTypeArr[i] forKey:@"type"];
        
        [DataSeviece requestUrl:Shareget_share_accounthtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            item++;
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                BOOL isDefault = NO;
                
                for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
                    
                    if ([dic[@"is_default"] isEqualToString:@"1"]) {
                        
                        isDefault = YES;
                    }
                }
                
                if (!isDefault) {
                    
                    isType = NO;
                }
                
                if (item == selectTypeArr.count) {
                    
                    if (isType) {
                        
                        [self pushTureType];
                        
                    }else{
                        [self pushAccount];
                    }
                    
                }
                
            }else{
                
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
    
    if (selectTypeArr.count == 0) {
        
        [self pushTureType];

    }
    
}

//上传平台
- (void)pushTureType{
    

    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 9; i++) {
        
        if (![_imageStrArr[i] isEqualToString:@""]) {
            
            [dic setObject:_imageStrArr[i] forKey:[NSString stringWithFormat:@"%d",i]];
            
        }
    }
    
    if (dic.count < _imageArr.count) {
        
        alertV.message = @"图片还未上传成功,请稍后";
        [alertV show];
        return;
        
    }
    
    if ([_titleTextField.text isEqualToString:@""]) {
        
        if (_LPHImageV.hidden&&_XSImageV.hidden&&_ZDImageV.hidden) {
            
        }else{
            
            alertV.message = @"商品标题不能为空";
            [alertV show];
            return;
            
        }
    }
    
    if (_titleTextField.text.length > 40 && (!_XSImageV.hidden||!_LPHImageV.hidden)) {
        
        alertV.message = @"商品标题不能超过40";
        [alertV show];
        return;

    }
    
    if (_titleTextField.text.length > 30) {
        
        if (_JAImageV.hidden) {
            
        }else{
        
            alertV.message = @"商品标题不能超过30";
            [alertV show];
            return;

        }
    }
    
    
    if (_describeTextView.text.length < 20||_describeTextView.text.length > 190) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_PHImageV.hidden&&_WBImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_ADMSJImageV.hidden&&_ZDImageV.hidden&&_JAImageV.hidden) {
            
            
        }else{
            
            alertV.message = @"朋友圈字数不能小于20或者不能大于190";
            [alertV show];
            return;
        }
    }
    
    if ([_brandTextField.text isEqualToString:@""]) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden) {
            
        }else{
            
            alertV.message = @"品牌不能为空";
            [alertV show];
            return;
        }
        
    }
    
    if ([_sortTextField.text isEqualToString:@""]) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden) {
            
        }else{
            alertV.message = @"类别不能为空";
            [alertV show];
            return;
        }
    }
    
    if ([_expectedTextField.text isEqualToString:@""]) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden) {
            
        }else{
            alertV.message = @"发货时间不能为空";
            [alertV show];
            return;
        }
    }
    
    if ([_gradeTextField.text isEqualToString:@""]) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden) {
            
        }else{
            alertV.message = @"成色不能为空";
            [alertV show];
            return;
        }
    }
    
    if ([_priceTextField.text integerValue] < 301) {
        
        if (_XSImageV.hidden) {
            
        }else{
            
            alertV.message = @"售价不能小于300";
            [alertV show];
            return;
            
        }
    }
    
    if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_WBImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden) {
        
    }else{
        
        if ([_priceTextField.text integerValue] == 0) {
            alertV.message = @"售价不能为零";
            [alertV show];
            return;
        }
        
    }
    
    
    if ([_publicPriceTextField.text isEqualToString:@""]) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden) {
            
        }else{
            alertV.message = @"公价不能为空";
            [alertV show];
            return;
            
        }
    }
    
    if ([_priceTextField.text integerValue] > [_publicPriceTextField.text integerValue]) {
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden) {
            
        }else{
            
            alertV.message = @"售价不能大于公价";
            [alertV show];
            return;
        }
    }
    
    
    if (dic.count < 4 && (_PHImageV.hidden == NO||_XSImageV.hidden == NO)) {
        
        alertV.message = @"图片不能小于4张";
        [alertV show];
        return;
    }
    
    if (dic.count < 1) {
        
        alertV.message = @"图片不能为空";
        [alertV show];
        return;
        
    }
    
    if ([_KWDZTextField1.text isEqualToString:@""]&&(_JAImageV.hidden == NO||_LPHImageV.hidden == NO)) {
        alertV.message = @"货物地址不能为空";
        [alertV show];
        return;
        
    }

    

    if (isDL) {
        
        [params setObject:_agentPriceTextField.text forKey:@"agency_price"];

    }
    
    [params setObject:_titleTextField.text forKey:@"goods_name"];
    
    [params setObject:_brandId forKey:@"brand_id"];
    
    [params setObject:_sortId forKey:@"category_id"];
    
    if (![_expectedId isEqualToString:@""]) {
        
        [params setObject:_expectedId forKey:@"expected_delivery_type"];

    }
    
    [params setObject:@"1" forKey:@"fit_people"];
    
    if ([_describeTextView.text isEqualToString:@""]) {
        
        NSString *textStr = [self creatFriendText];
        
        [params setObject:textStr forKey:@"goods_description"];

    }else{
    
        [params setObject:_describeTextView.text forKey:@"goods_description"];
    
    }

    
    [params setObject:_gradeId forKey:@"grade"];
    
    [params setObject:_priceTextField.text forKey:@"price"];
    
    [params setObject:_publicPriceTextField.text forKey:@"market_price"];
    
    
    NSMutableArray *imgArr = [NSMutableArray array];
    
    for (NSString *str in _imageStrArr) {
        
        if (![str isEqualToString:@""]) {
            [imgArr addObject:str];
        }
        
    }
    
    
    [params setObject:imgArr forKey:@"img"];
    
    
    
    if (_isCopy) {
        
        [params setObject:_recordDic[@"id"] forKey:@"goods_id"];
    }
    
    if (_HSButton.selected) {
        
        [params setObject:@"HS" forKey:@"type"];

    }else{
        
        [params setObject:@"JM" forKey:@"type"];
        
    }

    
    NSLog(@"%@",_sortDic[@"pid"]);
    
    if ([_sortDic[@"pid"] isEqualToString:@"1"]) {
        
        
        if (_PHImageV.hidden == NO||_XSImageV.hidden == NO) {
            
            if ([_bagsizeTextField.text isEqualToString:@""]) {
                alertV.message = @"尺寸不能为空";
                [alertV show];
                return;
            }
            
            [params setObject:_bagsizeTextField.text forKey:@"size"];
        }
        
    }
    
    if (_XSImageV.hidden == NO) {
        
        if (!addressDic) {
            alertV.message = @"寄回地址不能为空";
            [alertV show];
            return;
        }
        
        [params setObject:addressDic[@"addressId"] forKey:@"returnAddressId"];
        
    }
    
    
    if (_XSImageV.hidden == NO) {
        
        if ([_bagsizeTextField.text isEqualToString:@""]) {
            alertV.message = @"尺寸不能为空";
            [alertV show];
            return;
        }
        
        [params setObject:_bagsizeTextField.text forKey:@"size"];
        
    }
    
    if (_JAImageV.hidden == NO||_LPHImageV.hidden == NO) {
        
        [params setObject:@"0" forKey:@"shippingprice"];
        
        [params setObject:province_name forKey:@"province_name"];
        [params setObject:city_name forKey:@"city_name"];
        [params setObject:area_name forKey:@"area_name"];

    }
    
    if ([_sortDic[@"pid"] isEqualToString:@"30"]&&_PHImageV.hidden == NO) {
        
        if ([_bagsizeTextField.text isEqualToString:@""]) {
            alertV.message = @"表径不能为空";
            [alertV show];
            return;
        }
        
        [params setObject:_bagsizeTextField.text forKey:@"size"];
        
    }
    
    if (_WBImageV.hidden == NO) {
        
        _WDSortId = [_WDSortId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        [params setObject:_WDSortId forKey:@"cate_id"];
        [params setObject:@"0" forKey:@"free_delivery"];
        [params setObject:@"0" forKey:@"remote_free_delivery"];
        
    }
    
    
    if (![_materialTextField.text isEqualToString:@""]) {
        
        
        [params setObject:MaterialId forKey:@"material"];
        [params setObject:MaterialName forKey:@"material_name"];

    }
    
    
    
    if (![_functionTextField.text isEqualToString:@""]) {
        
        NSString *nameStr = @"";
        
        NSString *idStr = @"";
        
        for (NSDictionary *dic in _functionArr) {
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
            
            idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"id"]];
            
        }
        
        if (_functionArr.count != 0) {
            nameStr =  [nameStr substringFromIndex:1];
            idStr = [idStr substringFromIndex:1];
        }
        
        [params setObject:idStr forKey:@"function"];
        [params setObject:nameStr forKey:@"function_name"];
        
    }
    
    if (![_seriesTextField.text isEqualToString:@""]) {
        
        
        [params setObject:_seriesDic[@"id"] forKey:@"series"];
        
        [params setObject:_seriesDic[@"name"] forKey:@"series_name"];
        
    }
    
    if (![_attachmentTextField.text isEqualToString:@""]) {
        
        NSString *nameStr = @"";
        
        NSString *idStr = @"";
        
        for (NSDictionary *dic in _attachmentArr) {
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
            
            idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"id"]];
            
        }
        
        if (_attachmentArr.count != 0) {
            nameStr =  [nameStr substringFromIndex:1];
            idStr = [idStr substringFromIndex:1];
        }
        
        [params setObject:idStr forKey:@"adjunct"];
        [params setObject:nameStr forKey:@"adjunct_name"];
        
    }

    if (![_modelTextField.text isEqualToString:@""]) {
        
        [params setObject:_modelTextField.text forKey:@"model"];
        
    }
    
    if (![_numberTextField.text isEqualToString:@""]) {
        
        [params setObject:_numberTextField.text forKey:@"goodssn"];
        
    }
    
    if (![_bagsizeTextField.text isEqualToString:@""]) {
        
        [params setObject:_bagsizeTextField.text forKey:@"size_x"];
        
    }
    
    if (![_size_yTextField.text isEqualToString:@""]) {
        
        [params setObject:_size_yTextField.text forKey:@"size_y"];
        
    }
    if (![_size_zTextField.text isEqualToString:@""]) {
        
        [params setObject:_size_zTextField.text forKey:@"size_z"];
        
    }
    
    if (![_ZLTF.text isEqualToString:@""]) {
        
        [params setObject:_ZLTF.text forKey:@"weight"];
        
    }
    
    if (![_KYTF.text isEqualToString:@""]) {
        
        [params setObject:_KYTF.text forKey:@"signet"];
        
    }
    
    if (![_SPMSTextView.text isEqualToString:@""]) {
        
        [params setObject:_SPMSTextView.text forKey:@"note"];
        
    }
    
    if (![_KHTF.text isEqualToString:@""]) {
        
        [params setObject:_CustomerDic[@"id"] forKey:@"customer"];
        
        [params setObject:_CustomerDic[@"name"] forKey:@"customer_name"];

    }
    
    if (![_KHDSJTF.text isEqualToString:@""]) {
        
        [params setObject:_KHDSJTF.text forKey:@"customer_price"];

    }
    
    if (![_HHTF.text isEqualToString:@""]) {
        
        [params setObject:_HHTF.text forKey:@"article_number"];

    }

    if (![_BSTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr1[0][@"id"] forKey:@"gem"];
        
        [params setObject:_gemArr1[0][@"name"] forKey:@"gem_name"];
    }
    
    if (![_SNDTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr2[0][@"id"] forKey:@"density"];
        
        [params setObject:_gemArr2[0][@"name"] forKey:@"density_name"];
    }
    
    if (![_YSTF.text isEqualToString:@""]) {
        
        NSString *nameStr = @"";
        
        NSString *idStr = @"";
        
        for (NSDictionary *dic in _gemArr3) {
            
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
        }
        
        for (NSDictionary *dic in _gemArr3) {
            
            idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"id"]];
        }

        nameStr = [nameStr substringFromIndex:1];
        
        idStr = [idStr substringFromIndex:1];

        [params setObject:idStr forKey:@"color"];
        
        [params setObject:nameStr forKey:@"color_name"];
    }

    if (![_JDTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr4[0][@"id"] forKey:@"clarity"];
        
        [params setObject:_gemArr4[0][@"name"] forKey:@"clarity_name"];
    }

    if (![_QGTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr5[0][@"id"] forKey:@"cutter"];
        
        [params setObject:_gemArr5[0][@"name"] forKey:@"cutter_name"];
    }

    if (![_PGTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr6[0][@"id"] forKey:@"polishing"];
        
        [params setObject:_gemArr6[0][@"name"] forKey:@"polishing_name"];
    }

    if (![_DCXTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr7[0][@"id"] forKey:@"symmetry"];
        
        [params setObject:_gemArr7[0][@"name"] forKey:@"symmetry_name"];
    }
    
    if (![_YGXTF.text isEqualToString:@""]) {
        
        [params setObject:_gemArr8[0][@"id"] forKey:@"fluorescence"];
        
        [params setObject:_gemArr8[0][@"name"] forKey:@"fluorescence_name"];
    }

    if (![_CBJTF.text isEqualToString:@""]) {
        
        [params setObject:_CBJTF.text forKey:@"cost_price"];

    }
    
    
        
    if (_isUpData) {
        
        if (_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_WBImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden&&_ZDImageV.hidden) {
            
            
            [DataSeviece requestUrl:goods_sharehtml params:params success:^(id result) {
                
                NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    
                    [defaults removeObjectForKey:@"Text"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataNotification" object:nil];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                
            }];

        }else{
            
            UpdatePlatform_ViewController *UpdatePlatformVC = [[UpdatePlatform_ViewController alloc]init];
            
            UpdatePlatformVC.params = params;
            
            UpdatePlatformVC.imageArr = _imageArr;
            
            UpdatePlatformVC.typeArr = _typeArr;
            
            [self.navigationController pushViewController:UpdatePlatformVC animated:YES];
            
        }
        
    }else{
        
        
        [DataSeviece requestUrl:goods_sharehtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            _goods_id = result[@"result"][@"data"][@"goods_id"];
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [defaults removeObjectForKey:@"Text"];
                
                if (!_PHImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"ponhu" forKey:@"share_platform"];
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isPHRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:101];
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            PHmsg = result[@"result"][@"msg"];
                        }

                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isPHRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:101];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        PHmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                if (!_ADMImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"aidingmao" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isADMRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:102];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            ADMmsg = result[@"result"][@"msg"];
                            
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isADMRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:102];
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        ADMmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                    
                }
                
                if (!_WBImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"vdian" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isWBRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:103];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            WBmsg = result[@"result"][@"msg"];
                            
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isWBRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:103];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        WBmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                 if (!_LPHImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"liequ" forKey:@"share_platform"];
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isLPHRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:104];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                            
                        }else{
                            
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            LPHmsg = result[@"result"][@"msg"];
                            
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isLPHRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:104];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        LPHmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                if (!_XSImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"newshang" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isXSRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:105];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            XSmsg = result[@"result"][@"msg"];
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isXSRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:105];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        XSmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                        
                    }];
                }
                
                if (!_SPImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"shopuu" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isSPRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:106];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            SPmsg = result[@"result"][@"msg"];
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isSPRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:106];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        SPmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                if (!_ZDImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"xiaohongshu" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isZDRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:107];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                            
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            ZDmsg = result[@"result"][@"msg"];
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isZDRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:107];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        ZDmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                if (!_ADMZYImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"aidingmaopro" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isADMZYRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:108];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                            
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            ADMZYmsg = result[@"result"][@"msg"];
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isADMZYRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:108];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        ADMZYmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                if (!_ADMSJImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"aidingmaomer" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isADMSJRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:109];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                            
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            ADMSJmsg = result[@"result"][@"msg"];
                        }

                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isADMSJRotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:109];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        ADMSJmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                
                if (!_JAImageV.hidden) {
                    
                    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
                    
                    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
                    
                    [params1 setObject:result[@"result"][@"data"][@"id"] forKey:@"id"];
                    
                    [params1 setObject:@"jiuai" forKey:@"share_platform"];
                    
                    
                    [DataSeviece requestUrl:share_outhtml params:params1 success:^(id result) {
                        
                        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
                        
                        isJARotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:110];
                        
                        
                        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                            
                            imageV.image = [UIImage imageNamed:@"rt@2x"];
                            
                        }else{
                            imageV.image = [UIImage imageNamed:@"wr@2x"];
                            JAmsg = result[@"result"][@"msg"];
                        }
                        
                        [self pushAction];
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                        
                        isJARotate = YES;
                        
                        UIImageView *imageV = [feedBackV viewWithTag:110];
                        
                        imageV.image = [UIImage imageNamed:@"wr@2x"];
                        
                        JAmsg = @"服务器异常";
                        
                        [self pushAction];
                        
                    }];
                }
                

                
                
                
                bgView.hidden = NO;
                
                feedBackV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 145, kScreenHeight/2 - 70, 290, 140)];
                feedBackV.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
                feedBackV.layer.cornerRadius = 3;
                feedBackV.layer.masksToBounds = YES;
                [[UIApplication sharedApplication].keyWindow addSubview:feedBackV];
                
                UILabel *PHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
                
                [feedBackV addSubview:PHLabel];
                
                if (!_PHImageV.hidden) {
                    
                    PHLabel.top = 17;
                    PHLabel.left = 20;
                    PHLabel.width = 60;
                    PHLabel.height = 20;
                    PHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    PHLabel.font = [UIFont systemFontOfSize:18];
                    PHLabel.text = @"胖虎";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, PHLabel.top, 20, 20)];
                    
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    imageV.tag = 101;
                    
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                }
                
                UILabel *ADMLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, PHLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:ADMLabel];
                
                if (!_ADMImageV.hidden) {
                    
                    ADMLabel.top = PHLabel.bottom+30;
                    ADMLabel.left = 20;
                    ADMLabel.width = 60;
                    ADMLabel.height = 20;
                    ADMLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    ADMLabel.font = [UIFont systemFontOfSize:18];
                    ADMLabel.text = @"爱丁猫";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ADMLabel.top, 20, 20)];
                    imageV.tag = 102;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                }
                
                UILabel *WBLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ADMLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:WBLabel];
                
                
                if (!_WBImageV.hidden) {
                    
                    WBLabel.top = ADMLabel.bottom+30;
                    WBLabel.left = 20;
                    WBLabel.width = 60;
                    WBLabel.height = 20;
                    WBLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    WBLabel.font = [UIFont systemFontOfSize:18];
                    WBLabel.text = @"微店";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, WBLabel.top, 20, 20)];
                    imageV.tag = 103;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                }
                
                UILabel *LPHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WBLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:LPHLabel];
                
                if (!_LPHImageV.hidden) {
                    
                    
                    LPHLabel.top = WBLabel.bottom+30;
                    LPHLabel.left = 20;
                    LPHLabel.width = 150;
                    LPHLabel.height = 20;
                    LPHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    LPHLabel.font = [UIFont systemFontOfSize:18];
                    LPHLabel.text = @"猎趣";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, LPHLabel.top, 20, 20)];
                    imageV.tag = 104;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    [feedBackV addSubview:imageV];
                    
                }
                
                UILabel *XSLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, LPHLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:XSLabel];
                
                if (!_XSImageV.hidden) {
                    
                    XSLabel.top = LPHLabel.bottom+30;
                    XSLabel.left = 20;
                    XSLabel.width = 60;
                    XSLabel.height = 20;
                    XSLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    XSLabel.font = [UIFont systemFontOfSize:18];
                    XSLabel.text = @"心上";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, XSLabel.top, 20, 20)];
                    imageV.tag = 105;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                }
                
                UILabel *SPLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, XSLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:SPLabel];
                
                if (!_SPImageV.hidden) {
                    
                    SPLabel.top = XSLabel.bottom+30;
                    SPLabel.left = 20;
                    SPLabel.width = 60;
                    SPLabel.height = 20;
                    SPLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    SPLabel.font = [UIFont systemFontOfSize:18];
                    SPLabel.text = @"少铺";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, SPLabel.top, 20, 20)];
                    imageV.tag = 106;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                    
                }
                
                UILabel *ZDLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SPLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:ZDLabel];
                
                
                if (!_ZDImageV.hidden) {
                    
                    ZDLabel.top = SPLabel.bottom+30;
                    ZDLabel.left = 20;
                    ZDLabel.width = 60;
                    ZDLabel.height = 20;
                    ZDLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    ZDLabel.font = [UIFont systemFontOfSize:18];
                    ZDLabel.text = @"小红书";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ZDLabel.top, 20, 20)];
                    imageV.tag = 107;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                    
                }
                
                UILabel *ADMZYLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZDLabel.bottom, 0, 0)];
                [feedBackV addSubview:ADMZYLabel];
                
                if (!_ADMZYImageV.hidden) {
                    
                    ADMZYLabel.top = ZDLabel.bottom+30;
                    ADMZYLabel.left = 20;
                    ADMZYLabel.width = 150;
                    ADMZYLabel.height = 20;
                    ADMZYLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    ADMZYLabel.font = [UIFont systemFontOfSize:18];
                    ADMZYLabel.text = @"爱丁猫专业版";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ADMZYLabel.top, 20, 20)];
                    imageV.tag = 108;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                }
                
                UILabel *ADMSJLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ADMZYLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:ADMSJLabel];
                
                
                if (!_ADMSJImageV.hidden) {
                    
                    ADMSJLabel.top = ADMZYLabel.bottom+30;
                    ADMSJLabel.left = 20;
                    ADMSJLabel.width = 150;
                    ADMSJLabel.height = 20;
                    ADMSJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    ADMSJLabel.font = [UIFont systemFontOfSize:18];
                    ADMSJLabel.text = @"爱丁猫商家版";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, ADMSJLabel.top, 20, 20)];
                    imageV.tag = 109;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                    
                }
                
                UILabel *JALabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ADMSJLabel.bottom, 0, 0)];
                
                [feedBackV addSubview:JALabel];
                
                
                if (!_JAImageV.hidden) {
                    
                    JALabel.top = ADMSJLabel.bottom+30;
                    JALabel.left = 20;
                    JALabel.width = 150;
                    JALabel.height = 20;
                    JALabel.textColor = [RGBColor colorWithHexString:@"#666666"];
                    JALabel.font = [UIFont systemFontOfSize:18];
                    JALabel.text = @"旧爱";
                    
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(feedBackV.width - 20 - 20, JALabel.top, 20, 20)];
                    imageV.tag = 110;
                    imageV.image = [UIImage imageNamed:@"loading@2x.png"];
                    [feedBackV addSubview:imageV];
                    
                    [self startAnimation:imageV];
                    
                }
                
                
                feedBackV.height = JALabel.bottom +20;
                
                feedBackV.top = (kScreenHeight - feedBackV.height)/2;
            }
            
            if (_WBImageV.hidden&&_ADMImageV.hidden&&_WBImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
                
                [self pushAction];
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
    }


}


//跳转绑定账号页面
- (void)pushAccount{
    
    
    
    //绑定平台账号
    PlatformAccountViewController *storageVC = [[UIStoryboard storyboardWithName:@"AddNew" bundle:nil] instantiateViewControllerWithIdentifier:@"PlatformAccountViewController"];
    
    [self.navigationController pushViewController:storageVC animated:YES];
    
    
    
}


- (void)startAnimation:(UIImageView*)imageV
 {
     
     if (imageV.tag == 101) {
        
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle1 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             if (!isPHRotate) {
                 angle1 += 10; [self startAnimation:imageV];
             }else{
                 
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 102) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle2 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isADMRotate) {
                 angle2 += 10; [self startAnimation:imageV];
             }else{
             
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];

     }
     
     if (imageV.tag == 103) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle3 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isWBRotate) {
                 angle3 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 104) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle4 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isLPHRotate) {
                 angle4 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 105) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle5 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isXSRotate) {
                 angle5 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 106) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle6 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isSPRotate) {
                 angle6 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 107) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle7 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isZDRotate) {
                 angle7 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 108) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle8 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isADMZYRotate) {
                 angle8 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }

     if (imageV.tag == 109) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle9 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isADMSJRotate) {
                 angle9 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }
     
     if (imageV.tag == 110) {
         
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle10 * (M_PI / 180.0f));
         
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             imageV.transform = endAngle;
         } completion:^(BOOL finished) {
             
             if (!isJARotate) {
                 angle10 += 10; [self startAnimation:imageV];
             }else{
                 imageV.transform = CGAffineTransformMakeRotation(0);
             }
         }];
     }

     

}

- (void)pushAction{

    BOOL isph;
    BOOL isadm;
    BOOL iswb;
    BOOL islph;
    BOOL isxs;
    BOOL issp;
    BOOL iszd;
    BOOL isadmzy;
    BOOL isadmsj;
    BOOL isja;

    
    NSMutableArray *arr = [NSMutableArray array];
    
    UIImageView *imageV1 = [feedBackV viewWithTag:101];
    UIImageView *imageV2 = [feedBackV viewWithTag:102];
    UIImageView *imageV3 = [feedBackV viewWithTag:103];
    UIImageView *imageV4 = [feedBackV viewWithTag:104];
    UIImageView *imageV5 = [feedBackV viewWithTag:105];
    UIImageView *imageV6 = [feedBackV viewWithTag:106];
    UIImageView *imageV7 = [feedBackV viewWithTag:107];
    UIImageView *imageV8 = [feedBackV viewWithTag:108];
    UIImageView *imageV9 = [feedBackV viewWithTag:109];
    UIImageView *imageV10 = [feedBackV viewWithTag:110];
    
    if (!_PHImageV.hidden) {
        
        isph = isPHRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"胖虎50@2x" forKey:@"img"];
        
        if ([imageV1.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:PHmsg forKey:@"msg"];
        }
        [arr addObject:dic];
        
    }else{
        
        isph = YES;
        
    }
    
    if (!_ADMImageV.hidden) {
        isadm = isADMRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"爱丁猫50@2x" forKey:@"img"];
        
        if ([imageV2.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            
            [dic setObject:@"1" forKey:@"isSuccess"];
            
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ADMmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isadm = YES;
    }
    
    if (!_WBImageV.hidden) {
        iswb = isWBRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"微店34x34@2x" forKey:@"img"];
        if ([imageV3.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:WBmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        iswb = YES;
    }
    
    if (!_LPHImageV.hidden) {
        
        islph = isLPHRotate;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"猎趣34@2x" forKey:@"img"];
        
        if ([imageV4.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            
            [dic setObject:@"1" forKey:@"isSuccess"];
            
        }else{
            
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:LPHmsg forKey:@"msg"];
        }
        
        [arr addObject:dic];


    }else{
        islph = YES;
    }
    
    if (!_XSImageV.hidden) {
        isxs = isXSRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"心上34@2x" forKey:@"img"];
        if ([imageV5.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:XSmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isxs = YES;
    }
    
    if (!_SPImageV.hidden) {
        issp = isSPRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"少铺34@2x" forKey:@"img"];
        if ([imageV6.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:SPmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        issp = YES;
    }
    
    if (!_ZDImageV.hidden) {
        iszd = isZDRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"xhs34@2x" forKey:@"img"];
        
        if ([imageV7.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ZDmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        iszd = YES;
    }
    
    if (!_ADMZYImageV.hidden) {
        isadmzy = isADMZYRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"爱丁专业34@2x" forKey:@"img"];
        
        if ([imageV8.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ADMZYmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isadmzy = YES;
    }
    
    if (!_ADMSJImageV.hidden) {
        isadmsj = isADMSJRotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"爱丁商家34@2x" forKey:@"img"];
        
        if ([imageV9.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:ADMSJmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isadmsj = YES;
    }

    if (!_JAImageV.hidden) {
        isja = isJARotate;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"jiuai34@2x" forKey:@"img"];
        
        if ([imageV10.image isEqual:[UIImage imageNamed:@"rt@2x"]]) {
            [dic setObject:@"1" forKey:@"isSuccess"];
        }else{
            [dic setObject:@"0" forKey:@"isSuccess"];
            [dic setObject:JAmsg forKey:@"msg"];
            
        }
        [arr addObject:dic];
        
    }else{
        isja = YES;
    }


    


    if (isph&&isadm&&iswb&&islph&&isxs&&issp&&iszd&&isadmzy&&isadmsj&&isja) {
        
        bgView.hidden = YES;
        feedBackV.hidden = YES;
        
        ReleaseCompleteViewController *ReleaseCompleteVC = [[ReleaseCompleteViewController alloc]init];
        NSLog(@"%@",arr);
        ReleaseCompleteVC.arr = [arr copy];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:_titleTextField.text forKey:@"goods_name"];
        
        [params setObject:_brandId forKey:@"brand_id"];
        
        [params setObject:_sortId forKey:@"category_id"];
        
        [params setObject:_expectedId forKey:@"expected_delivery_type"];
        
        [params setObject:_describeTextView.text forKey:@"goods_description"];
        
        [params setObject:_gradeId forKey:@"grade"];
        
        [params setObject:_priceTextField.text forKey:@"price"];
        
        [params setObject:_publicPriceTextField.text forKey:@"market_price"];
        

        NSMutableDictionary *dic = [NSMutableDictionary dictionary];

        
        for (int i = 0; i < 9; i++) {
            
            if (![_imageStrArr[i] isEqualToString:@""]) {
                
                [dic setObject:_imageStrArr[i] forKey:[NSString stringWithFormat:@"%d",i]];
                
            }
        }
        
        [params setObject:dic forKey:@"img"];
        
        [params setObject:_imageArr forKey:@"imageArr"];
        
        ReleaseCompleteVC.dataDic = [params copy];
        
        ReleaseCompleteVC.goods_id = _goods_id;
        
        ReleaseCompleteVC.isCopy = _isCopy;
        
        
        [self.navigationController pushViewController:ReleaseCompleteVC animated:YES];
        
    }
    
    
}
- (void)leftBtnAction{
    
    if (_isOnePush) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:_agentPriceTextField.text forKey:@"agency_price"];
        
        [params setObject:_titleTextField.text forKey:@"goods_name"];
        
        [params setObject:_brandId forKey:@"brand_id"];
        
        
        [params setObject:_sortId forKey:@"category_id"];
        
        if (_sortDic[@"category_name"]) {
            
            [params setObject:_sortDic[@"category_name"] forKey:@"category_name"];
            
        }
        
        if (_sortDic[@"pid"]) {
            
            [params setObject:_sortDic[@"pid"] forKey:@"pid"];

        }

        [params setObject:_expectedId forKey:@"expected_delivery_type"];
        
        [params setObject:_describeTextView.text forKey:@"goods_description"];
        
        [params setObject:_gradeId forKey:@"grade"];
        
        [params setObject:_priceTextField.text forKey:@"price"];
        
        [params setObject:_publicPriceTextField.text forKey:@"market_price"];
        
        [params setObject:_imageStrArr forKey:@"img"];
        
        if (![_materialTextField.text isEqualToString:@""]) {
            
            [params setObject:MaterialId forKey:@"material"];
            [params setObject:MaterialName forKey:@"material_name"];
            

        }
        
        if (![_functionTextField.text isEqualToString:@""]) {
            
            NSString *nameStr = @"";
            
            NSString *idStr = @"";
            
            for (NSDictionary *dic in _functionArr) {
                
                nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
                
                idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"id"]];
                
            }
            
            
            if (_functionArr.count != 0) {
                nameStr =  [nameStr substringFromIndex:1];
                idStr = [idStr substringFromIndex:1];
            }
            
            [params setObject:idStr forKey:@"function"];
            [params setObject:nameStr forKey:@"function_name"];
            
        }
        
        if (![_seriesTextField.text isEqualToString:@""]) {
            
      
            [params setObject:_seriesDic[@"id"] forKey:@"series"];
            [params setObject:_seriesDic[@"name"]  forKey:@"series_name"];
            
        }
        
        if (![_attachmentTextField.text isEqualToString:@""]) {
            
            NSString *nameStr = @"";
            
            NSString *idStr = @"";
            
            for (NSDictionary *dic in _attachmentArr) {
                
                nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
                
                idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"id"]];
                
            }
            
            
            if (_attachmentArr.count != 0) {
                nameStr =  [nameStr substringFromIndex:1];
                idStr = [idStr substringFromIndex:1];
            }
            
            [params setObject:idStr forKey:@"adjunct"];
            [params setObject:nameStr forKey:@"adjunct_name"];
            
        }
        
        if (![_modelTextField.text isEqualToString:@""]) {
            
            [params setObject:_modelTextField.text forKey:@"model"];
            
        }
        
        if (![_numberTextField.text isEqualToString:@""]) {
            
            [params setObject:_numberTextField.text forKey:@"goodssn"];
            
            
        }
        
        if (![_bagsizeTextField.text isEqualToString:@""]) {
            
            [params setObject:_bagsizeTextField.text forKey:@"size_x"];
            
        }
        
        if (![_size_yTextField.text isEqualToString:@""]) {
            
            [params setObject:_size_yTextField.text forKey:@"size_y"];
            
        }
        if (![_size_zTextField.text isEqualToString:@""]) {
            
            [params setObject:_size_zTextField.text forKey:@"size_z"];
            
        }
        
        
        if (![_ZLTF.text isEqualToString:@""]) {
            
            
            [params setObject:_ZLTF.text forKey:@"weight"];
            
        }
        
        if (![_KYTF.text isEqualToString:@""]) {
            
            [params setObject:_KYTF.text forKey:@"signet"];
            
        }
        
        if (![_SPMSTextView.text isEqualToString:@""]) {
            
            [params setObject:_SPMSTextView.text forKey:@"note"];
            
        }
        
        if (![_KHTF.text isEqualToString:@""]) {
            
            [params setObject:_CustomerDic[@"id"] forKey:@"customer"];
            
            [params setObject:_CustomerDic[@"name"] forKey:@"customer_name"];
            
        }
        
        if (![_KHDSJTF.text isEqualToString:@""]) {
            
            [params setObject:_KHDSJTF.text forKey:@"customer_price"];
            
        }
        
        if (![_HHTF.text isEqualToString:@""]) {
            
            [params setObject:_HHTF.text forKey:@"article_number"];
            
        }
        
        if (![_BSTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr1[0][@"id"] forKey:@"gem"];
            
            [params setObject:_gemArr1[0][@"name"] forKey:@"gem_name"];
        }
        
        if (![_SNDTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr2[0][@"id"] forKey:@"density"];
            
            [params setObject:_gemArr2[0][@"name"] forKey:@"density_name"];
        }
        
        if (![_YSTF.text isEqualToString:@""]) {
            
            NSString *nameStr = @"";
            
            NSString *idStr = @"";
            
            for (NSDictionary *dic in _gemArr3) {
                
                nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,dic[@"name"]];
            }
            
            for (NSDictionary *dic in _gemArr3) {
                
                idStr = [NSString stringWithFormat:@"%@,%@",idStr,dic[@"id"]];
            }
            
            nameStr = [nameStr substringFromIndex:1];
            
            idStr = [idStr substringFromIndex:1];
            
            [params setObject:idStr forKey:@"color"];
            
            [params setObject:nameStr forKey:@"color_name"];

        }
        
        if (![_JDTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr4[0][@"id"] forKey:@"clarity"];
            
            [params setObject:_gemArr4[0][@"name"] forKey:@"clarity_name"];
        }
        
        if (![_QGTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr5[0][@"id"] forKey:@"cutter"];
            
            [params setObject:_gemArr5[0][@"name"] forKey:@"cutter_name"];
        }
        
        if (![_PGTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr6[0][@"id"] forKey:@"polishing"];
            
            [params setObject:_gemArr6[0][@"name"] forKey:@"polishing_name"];
        }
        
        if (![_DCXTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr7[0][@"id"] forKey:@"symmetry"];
            
            [params setObject:_gemArr7[0][@"name"] forKey:@"symmetry_name"];
        }
        
        if (![_YGXTF.text isEqualToString:@""]) {
            
            [params setObject:_gemArr8[0][@"id"] forKey:@"fluorescence"];
            
            [params setObject:_gemArr8[0][@"name"] forKey:@"fluorescence_name"];
        }
        
        
        if (![_CBJTF.text isEqualToString:@""]) {
            
            [params setObject:_CBJTF.text forKey:@"cost_price"];
            
        }

        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[params copy] forKey:@"Text"];
        
        [defaults synchronize];
 
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"一键发布";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableArray *selectTypeArr = [NSMutableArray array];
    
    if (_PHButton.selected == YES) {
        
        [selectTypeArr addObject:@"ponhu"];
    }
    if (_ADMButton.selected == YES) {
        
        [selectTypeArr addObject:@"aidingmao"];
    }
    if (_WBButton.selected == YES) {
        
        [selectTypeArr addObject:@"vdian"];
    }
    if (_LPHButton.selected == YES) {
        
        [selectTypeArr addObject:@"liequ"];
    }
    if (_XSButton.selected == YES) {
        
        [selectTypeArr addObject:@"newshang"];
    }
    if (_SPButton.selected == YES) {
        
        [selectTypeArr addObject:@"shopuu"];
    }
    if (_ZDButton.selected == YES) {
        
        [selectTypeArr addObject:@"xiaohongshu"];
    }
    if (_ADMZYButton.selected == YES) {
        
        [selectTypeArr addObject:@"aidingmaopro"];
    }
    if (_ADMSJButton.selected == YES) {
        
        [selectTypeArr addObject:@"aidingmaomer"];
    }
    if (_JAButton.selected == YES) {
        
        [selectTypeArr addObject:@"jiuai"];
    }
    
    
    [defaults setObject:[selectTypeArr copy] forKey:[NSString stringWithFormat:@"%@Type",SYGData[@"id"]]];
    
    [defaults synchronize];
    
}


- (IBAction)PHAction:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        _PHImageV.hidden = YES;
        _PHLabel.textColor = [RGBColor colorWithHexString:@"#999999"];

    }else{
        
        sender.selected = YES;
        _PHImageV.hidden = NO;
        _PHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        

    }
    
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
        
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];

}

- (IBAction)ADMAction:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
        _ADMImageV.hidden = YES;
        _ADMLabel.textColor = [RGBColor colorWithHexString:@"#999999"];

    }else{
        
        sender.selected = YES;
        _ADMImageV.hidden = NO;
        _ADMLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        

    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];


}

- (IBAction)WBAction:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
        _WBImageV.hidden = YES;
        _WBLabel.textColor = [RGBColor colorWithHexString:@"#999999"];

    }else{
        
        sender.selected = YES;
        _WBImageV.hidden = NO;
        _WBLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        

        
    }
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];

}

- (IBAction)LPHAction1:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _LPHImageV.hidden = YES;
        
        _LPHLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        
    }else{
        
        sender.selected = YES;
        
        _LPHImageV.hidden = NO;
        
        _LPHLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        
    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
        
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    
    [self.tableView reloadData];

    
    
}

- (IBAction)XSAction1:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _XSImageV.hidden = YES;
        
        _XSLabel.textColor = [RGBColor colorWithHexString:@"#999999"];

        
    }else{
        
        sender.selected = YES;
        
        _XSImageV.hidden = NO;
        
        _XSLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
    
}

- (IBAction)SPAction1:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _SPImageV.hidden = YES;
        
        _SPLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        
    }else{
        
        sender.selected = YES;
        
        _SPImageV.hidden = NO;
        
        _SPLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        

    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    
    [self.tableView reloadData];
    
}

- (IBAction)ZDAction1:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _ZDImageV.hidden = YES;
        
        _ZDLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        
    }else{
        
        sender.selected = YES;
        
        _ZDImageV.hidden = NO;
        
        _ZDLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        

    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }

    
    [self.tableView reloadData];
    
}


- (IBAction)ADMZYAction1:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _ADMZYImageV.hidden = YES;
        
        _ADMZYLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        
    }else{
        
        sender.selected = YES;
        
        _ADMZYImageV.hidden = NO;
        
        _ADMZYLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        
    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    
    [self.tableView reloadData];
    
}

- (IBAction)ADMSJAction1:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _ADMSJImageV.hidden = YES;
        
        _ADMSJLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        
    }else{
        
        sender.selected = YES;
        
        _ADMSJImageV.hidden = NO;
        
        _ADMSJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        

    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }

    
    
    [self.tableView reloadData];
    
}

- (IBAction)JAAction1:(UIButton *)sender {
    
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        _JAImageV.hidden = YES;
        
        _JALabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        
    }else{
        
        sender.selected = YES;
        
        _JAImageV.hidden = NO;
        
        _JALabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        
        
    }
    
    if (_WBImageV.hidden&&_ADMImageV.hidden&&_PHImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_ZDImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_JAImageV.hidden) {
        
        _isSPCS = YES;
        
        [_tureButton setTitle:@"保存到我的商品" forState:UIControlStateNormal];
    }else{
        _isSPCS = NO;
        
        [_tureButton setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row == 0) {

        if (_isUpData) {
            return 0;
        }
        return 11;
        
    }else if (indexPath.row == 1){
        
        //平台选择
        if (_isUpData) {
            return 0;
        }else{
            return 105;
        }
    
    }else if (indexPath.row == 2){
        
        return 12;

        
    }else if (indexPath.row == 3){
        //图片
        return 144;

    }else if (indexPath.row == 4){
        if (_isSPCS) {
            //货号
            return 48;
        }

    }else if (indexPath.row == 5){
        
        //来源
        return 48;

    }else if (indexPath.row == 6){
     
        return 10;
        
    }else if (indexPath.row == 7){
        
        if (_isSPCS) {
            //客户
            return 48;

        }
        
    }else if (indexPath.row == 8){
        if (_isSPCS&&_HSButton.selected) {
            //客户到手价
            return 48;
        }
    }else if (indexPath.row == 9){
        if (_isSPCS&&_JMButton.selected) {
            //进价
            return 48;
        }
    }else if (indexPath.row == 10){
        //同行价
        if (isDL) {
            return 48;
        }
        
    }else if (indexPath.row == 11){
        //售价
        return 48;

    }else if (indexPath.row == 12){
        
        return 20;
    }else if (indexPath.row == 13){
        
        //类别

        
        return 48;

    }else if (indexPath.row == 14){
        //品牌
        
        if (_PHImageV.hidden&&_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden&&!_isSPCS) {
            
            return 0;
            
        }else{
            
            if ([_sortDic[@"pid"] isEqualToString:@"129"]||[_sortId isEqualToString:@""]) {
                
                return 0;
            }
            
            return 48;
        }
        
        
    }else if (indexPath.row == 15){
        
        //商品系列
        
        if (_seriesArr.count != 0&&_isSPCS) {
            return 48;
        }

        
    }else if (indexPath.row == 16){
        
        //商品型号
        if (_isSPCS&&[_sortDic[@"pid"] isEqualToString:@"30"]) {
            
            return 48;
        }
    }else if (indexPath.row == 17){
        
        //材质
        if (_isSPCS&&_ALLMaterialArr.count != 0) {
            
            if (![_sortId isEqualToString:@""]) {
                
                return 48;
            }
        }
        
    }else if (indexPath.row == 18){
        
        //宝石
        if (_isSPCS&&([_sortDic[@"pid"] isEqualToString:@"22"])) {
            
            return 48;
        }

        
    }else if (indexPath.row == 19){
        //色浓度
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]) {
                
                return 48;

            }else if (_gemArr1.count > 0){
            
                if ([_gemArr1[0][@"id"] integerValue] == 2) {
                    
                    return 48;
                }
                
            }
        }
        
    }else if (indexPath.row == 20){
        
        //颜色
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]||[_sortId isEqualToString:@"132"]) {
                
                return 48;
                
            }else if (_gemArr1.count > 0){
                
                if ([_gemArr1[0][@"id"] integerValue] == 2||[_gemArr1[0][@"id"] integerValue] == 1) {
                    
                    return 48;
                }
                
            }
        }

    }else if (indexPath.row == 21){
        
        //净度
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]||[_sortId isEqualToString:@"132"]) {
                
                return 48;
                
            }else if (_gemArr1.count > 0){
                
                if ([_gemArr1[0][@"id"] integerValue] == 2||[_gemArr1[0][@"id"] integerValue] == 1) {
                    
                    return 48;
                }
                
            }
        }
    }else if (indexPath.row == 22){
        //切工
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]||[_sortId isEqualToString:@"132"]) {
                
                return 48;
                
            }else if (_gemArr1.count > 0){
                
                if ([_gemArr1[0][@"id"] integerValue] == 2||[_gemArr1[0][@"id"] integerValue] == 1) {
                    
                    return 48;
                }
                
            }
        }
        
    }else if (indexPath.row == 23){
        
        //抛光
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]||[_sortId isEqualToString:@"132"]) {
                
                return 48;
                
            }else if (_gemArr1.count > 0){
                
                if ([_gemArr1[0][@"id"] integerValue] == 2||[_gemArr1[0][@"id"] integerValue] == 1) {
                    
                    return 48;
                }
                
            }
        }
    }else if (indexPath.row == 24){
        
        //对称性
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]||[_sortId isEqualToString:@"132"]) {
                
                return 48;
                
            }else if (_gemArr1.count > 0){
                
                if ([_gemArr1[0][@"id"] integerValue] == 2||[_gemArr1[0][@"id"] integerValue] == 1) {
                    
                    return 48;
                }
                
            }
        }
        
    }else if (indexPath.row == 25){
        
        //荧光性
        if (_isSPCS) {
            
            if ([_sortId isEqualToString:@"133"]||[_sortId isEqualToString:@"132"]) {
                
                return 48;
                
            }else if (_gemArr1.count > 0){
                
                if ([_gemArr1[0][@"id"] integerValue] == 2||[_gemArr1[0][@"id"] integerValue] == 1) {
                    
                    return 48;
                }
            }
        }
    }else if (indexPath.row == 26){
        
        //功能
        if (_isSPCS&&_ALLFunctionArr.count != 0) {
            
            if (![_sortId isEqualToString:@""]) {
                
                return 48;
                
            }
        }
        
    }else if (indexPath.row == 27){
        //编号
        if (_isSPCS&&([_sortDic[@"pid"] isEqualToString:@"1"]||[_sortDic[@"pid"] isEqualToString:@"30"])) {

            return 48;

        }
        
    }else if (indexPath.row == 28){
        
        if (_isSPCS) {

            if (![_sortId isEqualToString:@""]) {
                
                return 10;
            }

        }
        
    }else if (indexPath.row == 29){
        //重量
        if (_isSPCS&&([_sortDic[@"pid"] isEqualToString:@"129"]||_gemArr1.count != 0)) {
            
            return 48;
        }
    }else if (indexPath.row == 30){
        //尺寸 表径
        if (([_sortDic[@"pid"] isEqualToString:@"1"]&&_PHImageV.hidden == NO)||_XSImageV.hidden == NO||([_sortDic[@"pid"] isEqualToString:@"30"]&&_PHImageV.hidden == NO)||_isSPCS) {
            
            if (![_sortId isEqualToString:@""]) {
                
                if ([_sortDic[@"pid"] isEqualToString:@"30"]) {
                    
                    _size_yTextField.hidden = NO;
                    _sizeLabel1.hidden = NO;
                    _size_zTextField.hidden = YES;
                    _sizeLabel2.hidden = NO;
                    _sizeLabel3.hidden = YES;
                    _sizeLabel1.text = @"mm  *";
                    _sizeLabel2.text = @"mm";
                    _sizeWidth.constant = 40;

                }else if ([_sortDic[@"pid"] isEqualToString:@"1"]){
                    
                    _size_yTextField.hidden = NO;
                    _sizeLabel1.hidden = NO;
                    _size_zTextField.hidden = NO;
                    _sizeLabel2.hidden = NO;
                    _sizeLabel3.hidden = NO;
                    _sizeLabel1.text = @"cm  *";
                    _sizeLabel2.text = @"cm  *";
                    _sizeLabel3.text = @"cm";
                    _sizeWidth.constant = 40;

                }else{
                    
                    _size_yTextField.hidden = YES;
                    _sizeLabel1.hidden = YES;
                    _size_zTextField.hidden = YES;
                    _sizeLabel2.hidden = YES;
                    _sizeLabel3.hidden = YES;
                    _sizeWidth.constant = 60;
                }
                
                if ([_sortDic[@"pid"] isEqualToString:@"129"]) {
                    
                    return 0;
                }
                
                return 48;
                
            }
            
        }
        
    }else if (indexPath.row == 31){
        
        //刻印
        if (_isSPCS&&[_sortDic[@"pid"] isEqualToString:@"22"]) {
            
            return 48;
        }
        
    }else if (indexPath.row == 32){
        //成色
        
        return 48;


        
    }else if (indexPath.row == 33){
        //附件
        if (_isSPCS&&_ALLAttachmentArr.count != 0) {
            
            if (![_sortId isEqualToString:@""]) {
                
                return 48;
            }

        }
        
    }else if (indexPath.row == 34){
    
        //产品公价
        if (_PHImageV.hidden&&_ADMImageV.hidden&&_ADMZYImageV.hidden&&_ADMSJImageV.hidden&&_LPHImageV.hidden&&_XSImageV.hidden&&_SPImageV.hidden&&_JAImageV.hidden&&!_isSPCS) {
            return 0;
        }else{
            return 48;
        }

    }else if (indexPath.row == 35){

        if (_isSPCS) {
            
            return 10;
        }

        
    }else if (indexPath.row == 36){
        //发货时间
        if (_PHImageV.hidden == NO||_ADMImageV.hidden == NO||_ADMZYImageV.hidden == NO||_ADMSJImageV.hidden == NO) {
            return 48;
            
        }else{
            
            return 0;
        }
        
    }else if (indexPath.row == 37){
        //微店类别
        if (_WBImageV.hidden == NO) {
            return 48;
        }else{
            return 0;
        }
    }else if (indexPath.row == 38){
        //寄回地址
        if (_XSImageV.hidden == NO) {
            return 48;
        }else{
            return 0;
            
        }
    }else if (indexPath.row == 39){
        //选择地址
        if (_JAImageV.hidden == NO||_LPHImageV.hidden == NO) {
            return 48;
        }else{
            return 0;
        }
    }else if (indexPath.row == 40){
        return 0;

    }else if (indexPath.row == 41){
        
        if (_isSPCS) {

            return 0;
        }else{
            //商品标题
            return 65;

        }
    }else if (indexPath.row == 42){
        
        //&&([_sortDic[@"pid"] isEqualToString:@"129"]||[_sortDic[@"pid"] isEqualToString:@"22"])
        //备注
        if (_isSPCS) {

            return 105;
        }
        
    }else if (indexPath.row == 43){
        //朋友圈
        return 105;
        
    }else if (indexPath.row == 44){
        
        //确定按钮
        return 181;
    }

    return 0;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString *brandStr = [self CreatbrandStr];
    

    if (indexPath.row == 7){
        
        //客户
        CustomerViewController *customerVC = [[CustomerViewController alloc]init];
        
        [self.navigationController pushViewController:customerVC animated:YES];
        
    }else if (indexPath.row == 13){
        
        //分类
        SortConditionViewController *SortConditionVC = [[SortConditionViewController alloc]init];
        
        SortConditionVC.sortStr = brandStr;
        
        [self.navigationController pushViewController:SortConditionVC animated:YES];
        
    }else if (indexPath.row == 14) {
        
        //品牌
        BrandChoiceViewController *BrandChoiceVC = [[BrandChoiceViewController alloc]init];

        BrandChoiceVC.brandStr = brandStr;
        
        BrandChoiceVC.sort_pid = _sortDic[@"pid"];
        
        BrandChoiceVC.sort_id = _sortId;

        [self.navigationController pushViewController:BrandChoiceVC animated:YES];
        
    }else if (indexPath.row == 15) {
        
        //系列
        ProductParametersViewController *ProductParametersVC = [[ProductParametersViewController alloc]init];
        
        ProductParametersVC.typeStr = @"4";
        
        ProductParametersVC.dataArr = _seriesArr;
        
        [self.navigationController pushViewController:ProductParametersVC animated:YES];
        
    }else if (indexPath.row == 17) {
        
        
        WDSortViewController *WDSortVC = [[WDSortViewController alloc]init];
        
        WDSortVC.isMaterial = YES;
        
        WDSortVC.dataArr = [NSMutableArray arrayWithArray:_ALLMaterialArr];
        
        WDSortVC.nameStr = MaterialName;
        
        WDSortVC.idStr = MaterialId;

        
        [self.navigationController pushViewController:WDSortVC animated:YES];
        

    }else if (indexPath.row == 18){
    
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"1";
        
        gemParametersVC.typeName = @"宝石";
        
        gemParametersVC.oldArr = _gemArr1;
    
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 19){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"2";
        
        gemParametersVC.oldArr = _gemArr2;

        gemParametersVC.typeName = @"色浓度";
        
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 20){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.oldArr = _gemArr3;
        gemParametersVC.typeStr = @"3";
        gemParametersVC.typeName = @"颜色";
        
        if ([_sortId isEqualToString:@"133"]) {
            
            gemParametersVC.isDrill = YES;
            
        }
        
        if (_gemArr1.count > 0) {
         
            if ([_gemArr1[0][@"id"] integerValue] == 2) {
                
                gemParametersVC.isDrill = YES;
                
            }
            
        }
        
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 21){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"4";
        
        gemParametersVC.typeName = @"净度";
        
        
        gemParametersVC.oldArr = _gemArr4;

        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 22){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"5";
        
        gemParametersVC.typeName = @"切工";
        
        gemParametersVC.oldArr = _gemArr5;

        
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 23){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"6";
        
        gemParametersVC.typeName = @"抛光";
        
        gemParametersVC.oldArr = _gemArr6;

        
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 24){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"7";
        
        gemParametersVC.typeName = @"对称性";
        
        gemParametersVC.oldArr = _gemArr7;
        
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 25){
        
        GemParametersViewController *gemParametersVC = [[GemParametersViewController alloc]init];
        
        gemParametersVC.typeStr = @"8";
        
        gemParametersVC.typeName = @"荧光性";
        
        gemParametersVC.oldArr = _gemArr8;
        
        [self.navigationController pushViewController:gemParametersVC animated:YES];
        
    }else if (indexPath.row == 26) {
        
        //功能
        ProductParametersViewController *ProductParametersVC = [[ProductParametersViewController alloc]init];
        
        ProductParametersVC.typeStr = @"2";
        
        
        ProductParametersVC.dataArr = _ALLFunctionArr;

        
        ProductParametersVC.oldArr = _functionArr;

        
        [self.navigationController pushViewController:ProductParametersVC animated:YES];
        
    }else if (indexPath.row == 32) {
        
        if (![_sortDic[@"pid"] isEqualToString:@"129"]) {
            
            //成色
            GradeConditionViewController *GradeConditionVC = [[GradeConditionViewController alloc]init];
            [self.navigationController pushViewController:GradeConditionVC animated:YES];
            

        }
        
    }else if (indexPath.row == 33){
        
        //附件
        ProductParametersViewController *ProductParametersVC = [[ProductParametersViewController alloc]init];
        
        ProductParametersVC.typeStr = @"3";
        
        ProductParametersVC.dataArr = _ALLAttachmentArr;
        
        ProductParametersVC.oldArr = _attachmentArr;
        
        [self.navigationController pushViewController:ProductParametersVC animated:YES];
        
        
    }else if (indexPath.row == 36){
        
        //发货时间
        ExpectedDeliveryType_ViewController *GradeConditionVC = [[ExpectedDeliveryType_ViewController alloc]init];
        [self.navigationController pushViewController:GradeConditionVC animated:YES];
        
    }else if (indexPath.row == 37){
        
        //微店类别

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:@"vdian" forKey:@"type"];
        
        [params setObject:@"1" forKey:@"is_default"];
        
        [DataSeviece requestUrl:Shareget_share_accounthtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            NSArray *arr = result[@"result"][@"data"][@"item"];
            
            BOOL is_default = NO;
            
            for (NSDictionary *dic in arr) {
                
                if ([dic[@"is_default"] isEqualToString:@"1"]&&[dic[@"status"] isEqualToString:@"1"]) {
                    
                    is_default = YES;
                    
                }
            }
            
            if (is_default) {
                
                WDSortViewController *WDSortVC = [[WDSortViewController alloc]init];
                WDSortVC.idStr = _WDSortId;
                [self.navigationController pushViewController:WDSortVC animated:YES];
                
            }else{
                
                AccountListViewController *AccountListVC = [[AccountListViewController alloc]init];
                
                AccountListVC.titleStr = @"vdian";
                
                [self.navigationController pushViewController:AccountListVC animated:YES];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if (indexPath.row == 38){
        
        //寄回地址
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        
        [params setObject:@"newshang" forKey:@"type"];
        
        [params setObject:@"1" forKey:@"is_default"];
        
        [DataSeviece requestUrl:Shareget_share_accounthtml params:params success:^(id result) {

            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            NSArray *arr = result[@"result"][@"data"][@"item"];
            
            BOOL is_default = NO;
            
            for (NSDictionary *dic in arr) {
                
                if ([dic[@"is_default"] isEqualToString:@"1"]&&[dic[@"status"] isEqualToString:@"1"]) {
                    
                    is_default = YES;
                    
                }
            }
            
            if (is_default) {
                
                SelectTheAddressViewController *SelectTheAddressVC = [[SelectTheAddressViewController alloc]init];
                
                if (addressDic[@"addressId"]) {
                    NSLog(@"%@",addressDic[@"addressId"]);
                    SelectTheAddressVC.addressId = addressDic[@"addressId"];
                }else{
                    SelectTheAddressVC.addressId = @"";
                }
                
                [self.navigationController pushViewController:SelectTheAddressVC animated:YES];
                
            }else{
                
                AccountListViewController *AccountListVC = [[AccountListViewController alloc]init];
                
                AccountListVC.titleStr = @"newshang";
                
                [self.navigationController pushViewController:AccountListVC animated:YES];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if (indexPath.row == 39){
        
        //货物地址
        _adressV.hidden = NO;
    }
    
}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length > 190) {
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"朋友圈文字不能超过190" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        textView.text = [textView.text substringToIndex:190];
        
        return YES;
        
    }

    
    
    return YES;
}

//已经结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    //朋友圈文字
    NSString *friendText = [self creatFriendText];
    
    if (![_describeTextView.text isEqualToString:friendText]) {
        
        _isPYQCopy = YES;
        
    }

}


- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField == _priceTextField||textField == _publicPriceTextField||textField == _modelTextField||textField == _bagsizeTextField||textField == _size_zTextField||textField == _size_yTextField||textField == _ZLTF) {
        
        //朋友圈文字
        NSString *friendText = [self creatFriendText];
        
        if (!_isPYQCopy) {
        
            _describeTextView.text = friendText;

        }

    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == _titleTextField) {
        
        if (!_ZDImageV.hidden||!_JAImageV.hidden) {

        
        if (textField.text.length > 30) {
            
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"商品标题不能超过30" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertV show];
            
            textField.text = [textField.text substringToIndex:30];
            
        }
            
        }
        
        if (!_XSImageV.hidden||!_LPHImageV.hidden) {
            
            if (textField.text.length > 40) {
                
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"商品标题不能超过40" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
                
                textField.text = [textField.text substringToIndex:40];
                
            }
        }
    }

    return YES;
}

//删除图片
- (void)RemoveImageNotification:(NSNotification*)noti{

    NSInteger index = [[noti object] integerValue];
    
    
    [_imageStrArr replaceObjectAtIndex:index withObject:@""];

    if (_imageArr.count > index) {
        
        [_imageArr removeObjectAtIndex:index];
  
    }
    

    for (int i = 0; i < _imageArr.count+2; i++) {
        
        if (_imageArr.count != index) {
            
            if (i == 9) {
                
                [_imageStrArr replaceObjectAtIndex:8 withObject:@""];

            }else if (i > index) {
                
                [_imageStrArr replaceObjectAtIndex:i - 1 withObject:_imageStrArr[i]];
            }
        }
    }
    
    [_OnePublishCollectionV reloadData];
    
    NSLog(@"%@ %@",_imageStrArr,_imageArr);
    
}

//详细信息
- (void)detailedData{
    
    //编辑不改变
    if (_isCopy) {
        
        _isPYQCopy = YES;
    }
    
    NSString *brandStr = [self CreatbrandStr];
    
   //品牌
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:brandStr forKey:@"type"];

    NSLog(@"%@, %@",params,_brandId);
    
    [DataSeviece requestUrl:get_share_brandshtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        [_brandDataArr removeAllObjects];
        
        NSArray * arr = result[@"result"][@"data"][@"item"];
        
        for (int i = 0; i < arr.count; i++) {
            
            NSString *str = [arr[i][@"brands_name"] substringToIndex:1].uppercaseString;
            
            if ([arr[i][@"id"] isEqualToString:_brandId]) {
                
                _brandTextField.text = arr[i][@"brands_name"];
                
                _seriesArr = arr[i][@"series"];
                
            }
            
            if (i == 0 ) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                
                [dic setObject:str forKey:@"title"];
                
                NSMutableArray *array = [NSMutableArray array];
                
                [array addObject:arr[i]];
                
                [dic setObject:array forKey:@"item"];
                
                [_brandDataArr addObject:dic];
                
            }else{
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_brandDataArr lastObject]];
                NSString *str1 = dic[@"title"];
                
                if ([str1.uppercaseString isEqualToString:str]) {
                    
                    NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"item"]];
                    
                    [array addObject:arr[i]];
                    
                    [dic setObject:array forKey:@"item"];
                    
                    [_brandDataArr replaceObjectAtIndex:_brandDataArr.count - 1 withObject:dic];
                }else{
                    
                    NSMutableArray *array = [NSMutableArray array];
                    
                    [array addObject:arr[i]];
                    
                    [dic setObject:array forKey:@"item"];
                    
                    [dic setObject:str forKey:@"title"];
                    
                    [_brandDataArr addObject:dic];
                    
                }
            }
        }
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    //分类
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    [params1 setObject:SYGData[@"id"] forKey:@"uid"];
    [params1 setObject:brandStr forKey:@"type"];
    
    [DataSeviece requestUrl:get_share_categoryhtml params:params1 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSLog(@"%@",_sortId);
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            for (NSDictionary *dic1 in dic[@"child"]) {
                
                if ([dic1[@"id"] isEqualToString:_sortId]) {
                    
                    _sortTextField.text = dic1[@"category_name"];
                    
                    _sortDic = dic1;
                    
                }
            }
        }
        
        if (![_sortTextField.text isEqualToString:@""]) {
            
            [self SPCSAction];
            
        }
        
        [self.tableView reloadData];
        

        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    //微店分类

    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    [params2 setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params2 setObject:@"vdian" forKey:@"type"];
    
    [params2 setObject:@"category" forKey:@"param_name"];
    
    [DataSeviece requestUrl:get_platform_paramhtml params:params2 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        NSArray *idArr = [_WDSortId componentsSeparatedByString:@","];
        
        NSLog(@"%@",idArr);
        
        NSString *WDSortStr = @"";
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            
            for (NSString *str in idArr) {
                
                if ([str integerValue] == [dic[@"cate_id"] integerValue]) {
                    
                    WDSortStr = [NSString stringWithFormat:@"%@,%@",WDSortStr,dic[@"cate_name"]];
                }
            }
            
        }
        
        if (WDSortStr.length != 0) {
            WDSortStr = [WDSortStr substringFromIndex:1];

        }
        
        
        NSLog(@"%@",WDSortStr);
        
        _WDSordTextField.text = WDSortStr;
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    //寄回地址
    
    NSMutableDictionary *params3 = [NSMutableDictionary dictionary];
    
    [params3 setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params3 setObject:@"newshang" forKey:@"type"];
    
    [params3 setObject:@"address" forKey:@"param_name"];
    
    
    [DataSeviece requestUrl:get_platform_paramhtml params:params3 success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        
        for (NSDictionary *dic in result[@"result"][@"data"][@"item"]) {
            
            if ([dic[@"addressId"] integerValue] == [_addressId integerValue]) {
                
                addressDic = dic;
                
                _addressTextField.text = dic[@"city"];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];


    if ([_expectedId isEqualToString:@"1"]) {
        _expectedTextField.text = @"立即";
    }else if ([_expectedId isEqualToString:@"2"]){
        _expectedTextField.text = @"1-3天";
    }else if ([_expectedId isEqualToString:@"3"]){
        _expectedTextField.text = @"3-5天";
    }else if ([_expectedId isEqualToString:@"4"]){
        _expectedTextField.text = @"5-10天";
    }else if ([_expectedId isEqualToString:@"5"]){
        _expectedTextField.text = @"10天以上";
    }
    
    if ([_gradeId isEqualToString:@"1"]) {
        _gradeTextField.text = @"全新(未使用)";
    }else if ([_gradeId isEqualToString:@"2"]){
        _gradeTextField.text = @"98成新(未使用，成列品)";
    }else if ([_gradeId isEqualToString:@"3"]){
        _gradeTextField.text = @"95成新(几乎未使用)";
    }else if ([_gradeId isEqualToString:@"4"]){
        _gradeTextField.text = @"9成新(偶尔使用)";
    }else if ([_gradeId isEqualToString:@"5"]){
        _gradeTextField.text = @"85成新(正常使用) ";
    }else if ([_gradeId isEqualToString:@"6"]){
        _gradeTextField.text = @"8成新(长期使用)";
    }else if ([_gradeId isEqualToString:@""]){
    
        _gradeId = @"1";
        
        _gradeTextField.text = @"全新(未使用)";
    }
    
    [DataSeviece requestUrl:get_shop_settinghtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        
        if ([result[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {
            
            if ([result[@"result"][@"data"][@"show_agency_price"] integerValue] == 1) {
                
                isDL = YES;
                
            }else{
                
                isDL = NO;
            }
            [self.tableView reloadData];

        }
        

    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    [self.tableView reloadData];
    
}

- (NSString *)CreatbrandStr{
    
    
    NSString *brandStr = @"";
    
    if (_PHImageV.hidden == NO) {
        brandStr = @"ponhu";
    }
    
    if (_ADMImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            brandStr = @"aidingmao";
        }else{
            brandStr = [NSString stringWithFormat:@"%@,aidingmao",brandStr];
        }
    }
    
    
    if (_XSImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"newshang";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,newshang",brandStr];
            
        }
    }
    if (_SPImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"shopuu";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,shopuu",brandStr];
            
        }
    }
    
    if (_ZDImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"xiaohongshu";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,xiaohongshu",brandStr];
            
        }
    }
    
    if (_ADMZYImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"aidingmao";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,aidingmao",brandStr];
            
        }
    }
    
    if (_ADMSJImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"aidingmao";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,aidingmao",brandStr];
            
        }
    }
    
    if (_JAImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"jiuai";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,jiuai",brandStr];
            
        }
    }
    
    if (_LPHImageV.hidden == NO) {
        
        if ([brandStr isEqualToString:@""]) {
            
            brandStr = @"liequ";
            
        }else{
            
            brandStr = [NSString stringWithFormat:@"%@,liequ",brandStr];
            
        }
    }
    
    return brandStr;
    
}

//显示图片
- (void)showImage{
    
    NSArray *imageArr = _recordDic[@"img"];
    
    __block NSInteger item = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *serviceData = [defaults objectForKey:@"ServiceData"];
    
    NSString *imgUrl_API = serviceData[@"imgUrl_API"];
    
    

    
    if (_isOnePush) {
        
        NSMutableArray *urlArr = [NSMutableArray array];
        
        for (NSString *str in imageArr) {
            
            if (![str isEqualToString:@""]) {
                
                [urlArr addObject:str];
            }
            
        }
        NSLog(@"%@",urlArr);
        
        for (int i = 0 ; i < urlArr.count; i++) {
            
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl_API,urlArr[i]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"");
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                item++;
                
                if (item == urlArr.count) {
                    
                    for (int i = 0 ; i < urlArr.count; i++) {
                        
                        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imgUrl_API,urlArr[i]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            NSLog(@"");
                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                            if (error) {
                                
                            }
                            if (image) {
                                
                                NSLog(@"%d %@",i,imageArr[i]);
                                
                                [_imageArr addObject:image];
                                
                                [_imageStrArr replaceObjectAtIndex:i withObject:urlArr[i]];
                                
                                [_collectArr replaceObjectAtIndex:i withObject:@"1"];
                                
                            }
                            
                            NSLog(@"%@",_imageStrArr);
                            
                            [_OnePublishCollectionV reloadData];
                            
                        }];
                    }
                }
            }];
        }
        
    }else{
        
        
        for (int i = 0 ; i < imageArr.count; i++) {
            
            NSLog(@"%@",imageArr[i]);
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageArr[i][@"image_url"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"");
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                item++;
                
                if (item == imageArr.count) {
                    
                    for (int i = 0 ; i < imageArr.count; i++) {
                        
                        NSLog(@"%@",imageArr[i]);
                        
                        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageArr[i][@"image_url"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            NSLog(@"");
                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            item++;
                            
                            if (error) {
                                
                            }
                            if (image) {
                                
                                [_imageArr addObject:image];
                                
                                [_collectArr replaceObjectAtIndex:i withObject:@"1"];
                                
                                [_imageStrArr replaceObjectAtIndex:i withObject:imageArr[i][@"url"]];
                                
//                                if ([BaseUrl isEqualToString:@"http://syg.hpdengshi.com/index.php?s=/Api/"]) {
//                                    
//                                    NSLog(@"%@",imageArr[i][@"image_url"]);
//                                    
//                                }else{
//                                    
//                                    [_imageStrArr replaceObjectAtIndex:i withObject:[imageArr[i][@"image_url"] substringFromIndex:24]];
//                                }
//                                [_imageStrArr replaceObjectAtIndex:i withObject:[imageArr[i][@"url"] substringFromIndex:imgUrl.length]];
                                
                            }
                            
                            NSLog(@"%@",_imageStrArr);
                            
                            [_OnePublishCollectionV reloadData];
                            
                        }];
                    }
                    [_OnePublishCollectionV reloadData];
                }
                
            }];
        }
    }
    
}

//朋友圈文字
- (NSString*)creatFriendText{
    
    NSString *SPMSStr = @"";
    
    if ([_sortDic[@"pid"] isEqualToString:@"129"]) {
        
        if (![_ZLTF.text isEqualToString:@""]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ %@ct",SPMSStr,_ZLTF.text];
        }
        
        SPMSStr  = [NSString stringWithFormat:@"%@ %@",SPMSStr,_sortTextField.text];

        if (_gemArr2.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 色浓度%@",SPMSStr,_gemArr2[0][@"name"]];
        }
        
        if (_gemArr3.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 颜色%@",SPMSStr,_YSTF.text];
            
        }

        if (_gemArr4.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 净度%@",SPMSStr,_gemArr4[0][@"name"]];
            
        }

        if (_gemArr5.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 切工%@",SPMSStr,_gemArr5[0][@"name"]];
            
        }

        if (_gemArr6.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 抛光%@",SPMSStr,_gemArr6[0][@"name"]];
            
        }

        if (_gemArr7.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 对称性%@",SPMSStr,_gemArr7[0][@"name"]];
            
        }

        if (_gemArr8.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ 荧光性%@",SPMSStr,_gemArr8[0][@"name"]];
            
        }
        
        if (![_attachmentTextField.text isEqualToString:@""]) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dic in _attachmentArr) {
                
                [array addObject:dic[@"name"]];
            }
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  有%@",SPMSStr,[array componentsJoinedByString:@"有"]];
        }
        
        if ([_publicPriceTextField.text integerValue] != 0) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰公价:%ld",SPMSStr,[_publicPriceTextField.text integerValue]];
        }
        if ([_priceTextField.text integerValue] != 0) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰售价:%ld",SPMSStr,[_priceTextField.text integerValue]];
        }
        

    }else if ([_sortDic[@"pid"] isEqualToString:@"22"]&&_gemArr1.count != 0){
    
        if (![_brandTextField.text isEqualToString:@""]) {
            SPMSStr  = [NSString stringWithFormat:@"%@ %@",SPMSStr,_brandTextField.text];
        }
        
        if (![_materialTextField.text isEqualToString:@""]) {
         
            SPMSStr  = [NSString stringWithFormat:@"%@ %@",SPMSStr,_materialTextField.text];

        }
        
        if (_gemArr1.count != 0) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ %@",SPMSStr,_gemArr1[0][@"name"]];
            
        }
        
        if (![_sortTextField.text isEqualToString:@""]) {
            SPMSStr  = [NSString stringWithFormat:@"%@ %@",SPMSStr,_sortTextField.text];
        }

        if (![_bagsizeTextField.text isEqualToString:@""]) {
            SPMSStr  = [NSString stringWithFormat:@"%@,%@",SPMSStr,_bagsizeTextField.text];
        }
        
        if (![_ZLTF.text isEqualToString:@""]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@ %@ct",SPMSStr,_ZLTF.text];
        }
        
        if (![_gradeTextField.text isEqualToString:@""]) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  成色:%@",SPMSStr,_gradeTextField.text];
        }
    
        if ([_publicPriceTextField.text integerValue] != 0) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰公价:%ld",SPMSStr,[_publicPriceTextField.text integerValue]];
        }
        if ([_priceTextField.text integerValue] != 0) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰售价:%ld",SPMSStr,[_priceTextField.text integerValue]];
        }

    }else{
    
    
    if (![_brandTextField.text isEqualToString:@""]) {
        SPMSStr  = [NSString stringWithFormat:@"%@,  %@%@",SPMSStr,_brandTextField.text,_sortDic[@"category_name"]];
    }
    
    if (![_seriesTextField.text isEqualToString:@""]) {
        SPMSStr  = [NSString stringWithFormat:@"%@,  %@系列",SPMSStr,_seriesTextField.text];
    }
    if (![_modelTextField.text isEqualToString:@""]) {
        SPMSStr  = [NSString stringWithFormat:@"%@,  型号:%@",SPMSStr,_modelTextField.text];
    }
    if (![_bagsizeTextField.text isEqualToString:@""]||![_size_yTextField.text isEqualToString:@""]||![_size_zTextField.text isEqualToString:@""]) {
        
        
        if ([_sortDic[@"pid"] isEqualToString:@"30"]) {
            
            if (![_bagsizeTextField.text isEqualToString:@""]&&![_size_yTextField.text isEqualToString:@""]) {
                
                SPMSStr  = [NSString stringWithFormat:@"%@,  表径:%@mm*%@mm",SPMSStr,_bagsizeTextField.text,_size_yTextField.text];
                
            }else if (![_bagsizeTextField.text isEqualToString:@""]){
                
                SPMSStr  = [NSString stringWithFormat:@"%@,  表径:%@mm",SPMSStr,_bagsizeTextField.text];
                
            }else{
                
                SPMSStr  = [NSString stringWithFormat:@"%@,  表径:%@mm",SPMSStr,_size_yTextField.text];
            }
            
        }else if ([_sortDic[@"pid"] isEqualToString:@"1"]) {
            
            NSString *str = @"";
            
            if (![_bagsizeTextField.text isEqualToString:@""]) {
                
                str = [NSString stringWithFormat:@"%@*%@cm",str,_bagsizeTextField.text];
            }
            
            if (![_size_yTextField.text isEqualToString:@""]) {
                
                str = [NSString stringWithFormat:@"%@*%@cm",str,_size_yTextField.text];
                
            }
            
            if (![_size_zTextField.text isEqualToString:@""]) {
                
                str = [NSString stringWithFormat:@"%@*%@cm",str,_size_zTextField.text];
                
            }
            str = [str substringFromIndex:1];
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  尺寸:%@",SPMSStr,str];
            
            
        }else{
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  尺寸:%@",SPMSStr,_bagsizeTextField.text];
        }
        
    }
        
        if (![_materialTextField.text isEqualToString:@""]) {
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  材质:%@",SPMSStr,_materialTextField.text];
        }
        
        
        if (![_functionTextField.text isEqualToString:@""]) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dic in _functionArr) {
                
                [array addObject:dic[@"name"]];
            }
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  功能:%@⌚️",SPMSStr,[array componentsJoinedByString:@"、"]];
        }
        
        if (![_gradeTextField.text isEqualToString:@""]) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  新旧:%@",SPMSStr,_gradeTextField.text];
        }
        
        if (![_attachmentTextField.text isEqualToString:@""]) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dic in _attachmentArr) {
                
                [array addObject:dic[@"name"]];
            }
            
            SPMSStr  = [NSString stringWithFormat:@"%@,  有%@",SPMSStr,[array componentsJoinedByString:@"有"]];
            
        }
        
        
        if ([_publicPriceTextField.text integerValue] != 0) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰公价:%ld",SPMSStr,[_publicPriceTextField.text integerValue]];
        }
        if ([_priceTextField.text integerValue] != 0) {
            SPMSStr  = [NSString stringWithFormat:@"%@,  💰售价:%ld",SPMSStr,[_priceTextField.text integerValue]];
        }

        if (SPMSStr.length > 3) {
            
            SPMSStr =  [SPMSStr substringFromIndex:3];
            
        }
        
    }
    
    return SPMSStr;
    
}


- (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageCopy;
    
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
