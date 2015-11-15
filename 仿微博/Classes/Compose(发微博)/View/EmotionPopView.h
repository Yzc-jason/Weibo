//
//  EmotionPopView.h
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emoition,EmotionButton;

@interface EmotionPopView : UIView

+(instancetype)emotionPopView;
-(void)showFrom:(EmotionButton *)button;

@end
