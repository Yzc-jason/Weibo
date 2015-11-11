//
//  Account.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "Account.h"


@implementation Account

+(instancetype) accountWithDict:(NSDictionary *)dict
{
    Account *account = [[Account alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    // 获得账号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    return account;
}


-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

-(id)initWithCoder:(NSCoder *) decoder
{
    if(self =[super init])
    {
         self.access_token = [decoder decodeObjectForKey:@"access_token"];
         self.uid = [decoder decodeObjectForKey:@"uid"];
         self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
         self.name = [decoder decodeObjectForKey:@"name"];
         self.created_time = [decoder decodeObjectForKey:@"created_time"];
    }
    return self;
}

@end
