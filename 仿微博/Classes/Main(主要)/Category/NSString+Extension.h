//
//  NSString+Extension.h
//  仿微博
//
//  Created by Yzc on 15/11/9.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface NSString (Extension)

-(CGSize) sizeWithfont:(UIFont *)font;
-(CGSize) sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW;

@end
