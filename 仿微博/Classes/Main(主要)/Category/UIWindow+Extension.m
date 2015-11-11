//
//  UIWindow+Extension.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "TabBarController.h"
#import "NewFeatureController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //上次使用的版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件版本号(从Info.plist中获得)
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if([currentVersion isEqualToString:lastVersion]){
        self.rootViewController = [[TabBarController alloc]init];
    }else{
        self.rootViewController = [[NewFeatureController alloc]init];
        //将当期的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}


@end
