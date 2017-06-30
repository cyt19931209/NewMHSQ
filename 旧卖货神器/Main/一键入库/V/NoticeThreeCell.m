//
//  NoticeThreeCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/14.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "NoticeThreeCell.h"

@implementation NoticeThreeCell


- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    
    _bcdImageV.image = [[UIImage imageNamed:@"bcd.png"] stretchableImageWithLeftCapWidth:50 topCapHeight:50];
    
    NSString * htmlString = _dic[@"content"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _MCLabel.attributedText = attrStr;

    
    _timeLabel.text = _dic[@"add_time"];
    
    if ([_dic[@"type"] isEqualToString:@"addgoods"]) {
        
        _titleLabel.text = @"商品添加通知";
        _XKLabel.text = @"查看商品";
    }else{
        _titleLabel.text = @"关注通知";
        _XKLabel.text = @"查看详情";
    }
    
    if ([_dic[@"is_read"] isEqualToString:@"1"]) {
        _readLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        _readLabel.text = @"已读";
    }else{
        _readLabel.textColor = [RGBColor colorWithHexString:@"#949dff"];
        _readLabel.text = @"未读";
    }

    

}

@end
