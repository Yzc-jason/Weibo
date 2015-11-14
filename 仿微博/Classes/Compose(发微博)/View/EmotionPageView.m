//
//  EmotionPageView.m
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//  用来表示一页的表情（一页显示大概1~20个表情）

#import "UIView+Extension.h"
#import "EmotionPageView.h"
#import "Emoition.h"
#import "NSString+Emoji.h"



@implementation EmotionPageView


-(void)setEmotions:(NSArray *)emotions
{
    _emotions =emotions;
    NSUInteger count = emotions.count;
    for(int i = 0; i <count; i++)
    {
        UIButton *btn = [[UIButton alloc]init];
        Emoition *emotion = emotions[i];
        if(emotion.png)
        {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        }else if(emotion.code){
             [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
              btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        
        [self addSubview:btn];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 10;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / EmotionMaxCols;
    CGFloat btnH = (self.height - inset) / EmotionMaxRows;
    for(int i = 0; i <count; i++)
    {
        UIButton *button = self.subviews[i];
        button.width = btnW;
        button.height = btnH;
        button.x = inset + (i%EmotionMaxCols) * btnW;
        button.y = inset + (i/EmotionMaxCols) * btnH;
    }
}


@end
