//
//  UIImage+Tool.m
//  图片剪裁
//
//  Created by Yzc on 15/9/9.
//  Copyright (c) 2015年 Yzc. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)
+(instancetype)imageWithName:(NSString *)name border:(CGFloat)border color:(UIColor *)color{
    CGFloat borderW = border;
    UIImage *oldImage = [UIImage imageNamed:name];
    
    //新图片的尺寸
    CGFloat imageW =oldImage.size.width + 2 * borderW;
    CGFloat imageH = oldImage.size.height + 2 * borderW;
    
    //设置新图片的尺寸
    CGFloat circleW = imageH > imageW ? imageW : imageH;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    
    //画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleW, circleW)];
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    //设置圆的颜色
    [color set];
    //渲染
    CGContextFillPath(ctx);
    
    CGRect clipR = CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    
    //设置剪裁区
    [clipPath addClip];
    
    //画图片
    [oldImage drawAtPoint:CGPointMake(borderW, borderW)];
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
