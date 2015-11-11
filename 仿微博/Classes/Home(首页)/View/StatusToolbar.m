//
//  StatusToolbar.m
//  仿微博
//
//  Created by Yzc on 15/11/8.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "StatusToolbar.h"
#import "UIView+Extension.h"
#import "Status.h"

@interface StatusToolbar()
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation StatusToolbar

-(NSMutableArray *)btns
{
    if(_btns==nil)
    {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividers
{
    if(_dividers==nil)
    {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

+(instancetype)toolbar
{
    return [[self alloc]init];
}


-(UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon
{
    //添加按钮
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    return btn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加按钮
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
    
        //添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  添加分割线
 */
-(void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮frame
    int btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
    
    //设置分割线的frame
    int dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

-(void)setStatus:(Status *)status
{
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}


-(void) setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if(count)
    {
        if(count < 10000)
        {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            double wan = count/10000.0;
            title =[NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
