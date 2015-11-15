//
//  UITextView+Extension.m
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text
{
    
    [self insertAttributedText:text settingBlock:nil];
}


- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlcok
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    
    //拼接之前的文字
    [attributedText appendAttributedString:self.attributedText];
    
    //拼图
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];
    //    [attributedText replaceCharactersInRange:self.selectedRange withString:text];
    
    if(settingBlcok)
    {
        settingBlcok(attributedText);
    }
    self.attributedText = attributedText;
    //移除光标到表情后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
