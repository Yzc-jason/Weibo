//
//  EmotionTool.m
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionTool.h"
#define RecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

@class Emoition;

@implementation EmotionTool

+ (void)saveRecentEmotion:(Emoition *)emotion
{
    //加载沙盒中的表情数据
    NSMutableArray *emotions =( NSMutableArray *)[self recentEmotions];
    if(emotions == nil)
    {
        emotions = [NSMutableArray array];
    }
    //将表情放到最前面
    [emotions insertObject:emotion atIndex:0];
    //将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:RecentEmotionsPath];
   

}
+ (NSArray *)recentEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionsPath];
}

@end
