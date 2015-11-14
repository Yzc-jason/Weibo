//
//  EmotionPageView.h
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>
//每一行中的表情个数
#define EmotionMaxCols 7
//一页中最多3行
#define EmotionMaxRows 3
// 每一页的表情个数
#define EmotionPageSize ((EmotionMaxRows * EmotionMaxCols) - 1)

@interface EmotionPageView : UIView

@property (strong, nonatomic) NSArray *emotions;



@end
