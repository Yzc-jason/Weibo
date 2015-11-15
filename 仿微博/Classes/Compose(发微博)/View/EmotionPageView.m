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
    }
    return self;
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
-(void)deleteBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteDidClicktNotification" object:nil userInfo:nil];
}

-(void)btnClick:(EmotionButton *)btn
{
    self.popView.emotion = btn.emotion;
    //把popView添加到最上层
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    //0.25秒后popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //选中表情发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"SelectEmotionKey"] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidSelectNotification" object:nil userInfo:userInfo];
}

@end
