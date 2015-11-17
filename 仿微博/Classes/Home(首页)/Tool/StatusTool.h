//
//  StatusTool.h
//  仿微博
//
//  Created by Yzc on 15/11/18.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject
/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param paramgs 请求参数
 *
 */
+(NSArray *)statusesWithParamgs:(NSDictionary *)paramgs;
/**
 *  存储微博数据到沙盒中
 *
 *  @param statues 需要存储的微博数据
 */
+(void)saveStatuses:(NSArray *)statsues;
@end
