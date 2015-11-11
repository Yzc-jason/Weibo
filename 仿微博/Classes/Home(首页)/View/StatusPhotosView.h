//
//  StatusPhotosView.h
//  仿微博
//
//  Created by Yzc on 15/11/10.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusPhotosView : UIView

@property(nonatomic, strong) NSArray *photos;

/**
 *  根据图片数量计算相册的尺寸
 */
+(CGSize)sizeWithCount:(int)count;

@end
