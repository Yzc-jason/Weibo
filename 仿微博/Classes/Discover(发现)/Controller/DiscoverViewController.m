//
//  DiscoryViewController.m
//  仿微博
//
//  Created by Yzc on 15/11/2.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SearchBar.h"
#import "UIView+Extension.h"

@implementation DiscoverViewController

-(void)viewDidLoad
{
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30 ;
    self.navigationItem.titleView = searchBar;
}

@end
