//
//  EmotionKeyboard.m
//  仿微博
//
//  Created by Yzc on 15/11/13.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionKeyboard.h"
#import "EmotionTabBar.h"
#import "EmotionListView.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "Emoition.h"
#import "EmotionTool.h"


@interface EmotionKeyboard()<EmotionTabBarDelegat>
/** 表情工具条 */
@property(nonatomic, weak) EmotionTabBar *tabBar;

/** 最近表情 */
@property (strong, nonatomic) EmotionListView *rectentListView;
/** 默认表情 */
@property (strong, nonatomic) EmotionListView *defaultListView;
/** emoji表情 */
@property (strong, nonatomic) EmotionListView *emojiListView;
/** 浪小花表情 */
@property (strong, nonatomic) EmotionListView *lxhListView;


/** 保存正在显示listView */
@property (weak, nonatomic) EmotionListView *showingListView;

@end

@implementation EmotionKeyboard

#pragma mark -懒加载
-(EmotionListView *)rectentListView
{
    if(_rectentListView == nil)
    {
        
        self.rectentListView = [[EmotionListView alloc]init];
        //加载沙盒数据
        self.rectentListView.emotions = [EmotionTool recentEmotions];
    }
    return _rectentListView;
}


-(EmotionListView *)defaultListView
{
    if(_defaultListView == nil)
    {
        
        self.defaultListView = [[EmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [Emoition objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

-(EmotionListView *)emojiListView
{
    if(_emojiListView == nil)
    {
       
        self.emojiListView = [[EmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [Emoition objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

-(EmotionListView *)lxhListView
{
    if(_lxhListView == nil)
    {
        
        self.lxhListView = [[EmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [Emoition objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //工具条
        EmotionTabBar *tabBar = [[EmotionTabBar alloc]init];
        tabBar.delagate =self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        //选中表情
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:@"EmotionDidSelectNotification" object:nil];
    }
    return self;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)emotionDidSelect
{
    //加载沙盒数据
    self.rectentListView.emotions = [EmotionTool recentEmotions];
    
}




#pragma mark - 设置子控件frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    //1.设置tabBar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    //2.表情内容
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    self.showingListView.x =self.showingListView.y = 0;
}

#pragma mark - EmotionTabBarDelegat
-(void)emotionTabBar:(EmotionTabBar *)tabBar didSelectButton:(EmotionTabBarButtonType)buttonType
{
    //移除正在显示的lsitView控件
    [self.showingListView removeFromSuperview];
    switch (buttonType) {
    case EmotionTabBarButtonTypeRecent: // 最近
            [self addSubview:self.rectentListView];
        break;
        
    case EmotionTabBarButtonTypeDefault: // 默认
        [self addSubview:self.defaultListView];
           
        break;
        
    case EmotionTabBarButtonTypeEmoji: // Emoji
        [self addSubview:self.emojiListView];
            
        break;
        
    case EmotionTabBarButtonTypeLxh: // Lxh
        [self addSubview:self.lxhListView];
            
        break;
            
}
    //设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    [self setNeedsLayout];
    
}

@end
