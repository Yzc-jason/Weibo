//
//  NSDate+Extension.h
//  仿微博
//
//  Created by Yzc on 15/11/9.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
-(BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
-(BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
-(BOOL)isToday;


@end
