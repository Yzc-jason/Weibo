//
//  TextView.m
//  仿微博
//
//  Created by Yzc on 15/11/12.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "TextView.h"

@implementation TextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tectDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  监听文字改变
 */
-(void)tectDidChange
{
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
     // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    if(self.hasText) return;
    
    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w =rect.size.width - 2 * x;
    CGFloat h =rect.size.height - 2 * y;
    CGRect placeHolderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeHolderRect withAttributes:attrs];
}

@end
