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

static NSMutableArray *_recentEmotions;

+(void)initialize
{
    //加载沙盒中的表情数据
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionsPath];
    if(_recentEmotions == nil)
    {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)saveRecentEmotion:(Emoition *)emotion
{
    
    
    //删除重复表情数据
    //removeObject 底层是调用isEqual 去比较两个对象的内存地址，只有两个内存地址一样才会移除
    //重写isEqual 即可
    [_recentEmotions removeObject:emotion];
    
    //将表情放到最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    //将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:RecentEmotionsPath];
   

}
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

@end
