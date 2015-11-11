//
//  TitleButton.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "TitleButton.h"
#import "UIView+Extension.h"
#define margin 7

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.width += margin;
    [super setFrame:frame];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    //计算titleLabelded的frame
    self.titleLabel.x = self.imageView.x;
    //计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + margin;
}

-(void) setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //只要修改文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    //只要修改文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

@end
