//
//  HttpTool.h
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+(void)get:(NSString *)urlStr paramgs:(NSDictionary *)paramgs success:(void (^)(id json))success failure:( void (^)(NSError *error))failure;
+(void)post:(NSString *)urlStr paramgs:(NSDictionary *)paramgs success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
