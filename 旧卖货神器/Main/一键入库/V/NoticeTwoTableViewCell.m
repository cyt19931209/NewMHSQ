//
//  NoticeTwoTableViewCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/12/13.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "NoticeTwoTableViewCell.h"

@implementation NoticeTwoTableViewCell

- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    
    
    
    
    NSString * htmlString = _dic[@"content"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _MCLabel.attributedText = attrStr;
    
    _titleLabel.text = _dic[@"title"];
    
    _timeLabel.text = _dic[@"add_time"];
    
    
    if ([_dic[@"type"] isEqualToString:@"text"]) {
        
        _bcdImageV.image = [[UIImage imageNamed:@"bcd.png"] stretchableImageWithLeftCapWidth:50 topCapHeight:50];

    }else if ([_dic[@"type"] isEqualToString:@"joinfriend"]){
    
        _bcdImageV.image = [[UIImage imageNamed:@"Combined Shape333"] stretchableImageWithLeftCapWidth:50 topCapHeight:50];

        _titleLabel.text = @"同行申请通知";

        _MCLabel.text =_dic[@"title"];
        
    }else if ([_dic[@"type"] isEqualToString:@"joinsuccessfriend"]){
        
        _titleLabel.text = @"通过通知";

        _bcdImageV.image = [[UIImage imageNamed:@"Combined Shape333"] stretchableImageWithLeftCapWidth:50 topCapHeight:50];
        
        _MCLabel.text =_dic[@"title"];

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
