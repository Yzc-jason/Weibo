//
//  User.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "User.h"

@implementation User

-(void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip =mbtype > 2;
}

@end
