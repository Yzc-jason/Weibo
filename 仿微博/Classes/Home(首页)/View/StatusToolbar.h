//
//  StatusToolbar.h
//  仿微博
//
//  Created by Yzc on 15/11/8.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;

@interface StatusToolbar : UIView

+(instancetype)toolbar;
@property(nonatomic, strong) Status *status;
@end
