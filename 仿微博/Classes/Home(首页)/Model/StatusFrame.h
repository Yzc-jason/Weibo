//
//  StatusFrame.h
//  仿微博
//
//  Created by Yzc on 15/11/8.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

//昵称字体
#define StatusCellNameFont [UIFont systemFontOfSize:15]
//时间字体
#define StatusCellTimeFont [UIFont systemFontOfSize:12]
//来源字体
#define StatusCellSourceFont StatusCellTimeFont
//正文字体
#define StatusCellContentFont [UIFont systemFontOfSize:14]

// cell之间的间距
#define StatusCellMargin 15
#define StatuesCellBorderW 10


@class Status;
@interface StatusFrame : NSObject

@property(nonatomic, strong) Status *status;

/**  原创微博整体 */
@property(nonatomic, assign) CGRect originalViewF;

/**  头像 */
@property(nonatomic, assign) CGRect iconViewF;

/**  配图 */
@property(nonatomic, assign) CGRect photosViewF;

/**  会员图标 */
@property(nonatomic, assign) CGRect vipViewF;

/**  昵称 */
@property(nonatomic, assign) CGRect nameLabelF;

/**  时间 */
@property(nonatomic, assign) CGRect timeLabelF;

/**  来源 */
@property(nonatomic, assign) CGRect sourceLabelF;

/**  正文 */
@property(nonatomic, assign) CGRect contentLabelF;


/** 转发微博整体 */
@property(nonatomic, assign) CGRect retweetViewF;
/**  配图 */
@property(nonatomic, assign) CGRect retweetPhotosViewF;

/**  正文 */
@property(nonatomic, assign) CGRect retweetContentLabelF;

/**  底部工具条 */
@property(nonatomic, assign) CGRect toolbarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
