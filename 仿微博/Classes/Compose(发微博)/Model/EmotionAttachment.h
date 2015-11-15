//
//  EmotionAttachment.h
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emoition;
@interface EmotionAttachment : NSTextAttachment
@property(nonatomic, strong) Emoition *emotion;
@end
