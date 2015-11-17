//
//  Special.h
//  仿微博
//
//  Created by Yzc on 15/11/17.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Special : NSObject
/**
 *  特殊文字内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  特殊文字的范围
 */
@property (nonatomic, assign) NSRange range;
/**
 *  特殊文字的矩形框
 */
@property (nonatomic, strong) NSArray *rects;

@end
