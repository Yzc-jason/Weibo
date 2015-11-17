//
//  StatusTextView.m
//  仿微博
//
//  Created by Yzc on 15/11/17.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "StatusTextView.h"
#import "Special.h"
#define StatustTextViewCoverTag 99

@implementation StatusTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)setupSpecialRects
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (Special *special in specials) {
        self.selectedRange = special.range;
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        //清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in selectionRects) {
            CGRect rect = selectionRect.rect;
            if(rect.size.width == 0 || rect.size.height == 0) continue;
            
            //添加rect
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rects;
    }
}

-(Special *)touchingSpecicalWithPoing:(CGPoint)point
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (Special *special in specials) {
        for (NSValue *rectValue in special.rects) {
            if(CGRectContainsPoint(rectValue.CGRectValue, point)){
                return special;
            }
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //触摸对象
    UITouch *touch = [touches anyObject];
    //触摸点
    CGPoint point = [touch locationInView:self];
    [self setupSpecialRects];
    Special *special = [self touchingSpecicalWithPoing:point];
    for (NSValue *rectValue in special.rects) {
        //触摸特殊文字背景
        UIView *cover = [[UIView alloc]init];
        cover.backgroundColor = [UIColor greenColor];
        cover.frame = rectValue.CGRectValue;
        cover.layer.cornerRadius = 5;
        cover.tag = StatustTextViewCoverTag;
        [self insertSubview:cover atIndex:0];
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    [self setupSpecialRects];
    
    Special *special = [self touchingSpecicalWithPoing:point];
    if(special){
        return YES;
    }else{
        return NO;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *child in self.subviews) {
        if(child.tag == StatustTextViewCoverTag) [child removeFromSuperview];
    }
}


@end
