
//
//  HttpTool.m
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool
+(void)get:(NSString *)urlStr paramgs:(NSDictionary *)paramgs success:(void (^)(id json))success failure:( void (^)(NSError *error))failure{
    //创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
   
    [mgr GET:urlStr parameters:paramgs success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if(failure)
        {
            failure(error);
        }
    }];
}
+(void)post:(NSString *)urlStr paramgs:(NSDictionary *)paramgs success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    //创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:urlStr parameters:paramgs success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if(failure)
        {
            failure(error);
        }
    }];
}
@end
