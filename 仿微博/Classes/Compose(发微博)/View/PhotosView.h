//
//  PhotosView.h
//  仿微博
//
//  Created by Yzc on 15/11/12.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosView : UIView
-(void)addPhoto:(UIImage *)photo;

@property(nonatomic,strong,readonly) NSMutableArray *photos;
@end
