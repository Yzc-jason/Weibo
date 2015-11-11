//
//  AccountTool.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "AccountTool.h"
// 账号的存储路径
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation AccountTool
+(Account *)account
{
    //解档数据
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    //过期秒数
    long long expires_in = [account.expires_in longLongValue];
   //获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    NSData *now = [NSDate date];
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if(result != NSOrderedDescending){  //过期
        return nil;
    }
    
    return account;
}

+(void)saveAccount:(Account *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}
@end
