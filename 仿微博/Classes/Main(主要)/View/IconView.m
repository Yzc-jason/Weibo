//
//  IconView.m
//  仿微博
//
//  Created by Yzc on 15/11/10.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "IconView.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "UIView+Extension.h"
#import "UIImage+Tool.h"

@interface IconView()
@property(nonatomic, weak) UIImageView *verifiedView;
@end

@implementation IconView
-(void)setUser:(User *)user
{
    _user = user; 
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url ] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    //设置加V图片
    switch (user.verified_type) {
        case UserVerifiedPersonal:  //个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case UserVerifiedOrgWebsite:  //官方认证
        case UserVerifiedOrgMedia:
        case UserVerifiedOrgEnterprice:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case UserVerifiedDaren:   //微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}


-(UIImageView *)verifiedView
{
    if(_verifiedView == nil)
    {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

@end
