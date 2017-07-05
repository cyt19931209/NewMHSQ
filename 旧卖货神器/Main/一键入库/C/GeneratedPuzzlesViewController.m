//
//  GeneratedPuzzlesViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "GeneratedPuzzlesViewController.h"
#import "MBProgressHUD.h"
#import "SharedItem.h"

@interface GeneratedPuzzlesViewController ()<UIScrollViewDelegate,UIActionSheetDelegate>{

    UIScrollView *scrollView;
    
    UIImageView *photoImageView;
    
    
    UIImage *watermarkImage;

}

@end

@implementation GeneratedPuzzlesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSLog(@"%@ %@",_textStr,_typeStr);
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];

    
    watermarkImage = [self watermarkImage];

    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"Back Chevron@2x"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    //右边Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitle:@"保存本地" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(SaveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    
    scrollView.delegate = self;
    scrollView.backgroundColor = [RGBColor colorWithHexString:@"#4d4d4d"];
    
    scrollView.maximumZoomScale=2;
    //
    scrollView.minimumZoomScale=1;
    
    //        创建双击手势
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    
    //点击几次
    tap.numberOfTapsRequired=2;
    //        手指个数
    tap.numberOfTouchesRequired=1;
    
    scrollView.showsHorizontalScrollIndicator=NO;
    
    scrollView.showsVerticalScrollIndicator=NO;
    
    [scrollView addGestureRecognizer:tap];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [scrollView addGestureRecognizer:longPress];

    

    [self.view addSubview:scrollView];
    
    photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35, 0, 0, 0)];
    
    

    [scrollView addSubview:photoImageView];
    
    
    NSMutableArray *urlStr = [NSMutableArray array];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (NSDictionary *dic1 in _selectArr) {
        
        NSArray *imgArr = dic1[@"img"];

        if (imgArr.count != 0) {
            [urlStr addObject:imgArr[0][@"orign_url"]];
        }
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
                            
                            image = [self cutImage:image];
                            
                            [imageArr replaceObjectAtIndex:j withObject:image];
                            
                            if (item2 == urlStr.count) {
                                
                                
                                if ([_typeStr isEqualToString:@"0"]) {
                                    photoImageView.image =  [self combineImage1:imageArr];

                                }else if ([_typeStr isEqualToString:@"1"]){
                                    photoImageView.image =  [self combineImage:imageArr];

                                }else if ([_typeStr isEqualToString:@"2"]){
                                    photoImageView.image =  [self combineImage2:imageArr];

                                }else if ([_typeStr isEqualToString:@"3"]){
                                    photoImageView.image =  [self combineImage3:imageArr];

                                }
                                
                            }
                        }
                    }];
                }
            }
        }];
    }
    
    UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [tureButton setTitle:@"确定发布" forState:UIControlStateNormal];
    
    [tureButton setTitleColor:[RGBColor colorWithHexString:@"#949dff"] forState:UIControlStateNormal];
    
    tureButton.frame = CGRectMake(kScreenWidth - 92, kScreenHeight - 38 - 64, 82, 28);
    
    tureButton.layer.cornerRadius = 4;
    
    tureButton.layer.masksToBounds = YES;
    
    tureButton.layer.borderWidth = 1;
    
    tureButton.layer.borderColor = [RGBColor colorWithHexString:@"#949dff"].CGColor;
    
    [tureButton addTarget:self action:@selector(tureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tureButton];
    
    
}

//保存图片
- (void)SaveAction{

    UIImageWriteToSavedPhotosAlbum(photoImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

//确定发布
- (void)tureButtonAction{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    
    UIImage *imagerang = photoImageView.image;
    
    //        imagerang = [self scaleFromImage:imagerang scaledToSize:CGSizeMake(500, 500)];
    
    //        printf("%lf %lf",imagerang.size.width,imagerang.size.height);
    NSLog(@"%lf %lf",imagerang.size.width,imagerang.size.height);
    
    NSString *path_sandox = NSHomeDirectory();
    
    NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/ShareWX%d.jpg",0]];
    [UIImagePNGRepresentation(imagerang) writeToFile:imagePath atomically:YES];
    
    NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
    
    /** 这里做个解释 imagerang : UIimage 对象  shareobj:NSURL 对象 这个方法的实际作用就是 在吊起微信的分享的时候 传递给他 UIimage对象,在分享的时候 实际传递的是 NSURL对象 达到我们分享九宫格的目的 */
    
    SharedItem *item = [[SharedItem alloc] initWithData:imagerang andFile:shareobj];
    
    [array addObject:item];
    
    NSLog(@"%@",array);
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:array
                                                                                        applicationActivities:nil];
    
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypeAirDrop];
    
    [self presentViewController:activityViewController animated:TRUE completion:nil];
    

}

