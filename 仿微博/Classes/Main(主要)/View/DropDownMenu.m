//
//  DropDownMenu.m
//  仿微博
//
//  Created by Yzc on 15/11/4.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "DropDownMenu.h"
#import "UIView+Extension.h"

@interface DropDownMenu()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;


@end

@implementation DropDownMenu

-(UIImageView *)containerView
{
    if(!_containerView){
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES ;  //开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
        
    }
    return _containerView;
}

-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc]init];
}

-(void)setContent:(UIView *)content
{
    _content = content;
    //调整内容位置
    content.x = 10;
    content.y = 15;
    
    //设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) +11;
    //设置灰色宽度
    self.containerView.width = CGRectGetMaxX(content.frame) +10;
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}
/**
 *  显示
 */
-(void)showFrom:(UIView *)from
{
    // 1. 获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 2.添加自己到窗口上
    [window addSubview:self];
    // 3.设置尺寸
    self.frame = window.bounds;
    // 4.调整灰色图片位置
    //默认情况下，frame是父控件左上角为坐标原点
    //转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    //通知外界自己显示了
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDisShow:)]) {
        [self.delegate dropDownMenuDisShow:self];
    }
}

-(void) dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
