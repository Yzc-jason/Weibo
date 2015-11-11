//
//  LoadMoreFooterViewController.m
//  仿微博
//
//  Created by Yzc on 15/11/7.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "LoadMoreFooter.h"

@interface LoadMoreFooter ()

@end

@implementation LoadMoreFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"LoadMoreFooter" owner:nil options:nil]lastObject];
}


@end
