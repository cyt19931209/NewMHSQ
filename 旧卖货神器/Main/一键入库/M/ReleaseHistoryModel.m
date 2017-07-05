//
//  ReleaseHistoryModel.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ReleaseHistoryModel.h"

@implementation ReleaseHistoryModel




- (void)setDic:(NSDictionary *)dic{

    _dic = dic;

//    
//    CGFloat height = 0;
//    
//    
//    NSArray *arr = dic[@"img"];
//    
//    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
//    
//    CGFloat emptylen = 20;
//    
//    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
//    
//    
//    CGRect rect = [dic[@"goods_description"] boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paraStyle01} context:nil];
//    height = 160 + rect.size.height + 5;
//    
//    if (arr.count < 4) {
//        
//        height = height + kScreenWidth/4;
//    }else if (arr.count > 3 && arr.count < 7){
//        
//        height = height + kScreenWidth/2 + 5;
    
//    }else if (arr.count > 6){
//        
//        height = height + kScreenWidth/4 * 3 + 10;
//        
//    }
//    
//    NSArray *unstatusArr = dic[@"unstatus"];
//    
//    if (unstatusArr.count == 0) {
//        
//        height = height - 80;
//        
//    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData  = [defaults objectForKey:@"SYGData"];
    
    CGFloat height = 0;
    
    NSArray *arr  = nil;
    
//    if (_isFriend) {
//        dic = _dataArr1[indexPath.section];
//        
//    }else if (_isALL){
//        dic = _dataArr2[indexPath.section];
//        
//    }else{
//        dic = _dataArr[indexPath.section];
//    }
    
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
    
    NSArray *unstatusArr = dic[@"unstatus"];
    
    if ([SYGData[@"shop_id"] isEqualToString:dic[@"shop_id"]]||!dic[@"shop_id"]) {
        
        height = height + 10;

        if (unstatusArr.count != 0) {
            
            height = height + 80;
        }

    }else{
    
        height = height + 60;

    }
    
    
//    if (_isFriend) {
//        
//        height = height + 60;
//        
//    }else if (_isALL){
//        
//        if ([SYGData[@"shop_id"] isEqualToString:dic[@"shop_id"]]||!dic[@"shop_id"]) {
//            
//            height = height + 10;
//            
//            if (unstatusArr.count != 0) {
//                height = height + 80;
//            }
//            
//        }else{
//            
//            height = height + 60;
//        }
//        
//    }else{
//        
//        height = height + 10;
//        
//        if (unstatusArr.count != 0&&![_is_delete isEqualToString:@"1"]) {
//            height = height + 80;
//        }
//        
//    }
//    
//    return height;

    
    
    _cellHeight = height;

}





@end
