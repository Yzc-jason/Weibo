//
//  TabBarController.m
//  仿微博
//
//  Created by Yzc on 15/11/2.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "NavigationController.h"
#import "TabBar.h"
#import "ComposeController.h"

#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface TabBarController()<TabBarDelegate>

@end

@implementation TabBarController



-(void)viewDidLoad
{
    [super viewDidLoad];
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVC:home title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    MessageViewController *messageCenter = [[MessageViewController alloc] init];
    [self addChildVC:messageCenter title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addChildVC:discover title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addChildVC:profile title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];

    //更换系统自带tabBar
    TabBar *tabBar  =[[TabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}


-(void) addChildVC:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if([[UIDevice currentDevice].systemVersion doubleValue]>=7.0){
    childVc.tabBarItem.selectedImage =[[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVc.tabBarItem.selectedImage =[UIImage imageNamed:selectImage];
    }
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
//    childVc.view.backgroundColor = HWRandomColor;
    // 先给外面传进来的小控制器 包装 一个导航控制器
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}

/**
 *  发送微博加号按钮
 */
-(void)tabBarDiClickPlusButton:(TabBar *)tabBar
{
    ComposeController *vc = [[ComposeController alloc]init];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:vc];
    
    
    [self presentViewController:nav animated:YES completion:nil];
}


@end
