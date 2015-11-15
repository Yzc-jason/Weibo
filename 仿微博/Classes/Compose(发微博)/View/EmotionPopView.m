//
//  EmotionPopView.m
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionPopView.h"
#import "Emoition.h"
#import "EmotionButton.h"

@interface EmotionPopView()

@property (weak, nonatomic) IBOutlet EmotionButton *emotionButton;

@end

@implementation EmotionPopView

+(instancetype)emotionPopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"EmotionPopView" owner:nil options:nil]lastObject];
}

-(void)setEmotion:(Emoition *)emotion
{
    _emotion = emotion;
    self.emotionButton.emotion = emotion;
}

@end
