//
//  Emoition.m
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "Emoition.h"

@implementation Emoition

/**
 *  从文件中解析对象时调用
 *
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
    
}

-(BOOL)isEqual:(Emoition *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString: other.code];
}

@end