// 图片保存完成
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertV show];
    
}


#pragma mark - 视图长按手势
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    NSLog(@"长按");
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil,nil];
        [sheet showInView:photoImageView];
    }
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(photoImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}




//水印图
- (UIImage*)watermarkImage{
    
    CGSize offScreenSize = CGSizeMake(690,30);

    UIGraphicsBeginImageContext(offScreenSize);
    
    
    CGRect rect3 = CGRectMake(0, 0, 138,30);
    
    [[UIImage imageNamed:@"sk2(1)"] drawInRect:rect3];

    CGRect rect1 = CGRectMake(168, 0, 45,30);
    
    [[UIImage imageNamed:@"lg2(1)"] drawInRect:rect1];

    CGRect rect2 = CGRectMake(552, 0, 138,30);
    
    [[UIImage imageNamed:@"sk1(1)"] drawInRect:rect2];

    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSDictionary *attr = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:30],  //设置字体
                           
                           NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#949dff"]   //设置字体颜色
                           };
    
    [dateString drawInRect:CGRectMake(228, 0, 300, 30) withAttributes:attr];
    
    

    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    
    rotate = M_PI_2;
    rect = CGRectMake(0, 0, imagez.size.height, imagez.size.width);
    translateX = 0;
    translateY = -rect.size.width;
    scaleY = rect.size.width/rect.size.height;
    scaleX = rect.size.height/rect.size.width;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), imagez.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
    
    
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    //裁剪图片
    CGSize newSize;
    
    CGImageRef imageRef = nil;
    
    
    if (image.size.width > image.size.height) {
        
        newSize = CGSizeMake(image.size.height, image.size.height);

        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake((image.size.width - image.size.height)/2, 0, newSize.width, newSize.height));

    }else{
    
        newSize = CGSizeMake(image.size.width, image.size.width);

        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, (image.size.height - image.size.width)/2, newSize.width, newSize.height));
        
    }
    
    
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    UIGraphicsBeginImageContext(CGSizeMake(462, 462));

                                
    [newImage drawInRect:CGRectMake(0, 0, 462, 462)];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    newImage = [self imageWithRoundedCornersSize:12 usingImage:newImage];
    
    return newImage;
    
}

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original
{
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // Draw your image
    [original drawInRect:frame];
    // Retrieve and return the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}



//新春版1
- (UIImage*)combineImage:(NSArray*)imageArr{

    NSInteger index = imageArr.count/3;
    
    if (imageArr.count%3 != 0 ) {
        
        index = index + 1 ;
        
    }
    
    CGSize offScreenSize = CGSizeMake(1125,365 * index + 738);

    scrollView.contentSize = CGSizeMake(kScreenWidth - 70,(335 * index + 738) * (kScreenWidth - 70)/335 / 3);
    
    photoImageView.width = kScreenWidth - 70;
    
    photoImageView.height = (335 * index + 738) * (kScreenWidth - 70)/335 / 3;
    
    
    if (photoImageView.height < kScreenHeight - 64 - 49) {
        
        photoImageView.top = (kScreenHeight - 64 - 49 - ((335 * index + 738) * (kScreenWidth - 70)/335 / 3))/2 ;
    }
    
    
    
    
    UIGraphicsBeginImageContext(offScreenSize);

//    CGRect rect = CGRectMake(0, 0, 1125,335 * index + 738);
    
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [RGBColor colorWithHexString:@"E12031"].CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, 1125, 365 * index + 738));//用这个颜色填充这个上下文

    
    
    for (int i = 0; i < imageArr.count; i++) {
        
        CGRect rect = CGRectMake(30 + (i%3*365), (i/3*365) + 393, 335,335);
        
        [imageArr[i] drawInRect:rect];
        
    }
    
    
    [[UIImage imageNamed:@"5863adb531094"] drawInRect:CGRectMake(0, 0, 1125, 695)];


    
    [[UIImage imageNamed:@"形状-1"] drawInRect:CGRectMake(1125 - 30 - 71,365 * index + 738 - 30 - 46 , 71, 46)];

 
    NSString *textStr1 = _textStr;
    
    NSDictionary *attr1 = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:48],  //设置字体
                           NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#f2b743"]   //设置字体颜色
                           };
    
    CGRect rect = [_textStr boundingRectWithSize:CGSizeMake(1000, 48) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr1 context:nil];
    
    NSLog(@"%lf",rect.size.width);
    
    [textStr1 drawInRect:CGRectMake((1125 - rect.size.width)/2,365 * index + 738 - 251 - 55, rect.size.width + 100, 50) withAttributes:attr1];
    
    NSString *textStr2 = @"HAPPY CHINESE";
    
    NSDictionary *attr2 = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:39],  //设置字体
                           NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#f2b743"]   //设置字体颜色
                           };
    
    [textStr2 drawInRect:CGRectMake(415,365 * index + 738 - 199 - 40, 359, 40) withAttributes:attr2];
    
    NSString *textStr3 = @"NEW YEAR";
    NSDictionary *attr3 = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:39],  //设置字体
                           NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#f2b743"]   //设置字体颜色
                           };
    
    [textStr3 drawInRect:CGRectMake(480,365 * index + 738 - 145 - 40, 230, 40) withAttributes:attr3];
    
    NSString *textStr4 = @"2017";
    NSDictionary *attr4 = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:59],  //设置字体
                           NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#fffbff"]   //设置字体颜色
                           };
    
    [textStr4 drawInRect:CGRectMake(520,365 * index + 738 - 59 - 61, 137, 61) withAttributes:attr4];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();

    
    UIGraphicsEndImageContext();

    return imagez;
    
}

