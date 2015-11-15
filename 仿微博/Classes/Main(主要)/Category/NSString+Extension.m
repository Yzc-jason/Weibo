//
//  NSString+Extension.m
//  仿微博
//
//  Created by Yzc on 15/11/9.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize) sizeWithfont:(UIFont *)font
{
    return [self sizeWithfont:font maxW:MAXFLOAT];
}

-(CGSize) sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0){
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }else{
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}


@end
