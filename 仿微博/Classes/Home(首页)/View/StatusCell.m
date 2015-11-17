//
//  StatusCell.m
//  仿微博
//
//  Created by Yzc on 15/11/8.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "StatusCell.h"
#import "StatusFrame.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "Status.h"
#import "Photo.h"
#import "StatusToolbar.h"
#import "NSString+Extension.h"
#import "StatusPhotosView.h"
#import "IconView.h"
#import "StatusTextView.h"

@interface StatusCell()

/**  原创微博整体 */
@property(nonatomic, weak) UIView *originalView;

/**  头像 */
@property(nonatomic, weak) IconView *iconView;

/**  配图 */
@property(nonatomic, weak) StatusPhotosView *photosView;

/**  会员图标 */
@property(nonatomic, weak) UIImageView *vipView;

/**  昵称 */
@property(nonatomic, weak) UILabel *nameLabel;

/**  时间 */
@property(nonatomic, weak) UILabel *timeLabel;

/**  来源 */
@property(nonatomic, weak) UILabel *sourceLabel;

/**  正文 */
@property(nonatomic, weak) StatusTextView *contentLabel;


/** 转发微博整体 */
@property(nonatomic, weak)  UIView *retweetView;
/**  配图 */
@property(nonatomic, weak) StatusPhotosView *retweetPhotosView;

/**  转发微博 + 昵称 */
@property(nonatomic, weak) StatusTextView *retweetContentLabel;

/**  工具条 */
@property(nonatomic, weak) StatusToolbar *toolBar;


@end


@implementation StatusCell



+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"Cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //初始化原创微博
        [self setOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        
        //初始化工具条
        [self setupToolBar];
    }
    return self;
}

/**
 *  初始化工具条
 */
-(void)setupToolBar
{
    StatusToolbar *toolBar = [StatusToolbar toolbar];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}

/**
 *  初始化转发微博
 */
-(void) setupRetweet
{
    /**  转发微博整体 */
    UIView *retweetView =[[UIView alloc]init];
    retweetView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /**  转发微博 + 昵称 */
    StatusTextView *retweetContentLabel =[[StatusTextView alloc]init];
    retweetContentLabel.font =  StatusCellSourceFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /**  配图 */
    StatusPhotosView *retweetPhotoView =[[StatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotosView = retweetPhotoView;
}


/**
 *  初始化原创微博
 */
-(void)setOriginal
{
    /**  原创微博整体 */
    UIView *originalView =[[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /**  头像 */
    IconView *iconView = [[IconView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;

    
    /**  配图 */
    StatusPhotosView *photosView = [[StatusPhotosView alloc]init];
    [originalView addSubview:photosView];
    self.photosView = photosView;

    
    /**  会员图标 */
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;

    
    /**  昵称 */
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = StatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;

    
    /**  时间 */
    UILabel *timeLabel  = [[UILabel alloc]init];
    timeLabel.font =  StatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    
    /**  来源 */
    UILabel *sourceLabel  = [[UILabel alloc]init];
    sourceLabel.font =  StatusCellSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;

    
    /**  正文 */
    StatusTextView *contentLabel  = [[StatusTextView alloc]init];
    contentLabel.font =  StatusCellSourceFont;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    

}

-(void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    Status *status = statusFrame.status;
    User *user = status.user;
    
    /** 原创微博 */
    self.originalView.frame = statusFrame.originalViewF;
    
     /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
     /** 会员图标 */
    if(user.isVip)
    {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + StatuesCellBorderW;
    CGSize timeSize = [time sizeWithfont:StatusCellTimeFont ];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + 3;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithfont:StatusCellSourceFont ];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;
   
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.attributedText = status.attributedText;
    
    /** 配图 */
    if(status.pic_urls.count)
    {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    /** 转发微博 */
    if(status.retweeted_status)
    {
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
         /** 被转发微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
     
        /** 被转发微博正文 */
        self.retweetContentLabel.attributedText = status.retweeted_attributedText;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发微博配图 */
        if(retweeted_status.pic_urls.count)
        {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        }else{
            self.retweetPhotosView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolBar.frame = statusFrame.toolbarF;
    self.toolBar.status = status;
}
@end
