
//
//  EmotionAttachment.m
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionAttachment.h"
#import "Emoition.h"
@implementation EmotionAttachment
-(void)setEmotion:(Emoition *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
