//
//  TabBar.h
//  仿微博
//
//  Created by Yzc on 15/11/4.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar;
@protocol TabBarDelegate <UITabBarDelegate>

@optional
-(void)tabBarDiClickPlusButton:(TabBar *)tabBar;

@end

@interface TabBar : UITabBar
@property(nonatomic, weak) id<TabBarDelegate> delegate;
@end
