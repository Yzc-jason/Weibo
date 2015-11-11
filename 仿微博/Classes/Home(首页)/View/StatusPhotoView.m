//
//  StatusPhotoView.m
//  仿微博
//
//  Created by Yzc on 15/11/10.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "StatusPhotoView.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface StatusPhotoView()
@property(nonatomic, weak) UIImageView *gifView;
@end

@implementation StatusPhotoView

-(UIImageView *)gifView
{
    if (_gifView == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
    }
    return _gifView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         UIViewContentModeScaleToFill : 图片拉伸至填充整个UIImageView（图片可能会变形）
         
         UIViewContentModeScaleAspectFit : 图片拉伸至完全显示在UIImageView里面为止（图片不会变形）
         
         UIViewContentModeScaleAspectFill :
         图片拉伸至 图片的宽度等于UIImageView的宽度 或者 图片的高度等于UIImageView的高度 为止
         
         UIViewContentModeRedraw : 调用了setNeedsDisplay方法时，就会将图片重新渲染
         
         UIViewContentModeCenter : 居中显示
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         
         经验规律：
         1.凡是带有Scale单词的，图片都会拉伸
         2.凡是带有Aspect单词的，图片都会保持原来的宽高比，图片不会变形
         */
        //内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setPhoto:(Photo *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] ];
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width ;
    self.gifView.y = self.height - self.gifView.height ;
}

@end
