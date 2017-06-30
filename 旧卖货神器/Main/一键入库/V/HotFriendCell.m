//
//  HotFriendCell.m
//  奢易购3.0
//
//  Created by CYT on 2017/6/13.
//  Copyright © 2017年 cyt. All rights reserved.
//

#import "HotFriendCell.h"

@implementation HotFriendCell

- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;

    
    
    NSArray *goodsArr = dic[@"goods"];
    
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *imageV = [self.contentView viewWithTag:100 + i];
        
        if (goodsArr.count > i) {

            NSArray *imgArr = goodsArr[i][@"img"];
            
            if (imgArr.count != 0) {
                
                [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgArr[0][@"image_url"]]]];

            }else{
                imageV.image = nil;

            }
            
        }else{
        
            imageV.image = nil;
        }
        
    }
    
    _scrollWidth.constant = goodsArr.count * 154 + 6;
    
}
@end
