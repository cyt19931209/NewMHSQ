//
//  SelectPhotoCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SelectPhotoCell.h"

@implementation SelectPhotoCell


- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    
    NSArray *imageArr = _dic[@"img"];
    
    if (imageArr.count != 0) {
        
        [_imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageArr[0][@"thumbnail"]]]];
        
    }else{
        
        _imageV.image = [UIImage imageNamed:@"MRLG"];
    }
    
    
    _numLabel.hidden = YES;
    _bgView.hidden = YES;
    

}


@end
