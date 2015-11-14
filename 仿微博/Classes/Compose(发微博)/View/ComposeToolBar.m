//
//  ComposeToolBar.m
//  仿微博
//
//  Created by Yzc on 15/11/12.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "ComposeToolBar.h"
#import "UIView+Extension.h"

@interface ComposeToolBar()
@property(nonatomic, weak) UIButton *emotionButton;
@end

@implementation ComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        //添加按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:ComposeToolBarButtonCamera];
        
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:ComposeToolBarButtonPicture];
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:ComposeToolBarButtonMention];
        
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:ComposeToolBarButtonTrend];
        
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:ComposeToolBarButtonEmotion];
    }
    return self;
}


-(UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(ComposeToolBarButtonType)buttonType
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = buttonType;
    [self addSubview:btn];
    return btn;
}


-(void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    NSString *image =@"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    if(showKeyboardButton)
    {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateDisabled];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置所有按钮frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btn.width;
        btn.height = btnH;
    }
}

-(void)btnClick:(UIButton *)btn
{
        if([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)])
        {
            [self.delegate composeToolbar:self didClickButton:btn.tag];
        }
}

@end
