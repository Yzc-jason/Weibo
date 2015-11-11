//
//  Test1ViewController.m
//  仿微博
//
//  Created by Yzc on 15/11/3.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2Controller.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Test2Controller *test2 = [[Test2Controller alloc]init];
    test2.title = @"test2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}
@end
