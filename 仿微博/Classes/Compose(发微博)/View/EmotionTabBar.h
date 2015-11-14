//
//  EmotionTabBar.h
//  仿微博
//
//  Created by Yzc on 15/11/13.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionTabBar;
typedef enum{
     EmotionTabBarButtonTypeRecent, //最近
     EmotionTabBarButtonTypeDefault, //默认
     EmotionTabBarButtonTypeEmoji, //emoji
     EmotionTabBarButtonTypeLxh, //浪小花
    
} EmotionTabBarButtonType;


@protocol EmotionTabBarDelegat <NSObject>

@optional
-(void)emotionTabBar:(EmotionTabBar *)tabBar didSelectButton:(EmotionTabBarButtonType)buttonType;

@end
@interface EmotionTabBar : UIView

@property(nonatomic, weak) id<EmotionTabBarDelegat> delagate;

@end
