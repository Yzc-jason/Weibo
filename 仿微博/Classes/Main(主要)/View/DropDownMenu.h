//
//  DropDownMenu.h
//  仿微博
//
//  Created by Yzc on 15/11/4.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDownMenu;
@protocol DropDownMenuDelegate <NSObject>

@optional
-(void) dropDownMenuDidDismiss:(DropDownMenu *)menu;
-(void) dropDownMenuDisShow:(DropDownMenu *) menu;
@end
@interface DropDownMenu : UIView

@property(nonatomic , weak) id<DropDownMenuDelegate> delegate;
+(instancetype) menu;
/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
