//
//  Emoition.h
//  仿微博
//
//  Created by Yzc on 15/11/14.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoition : NSObject
/** 表情的文字描述*/
@property(nonatomic, copy) NSString *chs;

/** 表情的图片名*/
@property(nonatomic, copy) NSString *png;

/** emoji表情的16进制编码*/
@property(nonatomic, copy) NSString *code;

@end
