//
//  StatusTool.m
//  仿微博
//
//  Created by Yzc on 15/11/18.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "StatusTool.h"
#import "FMDB.h"


@implementation StatusTool

static FMDatabase *_db;

+(void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status(id integer PRIMARY KEY,status blob NOT NULL, idstr text NOT NULL);"];
}

/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param paramgs 请求参数
 *
 */
+(NSArray *)statusesWithParamgs:(NSDictionary *)paramgs
{
    NSString *sql = nil;
    if(paramgs[@"since_id"])
    {
        sql = [NSString stringWithFormat:@"SELECT *FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;",paramgs[@"since_id"]];
    }else if(paramgs[@"max_id"]){
        
        sql = [NSString stringWithFormat:@"SELECT *FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;",paramgs[@"max_id"]];
    }else{
        sql = @"SELECT *FROM t_status ORDER BY idstr DESC LIMIT 20";
    }
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusesData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusesData];
        [statuses addObject:status];
    }
    return statuses;
}
/**
 *  存储微博数据到沙盒中
 *
 *  @param statues 需要存储的微博数据
 */
+(void)saveStatuses:(NSArray *)statuses
{
    //将对象转为NSData
    for (NSDictionary *status in statuses) {
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@)",statusData,status[@"idstr"]];
    }
}

@end
