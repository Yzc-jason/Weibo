//
//  EmotionTextView.h
//  仿微博
//
//  Created by Yzc on 15/11/15.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "TextView.h"

@class Emoition;
@interface EmotionTextView : TextView
-(void)insertEmotion:(Emoition *) emotion;
-(NSString *)fullText;
@end
