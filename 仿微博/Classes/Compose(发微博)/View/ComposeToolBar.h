//
//  ComposeToolBar.h
//  仿微博
//
//  Created by Yzc on 15/11/12.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ComposeToolBarButtonCamera,    //拍照
    ComposeToolBarButtonPicture,   //相册
    ComposeToolBarButtonMention,   //@
    ComposeToolBarButtonTrend,     //#
    ComposeToolBarButtonEmotion,   //表情
}ComposeToolBarButtonType;

@class ComposeToolBar;
@protocol ComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(ComposeToolBar *)toolbar didClickButton:(ComposeToolBarButtonType)type;

@end
@interface ComposeToolBar : UIView
@property(nonatomic, weak) id<ComposeToolbarDelegate> delegate;

/**
 *  是够要显示键盘按钮
 */
@property(nonatomic, assign) BOOL showKeyboardButton;
@end
