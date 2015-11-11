//
//  MessageViewController.m
//  仿微博
//
//  Created by Yzc on 15/11/2.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "MessageViewController.h"
#import "Test1ViewController.h"

@implementation MessageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void) composeMsg
{
    NSLog(@"composeMsg");
}



#pragma mark - tableViewDelegate & tableViewDataSource
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
// 行高,调用顺序比cellForRowAtIndexPath方法优先
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

// 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Test1ViewController *test1Vc = [[Test1ViewController alloc]init];
    test1Vc.title = @"test1控制器";
    [self.navigationController pushViewController:test1Vc animated:YES];
}

// Cell循环利用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%d", indexPath.row];
    return cell;
}


@end
