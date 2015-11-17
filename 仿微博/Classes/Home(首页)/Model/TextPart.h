//
//  TextPart.h
//  仿微博
//
//  Created by Yzc on 15/11/17.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextPart : NSObject
/**
 *  特殊文字内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  特殊文字范围
 */
@property (nonatomic, assign) NSRange range;
/**
 *  是否为特殊文字
 */
@property (nonatomic, assign, getter = isSpecical) BOOL special;
/**
 *  是否为表情
 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;
@end
