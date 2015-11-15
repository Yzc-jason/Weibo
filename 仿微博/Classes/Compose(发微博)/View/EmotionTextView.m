//
//  EmotionTextView.m
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionTextView.h"
#import "Emoition.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"

@implementation EmotionTextView

-(void)insertEmotion:(Emoition *) emotion
{
    if(emotion.code)
    {
        [self insertText:emotion.code.emoji];
    }else if(emotion.png){
        //加载图片
        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
        attch.image =[UIImage imageNamed:emotion.png];
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        
        //根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        //插入属性文字到光标位置
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
           //设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];

        //设置字体
       
        
    }
}

@end