//全球版
- (UIImage*)combineImage2:(NSArray*)imageArr{
    
    NSInteger index = imageArr.count/3;
    
    if (imageArr.count%3 != 0 ) {
        
        index = index + 1 ;
        
    }
    
    CGSize offScreenSize = CGSizeMake(1125,365 * index + 520);
    
    scrollView.contentSize = CGSizeMake(kScreenWidth - 70,(335 * index + 520) * (kScreenWidth - 70)/335 / 3);
    
    photoImageView.width = kScreenWidth - 70;
    
    photoImageView.height = (335 * index + 520) * (kScreenWidth - 70)/335 / 3;
    
    if (photoImageView.height < kScreenHeight - 64 - 49) {
        
        photoImageView.top = (kScreenHeight - 64 - 49 - ((335 * index + 738) * (kScreenWidth - 70)/335 / 3))/2 ;
    }

    
    UIGraphicsBeginImageContext(offScreenSize);
    
    //    CGRect rect = CGRectMake(0, 0, 1125,335 * index + 738);
    
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [RGBColor colorWithHexString:@"#110021"].CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, 1125, 365 * index + 520));//用这个颜色填充这个上下文
    
    
    for (int i = 0; i < imageArr.count; i++) {
        
        CGRect rect = CGRectMake(30 + (i%3*365), (i/3*365) + 393, 335,335);
        
        [imageArr[i] drawInRect:rect];
        
    }
    
    
    [[UIImage imageNamed:@"组-4"] drawInRect:CGRectMake(0, 0, 1125, 432)];
    
    
    [[UIImage imageNamed:@"形状-2"] drawInRect:CGRectMake(1125 - 30 - 71,365 * index + 520 - 30 - 46 , 71, 46)];
    
    
    NSString *textStr1 = _textStr;
    
    NSDictionary *attr1 = @{
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:52],  //设置字体
                            NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#ecc782"]   //设置字体颜色
                            };
    
    CGRect rect = [_textStr boundingRectWithSize:CGSizeMake(1000, 52) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr1 context:nil];
    
//
    [textStr1 drawInRect:CGRectMake(1125 - rect.size.width - 100,120, rect.size.width , 55) withAttributes:attr1];

    NSString *textStr2 = _EnglishStr;
    
    NSDictionary *attr2 = @{
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:24],  //设置字体
                            NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#ecc782"]   //设置字体颜色
                            };
    
    CGRect rect1 = [textStr2 boundingRectWithSize:CGSizeMake(1000, 24) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr2 context:nil];

    NSLog(@"%@ %lf",_EnglishStr,rect1.size.width);

    [textStr2 drawInRect:CGRectMake(1125 - rect1.size.width - 80,190, rect1.size.width, 30) withAttributes:attr2];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return imagez;
    
}

