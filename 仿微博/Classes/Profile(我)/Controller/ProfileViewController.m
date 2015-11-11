//
//  ProfileViewController.m
//  仿微博
//
//  Created by Yzc on 15/11/2.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "ProfileViewController.h"
#import "Test1ViewController.h"

@implementation ProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:0 target:self action:@selector(setting)];
}

-(void) setting
{
    Test1ViewController *test1 = [[Test1ViewController alloc]init];
    test1.title = @"设置";
    [self.navigationController pushViewController:test1 animated:YES];
}

@end
