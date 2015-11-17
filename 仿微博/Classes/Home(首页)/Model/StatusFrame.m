//
//  StatusFrame.m
//  仿微博
//
//  Created by Yzc on 15/11/8.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "User.h"
#import "StatusFrame.h"
#import "Status.h"
#import "StatusToolbar.h"
#import "NSString+Extension.h"
#import "StatusPhotosView.h"


@implementation StatusFrame



-(void)setStatus:(Status *)status
{
    _status = status;
    User *user = status.user;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 原创微博 */
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = StatuesCellBorderW;
    CGFloat iconY = StatusCellMargin + StatuesCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) +StatuesCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithfont:StatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
     /** 会员图标 */
    if(user.isVip){
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + StatuesCellBorderW;
        CGFloat vipY = iconY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + StatuesCellBorderW;
    CGSize timeSize = [status.created_at sizeWithfont:StatusCellNameFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + 3;
    CGFloat sourceY =timeY;
    CGSize sourceSize = [status.source sizeWithfont:StatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat ContentY = MAX(CGRectGetMaxX(self.iconViewF), CGRectGetMaxY(self.sourceLabelF)) + StatuesCellBorderW;
    CGFloat maxW = cellW - 2* contentX;
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelF = (CGRect){{contentX,ContentY},contentSize};
    
     /** 配图 */
    CGFloat originalH = 0;
    if(status.pic_urls.count )
    { // 有配图
        CGFloat photoX =contentX ;
        CGFloat photoY =CGRectGetMaxY(self.contentLabelF) +StatuesCellBorderW ;
        CGSize photoSize = [StatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF =(CGRect){{photoX,photoY},photoSize};
        originalH = CGRectGetMaxY(self.photosViewF) +StatuesCellBorderW;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + StatuesCellBorderW;
    }
    
    /** 原创微博整体 */
    CGFloat originalX =0;
    CGFloat originalY = StatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /** 被转发微博整体 */
     CGFloat toolBarY = 0;
    if(status.retweeted_status)
    {
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = StatuesCellBorderW;
        CGFloat retweetContentY = StatuesCellBorderW ;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [status.retweeted_attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
         /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if(retweeted_status.pic_urls.count )
        { // 有配图
            CGFloat retweetPhotoX =retweetContentX ;
            CGFloat retweetPhotoY =CGRectGetMaxY(self.retweetContentLabelF) +StatuesCellBorderW ;
            CGSize retweetphotoSize = [StatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewF =(CGRect){{retweetPhotoX,retweetPhotoY},retweetphotoSize};
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) +StatuesCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + StatuesCellBorderW;
        }
        /** 被转发微博整体 */
        CGFloat retweetX =0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /**
     *  工具条
     */
    
    CGFloat toolbarX = 0;
    CGFloat toobarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolBarY, toobarW, toolbarH);
    
    /** cell高度  */
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}
@end
