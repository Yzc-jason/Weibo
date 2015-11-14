//
//  EmotionTabBar.m
//  仿微博
//
//  Created by Yzc on 15/11/13.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionTabBar.h"
#import "UIView+Extension.h"
#import "EmotionTabBarButton.h"

@interface EmotionTabBar()
@property(nonatomic, weak) EmotionTabBarButton *selectBtn;
@end

@implementation EmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:EmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:EmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:EmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:EmotionTabBarButtonTypeLxh];
    }
    return self;
}

-(EmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(EmotionTabBarButtonType)buttonType
{
    //创建按钮
    EmotionTabBarButton *btn = [[EmotionTabBarButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = buttonType;
    [self addSubview:btn];
    
//    if(buttonType == EmotionTabBarButtonTypeDefault){
//        [self btnClick:btn];
//    }
    
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if(self.subviews.count == 1)
    {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if(self.subviews.count == 4)
    {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    return btn;
}

-(void)setDelagate:(id<EmotionTabBarDelegat>)delagate
{
    _delagate = delagate;
    [self btnClick:(EmotionTabBarButton *)[self viewWithTag:EmotionTabBarButtonTypeDefault]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW =self.width / btnCount;
    CGFloat btnH = self.height;
    for(int i = 0; i <btnCount; i++)
    {
        EmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i *btnW;
        btn.height = btnH;
        btn.width = btnW;
    }
}


-(void)btnClick:(EmotionTabBarButton *) btn
{
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;
    if([self.delagate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]){
        [self.delagate emotionTabBar:self didSelectButton:btn.tag];
    }
}

@end
