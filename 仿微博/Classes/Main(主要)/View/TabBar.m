//
//  TabBar.m
//  仿微博
//
//  Created by Yzc on 15/11/4.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "TabBar.h"
#import "UIView+Extension.h"

@interface TabBar()

@property(nonatomic, weak)  UIButton *plushBtn;

@end

@implementation TabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个加好按钮
        UIButton *plushBtn = [[UIButton alloc]init];
        [plushBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plushBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plushBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plushBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plushBtn.size = plushBtn.currentBackgroundImage.size;
        [plushBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plushBtn];
        self.plushBtn = plushBtn;
    }
    return self;
}

-(void)plusClick
{
    //通知代理
    if([self.delegate respondsToSelector:@selector(tabBarDiClickPlusButton:)]) {
        [self.delegate tabBarDiClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //加号位置
    self.plushBtn.centerX = self.width * 0.5;
    self.plushBtn.centerY = self.height * 0.5;
    
    //设置其他TabBarButton的位置和尺寸
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0 ;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置宽度
            child.width = tabBarButtonW;
            //设置x
            child.x = tabBarButtonIndex *tabBarButtonW;
            //增加索引
            tabBarButtonIndex++;
            if(tabBarButtonIndex == 2){
                tabBarButtonIndex++;
            }
        }
    }
    
}


@end
