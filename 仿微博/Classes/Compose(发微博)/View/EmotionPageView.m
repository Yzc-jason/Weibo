//
//  EmotionPageView.m
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//  用来表示一页的表情（一页显示大概1~20个表情）

#import "UIView+Extension.h"
#import "EmotionPageView.h"
#import "Emoition.h"
#import "NSString+Emoji.h"
#import "EmotionButton.h"
#import "EmotionPopView.h"
#import "EmotionTool.h"
#import "Const.h"

@interface EmotionPageView()

@property(nonatomic, strong) EmotionPopView *popView;
@property(nonatomic, weak) UIButton *deleteButton;

@end

@implementation EmotionPageView

#pragma mark - 懒加载
-(EmotionPopView *)popView
{
    if(_popView == nil)
    {
        self.popView = [EmotionPopView emotionPopView];
    }
    return _popView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton =deleteButton;
        
        //添加长安手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

/**
 *  根据手指位置所在的表情按钮
 */
-(EmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for(int i = 0; i <count; i++)
    {
        EmotionButton *btn = self.subviews[i + 1];
        if(CGRectContainsPoint(btn.frame, location))
        {
             return btn;
        }
       
    }
    return nil;
}


-(void)setEmotions:(NSArray *)emotions
{
    _emotions =emotions;
    NSUInteger count = emotions.count;
    for(int i = 0; i <count; i++)
    {
        EmotionButton *btn = [[EmotionButton alloc]init];
        
        [self addSubview:btn];
        btn.emotion = emotions[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 设置子控件位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 10;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / EmotionMaxCols;
    CGFloat btnH = (self.height - inset) / EmotionMaxRows;
    for(int i = 0; i <count; i++)
    {
        UIButton *button = self.subviews[i + 1];
        button.width = btnW;
        button.height = btnH;
        button.x = inset + (i%EmotionMaxCols) * btnW;
        button.y = inset + (i/EmotionMaxCols) * btnH;
    }
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width - inset - btnW;
    self.deleteButton.y = self.height - btnW;
}

#pragma mark - 监听方法
-(void)longPressPageView:(UILongPressGestureRecognizer *)recegnizer
{
    CGPoint location = [recegnizer locationInView:recegnizer.view];
    EmotionButton *btn = [self emotionButtonWithLocation:location];
    switch (recegnizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if(btn) //如果手指还在表情按钮上
            {
                [self selectEmotion:btn.emotion];
            }
            break;
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }
}


-(void)deleteBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDidDeleteNotification object:nil userInfo:nil];
}

-(void)btnClick:(EmotionButton *)btn
{
    [self.popView showFrom:btn];
    
    //0.25秒后popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    [self selectEmotion:btn.emotion];
}

-(void) selectEmotion:(Emoition *)emotion
{
    //将表情存进沙盒
    [EmotionTool saveRecentEmotion:emotion];
    //选中表情发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[SelectEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDidSelectNotification object:nil userInfo:userInfo];
}


@end