//新春版2
- (UIImage*)combineImage3:(NSArray*)imageArr{
    
    NSInteger index = imageArr.count/3;
    
    if (imageArr.count%3 != 0 ) {
        
        index = index + 1 ;
        
    }
    
    CGSize offScreenSize = CGSizeMake(1125,365 * index + 738);
    
    scrollView.contentSize = CGSizeMake(kScreenWidth - 70,(335 * index + 738) * (kScreenWidth - 70)/335 / 3);
    
    photoImageView.width = kScreenWidth - 70;
    
    photoImageView.height = (335 * index + 738) * (kScreenWidth - 70)/335 / 3;
    
    if (photoImageView.height < kScreenHeight - 64 - 49) {
        
        photoImageView.top = (kScreenHeight - 64 - 49 - ((335 * index + 738) * (kScreenWidth - 70)/335 / 3))/2 ;
    }
    
    UIGraphicsBeginImageContext(offScreenSize);
    
    //    CGRect rect = CGRectMake(0, 0, 1125,335 * index + 738);
    
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [RGBColor colorWithHexString:@"CEA275"].CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, 1125, 365 * index + 738));//用这个颜色填充这个上下文
    
    [[UIImage imageNamed:@"Group 6"] drawInRect:CGRectMake(0, 0, 1125, 1628)];

    
    for (int i = 0; i < imageArr.count; i++) {
        
        CGRect rect = CGRectMake(30 + (i%3*365), (i/3*365) + 520, 335,335);
        
        [imageArr[i] drawInRect:rect];
        
    }
    
    
    
    
    
    [[UIImage imageNamed:@"形状-3"] drawInRect:CGRectMake(1125 - 30 - 71,365 * index + 738 - 30 - 46 , 71, 46)];
    
    
    NSString *textStr1 = _textStr;
    
    NSDictionary *attr1 = @{
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:52],  //设置字体
                            NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#FFF0D6"]   //设置字体颜色
                            };
    
    CGRect rect = [_textStr boundingRectWithSize:CGSizeMake(1000, 51) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr1 context:nil];
    
    NSLog(@"%lf",rect.size.width);
    
    [textStr1 drawInRect:CGRectMake((1125 - rect.size.width)/2,365 * index + 738 - 50 - 120, rect.size.width , 55) withAttributes:attr1];
    
    NSString *textStr2 = _EnglishStr;
    
    NSDictionary *attr2 = @{
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:24],  //设置字体
                            NSForegroundColorAttributeName : [RGBColor colorWithHexString:@"#FFF0D6"]   //设置字体颜色
                            };
    
    CGRect rect1 = [_EnglishStr boundingRectWithSize:CGSizeMake(1000, 24) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr2 context:nil];
    
    
    [textStr2 drawInRect:CGRectMake((1125 - rect1.size.width)/2,365 * index + 738 - 100, rect1.size.width, 30) withAttributes:attr2];

    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return imagez;
    
}

//简约版
- (UIImage*)combineImage1:(NSArray*)imageArr{
    
    NSInteger index = imageArr.count/2;
    
    if (imageArr.count%2 != 0 ) {
        
        index = index + 1 ;
        
    }
    
    CGSize offScreenSize = CGSizeMake(375 * 3,477 * index + 60);
    
    scrollView.contentSize = CGSizeMake(kScreenWidth - 70,(477 * index + 60) * (kScreenWidth - 70)/375 / 3);
    
    photoImageView.width = kScreenWidth - 70;
    
    photoImageView.height = (477 * index + 60) * (kScreenWidth - 70)/375 / 3;
    
    
    
    
    UIGraphicsBeginImageContext(offScreenSize);
    
    CGRect rect = CGRectMake(0, 0, 375 * 3,477 * index + 60);
    
    [[UIImage imageNamed:@"navbar@2x"] drawInRect:rect];
    
    for (int i = 0; i < imageArr.count; i++) {
        
        CGRect rect = CGRectMake(135 + (i%2*477), (i/2*477) + 38, 462,462);
        
        [imageArr[i] drawInRect:rect];
        
    }
    
    CGRect rect1 = CGRectMake(60, 0, 30,690);
    
    [watermarkImage drawInRect:rect1];
    
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    
    return imagez;
    
}




-(void)tapAction{
    
    //    通过三目运算符来判断当前缩放比例
    float scale=scrollView.zoomScale>1?1:2;
    
    [scrollView setZoomScale:scale animated:YES];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return photoImageView;
    
}

//返回
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"生成图片";
    
    UIImage *image = [UIImage imageNamed:@"navbar@2x"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#333333"]}];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}




@end
