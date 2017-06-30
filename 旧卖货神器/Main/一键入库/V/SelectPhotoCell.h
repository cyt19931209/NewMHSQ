//
//  SelectPhotoCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/12/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPhotoCell : UICollectionViewCell



@property (nonatomic,strong) NSDictionary *dic;


@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageV;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
