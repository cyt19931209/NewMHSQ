//
//  TheTemplateSelectionViewController.m
//  奢易购3.0
//
//  Created by CYT on 2017/1/17.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "TheTemplateSelectionViewController.h"
#import "GeneratedPuzzlesViewController.h"

@interface TheTemplateSelectionViewController (){

    UIView *bgView;
    UIView *addView;
    
    UIView *selectTextView;
    
    UIButton *selectTextButton;

}


@property (nonatomic,strong) UIButton *selectButton;

@end

@implementation TheTemplateSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];

    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
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
    
    
    UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64)];
    
    bgView1.backgroundColor = [RGBColor colorWithHexString:@"#000000"];
    
    [self.view addSubview:bgView1];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(((kScreenWidth - 36)/3 + 8)*(i%3) + 10, i/3 * kScreenWidth/3 + 10, (kScreenWidth - 36)/3, (kScreenWidth - 36)/3);
        
        button.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
        
        button.layer.cornerRadius = 4;
        
        button.layer.masksToBounds = YES;
        
        button.tag = 100+ i;
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView1 addSubview:button];
        
        
        if (i == 3) {
            
            button.top = button.top + 34;
            
        }
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, (kScreenWidth - 36)/3 - 20, (kScreenWidth - 36)/3 -20)];
        
        [button addSubview:imageV];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(((kScreenWidth - 36)/3 + 8)*(i%3) + 10, (kScreenWidth - 36)/3+i/3 * kScreenWidth/3 + 20, (kScreenWidth - 36)/3, 15)];
        
        label.font = [UIFont systemFontOfSize:12];
        
        label.textColor = [RGBColor colorWithHexString:@"#ffffff"];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [bgView1 addSubview:label];


        if (i == 0) {
            
            label.text = @"简约版(无文案)";
            
            imageV.image = [UIImage imageNamed:@"简约.jpg"];
            
        }else if (i == 1) {
            
            UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 36)/3 - 38, 0, 38, 39)];
            
            imageV1.image = [UIImage imageNamed:@"标签.png"];
            
            imageV1.tag = 110;
            
            [button addSubview:imageV1];
            
            button.selected = YES;
            _selectButton = button;
            label.text = @"新春版1";
            imageV.image = [UIImage imageNamed:@"新春1.jpg"];


        }else if (i == 2){
            label.text = @"全球版";
            imageV.image = [UIImage imageNamed:@"全球.jpg"];

        
        }else if (i == 3){
            
            label.top = label.top + 34;
            label.text = @"新春版2";

            imageV.image = [UIImage imageNamed:@"新春2.jpg"];

        }

        
    }
    
    
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

    //文案
    
    addView = [[UIView alloc]initWithFrame:CGRectMake(20, kScreenHeight/2 - 90, kScreenWidth - 40, 180)];
    
    addView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    
    addView.layer.cornerRadius = 4;
    
    addView.layer.masksToBounds = YES;
    
    addView.hidden = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:addView];
    
    
    UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    delectButton.frame = CGRectMake(addView.width - 30, 5, 27, 27);
    
    [delectButton setImage:[UIImage imageNamed:@"wr1"] forState:UIControlStateNormal];
    
    
    [delectButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:delectButton];
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, addView.width, 16)];
    textLabel.text = @"请选择拼图显示文案";
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    textLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    textLabel.font = [UIFont systemFontOfSize:14];
    
    [addView addSubview:textLabel];
    
    selectTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    selectTextButton.frame = CGRectMake(20, 74, kScreenWidth - 80, 34);
    
    
    selectTextButton.layer.cornerRadius = 4;
    
    selectTextButton.layer.masksToBounds = YES;
    
    selectTextButton.layer.borderWidth = 1;
    
    selectTextButton.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
    
    
    [selectTextButton setTitle:@"现货滚动~" forState:UIControlStateNormal];
    
    [selectTextButton setTitleColor:[RGBColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    selectTextButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [selectTextButton addTarget:self action:@selector(selectTextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:selectTextButton];
    
    
    UIImageView *XLImageV = [[UIImageView alloc]initWithFrame:CGRectMake(selectTextButton.width - 17, 11, 12, 12)];
    
    XLImageV.tag = 100;
    
    XLImageV.image = [UIImage imageNamed:@"xiala"];
    
    [selectTextButton addSubview:XLImageV];
    
    
    UIButton *tureButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton1.frame = CGRectMake(0, 138, kScreenWidth - 40, 20);
    
    [tureButton1 setTitle:@"确定" forState:UIControlStateNormal];
    
    [tureButton1 setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    tureButton1.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [tureButton1 addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [addView addSubview:tureButton1];


    selectTextView = [[UIView alloc]initWithFrame:CGRectMake(selectTextButton.left + 20, addView.top + selectTextButton.bottom, selectTextButton.width, selectTextButton.height * 4)];
    
    selectTextView.hidden = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:selectTextView];
    
    NSArray *textArr = @[@"现货滚动|好价详询",@"现货滚动~",@"预售滚动|好价询~",@"特价优惠|好价详询"];
    

    for (int i = 0 ; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(0, 34 * i, selectTextView.width, 34);
        
        button.layer.cornerRadius = 4;
        
        button.layer.masksToBounds = YES;
        
        button.layer.borderWidth = 1;
        
        button.layer.borderColor = [RGBColor colorWithHexString:@"d9d9d9"].CGColor;
        
        button.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
        
        [button setTitle:textArr[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[RGBColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        
        button.tag = 300 + i;
        
        [button addTarget:self action:@selector(selectTextViewAction:) forControlEvents:UIControlEventTouchUpInside];

        
        [selectTextView addSubview:button];
    
    }

}
//选择文案
- (void)selectTextViewAction:(UIButton*)bt{

    selectTextView.hidden = YES;

    selectTextButton.selected = NO;
    
    UIImageView *XLimageV = [selectTextButton viewWithTag:100];

    XLimageV.image = [UIImage imageNamed:@"xiala"];

    
    NSArray *textArr = @[@"现货滚动|好价详询",@"现货滚动~",@"预售滚动|好价询~",@"特价优惠|好价详询"];

    [selectTextButton setTitle:textArr[bt.tag - 300] forState:UIControlStateNormal];
    

}


//显示文案选择
- (void)selectTextButtonAction{

    selectTextButton.selected = ! selectTextButton.selected;
    
    UIImageView *XLimageV = [selectTextButton viewWithTag:100];
    
    if (selectTextButton.selected) {
        
        selectTextView.hidden = NO;
        XLimageV.image = [UIImage imageNamed:@"jtup"];
        
    }else{
        
        selectTextView.hidden = YES;
        
        XLimageV.image = [UIImage imageNamed:@"xiala"];
        
    }
    
    

}
//确定
- (void)addAction{
    
    bgView.hidden = YES;
    
    addView.hidden = YES;
    
    selectTextView.hidden = YES;

    
    GeneratedPuzzlesViewController *GeneratedPuzzlesVC = [[GeneratedPuzzlesViewController alloc]init];
    
    GeneratedPuzzlesVC.selectArr = [_selectArr copy];
    
    GeneratedPuzzlesVC.typeStr = [NSString stringWithFormat:@"%ld",_selectButton.tag - 100];
    
    GeneratedPuzzlesVC.textStr = selectTextButton.titleLabel.text;
    NSArray *textArr = @[@"现货滚动|好价详询",@"现货滚动~",@"预售滚动|好价询~",@"特价优惠|好价详询"];

    if ([selectTextButton.titleLabel.text isEqualToString:textArr[0]]) {

        GeneratedPuzzlesVC.EnglishStr = @"Spot rolling, with good price ~";

    }else if ([selectTextButton.titleLabel.text isEqualToString:textArr[1]]){
        GeneratedPuzzlesVC.EnglishStr = @"Spot rolling ~~";

    }else if ([selectTextButton.titleLabel.text isEqualToString:textArr[2]]){
        GeneratedPuzzlesVC.EnglishStr = @"Open to booking a scroll, with good price ~";

    }else if ([selectTextButton.titleLabel.text isEqualToString:textArr[3]]){
        GeneratedPuzzlesVC.EnglishStr = @"Special offers and good price for enquiry";

    }
    
    
    
    [self.navigationController pushViewController:GeneratedPuzzlesVC animated:YES];
    
    


}

- (void)bgButtonAction{

    bgView.hidden = YES;
    
    addView.hidden = YES;

    selectTextView.hidden = YES;
}

//
- (void)buttonAction:(UIButton*)bt{

    
    if (bt != _selectButton) {
        
        bt.selected =!bt.selected;

        UIImageView *imageV = [_selectButton viewWithTag:110];
        
        _selectButton.selected = NO;
        
        _selectButton = bt;
        
        [_selectButton addSubview:imageV];
        
    }
    
    
    
}


- (void)tureButtonAction{
    
    
    if (_selectButton.tag == 100) {
        
        GeneratedPuzzlesViewController *GeneratedPuzzlesVC = [[GeneratedPuzzlesViewController alloc]init];
        
        GeneratedPuzzlesVC.selectArr = [_selectArr copy];
        
        GeneratedPuzzlesVC.typeStr = @"0";
        
        
        [self.navigationController pushViewController:GeneratedPuzzlesVC animated:YES];
        

        
    }else{
    

        bgView.hidden = NO;
        
        addView.hidden = NO;
        
        
    }
    
    
}

//返回
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"模板选择";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#949dff"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}



@end
