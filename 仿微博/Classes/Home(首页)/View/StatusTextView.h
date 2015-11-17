//
//  StatusTextView.h
//  仿微博
//
//  Created by Yzc on 15/11/17.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusTextView : UITextView
/** 所有的特殊字符串(里面存放着HWSpecial) */
@property (nonatomic, strong) NSArray *specials;
@end
