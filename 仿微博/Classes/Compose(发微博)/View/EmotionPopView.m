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
#import "UIView+Extension.h"

@interface EmotionPopView()

@property (weak, nonatomic) IBOutlet EmotionButton *emotionButton;

@end

@implementation EmotionPopView

+(instancetype)emotionPopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"EmotionPopView" owner:nil options:nil]lastObject];
}


-(void)showFrom:(EmotionButton *)button
{
    if(button == nil) return;
    self.emotionButton.emotion = button.emotion;
    //把popView添加到最上层
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
    
}


@end
