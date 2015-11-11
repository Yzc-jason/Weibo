//
//  StatusPhotosView.m
//  仿微博
//
//  Created by Yzc on 15/11/10.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "StatusPhotosView.h"
#import "StatusPhotoView.h"
#import "UIView+Extension.h"

#define StatusPhotoMaxCol(count) (count==4?2:3)
#define StatusPhotoWH 70
#define StatusMargin 10

@implementation StatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    int photosCount = photos.count;
    
    //创建足够数量的图片控件
    while (self.subviews.count < photosCount) {
        StatusPhotoView *photoView = [[StatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    
    for (int i = 0; i<self.subviews.count; i++) {
        StatusPhotoView *photoView = self.subviews[i];
        if(i < photosCount)
        { //显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片尺寸和位置
    int photosCount = self.photos.count;
    int maxCol = StatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        StatusPhotoView *photoView = self.subviews[i];
        
        int col =i % maxCol;
        photoView.x = col * (StatusPhotoWH + StatusMargin);
        
        int row = i / maxCol;
        photoView.y = row * (StatusPhotoWH + StatusMargin);
        photoView.width = StatusPhotoWH;
        photoView.height = StatusPhotoWH;
    }
}

/**
 *  根据图片数量计算相册的尺寸
 */
+(CGSize)sizeWithCount:(int)count
{
    //最大列数
    int maxCols = StatusPhotoMaxCol(count);
    
    //列数
    int cols = (count >= maxCols)?maxCols : count;
    CGFloat photosW = cols * StatusPhotoWH +(cols - 1) * StatusMargin;
    
    //行数
    int rows = (count + maxCols -1)/maxCols;
    CGFloat photosH = rows * StatusPhotoWH +(rows - 1) * StatusMargin;
    
    return CGSizeMake(photosW , photosH);
    
}


@end
