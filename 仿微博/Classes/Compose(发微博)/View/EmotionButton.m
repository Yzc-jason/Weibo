//
//  EmotionButton.m
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionButton.h"
#import "Emoition.h"
#import "NSString+Emoji.h"

@implementation EmotionButton

/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
     // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
    self.adjustsImageWhenHighlighted = NO;
}

-(void)setEmotion:(Emoition *)emotion
{
    _emotion = emotion;
    if(emotion.png)
    {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if(emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        
    }

}

@end
