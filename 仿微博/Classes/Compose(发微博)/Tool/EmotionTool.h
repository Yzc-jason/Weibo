//
//  EmotionTool.h
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Emoition;
@interface EmotionTool : NSObject

+ (void)saveRecentEmotion:(Emoition *)emotion;
+ (NSArray *)recentEmotions;

@end
