//
//  NewFeatureController.m
//  仿微博
//
//  Created by Yzc on 15/11/5.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "NewFeatureController.h"
#import "UIView+Extension.h"
#import "TabBarController.h"
#define ImageCount 4

@interface NewFeatureController ()<UIScrollViewDelegate>

@property(nonatomic,weak) UIScrollView *scrollView;
@property(nonatomic,weak) UIPageControl *pageController;

@end

@implementation NewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame  = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //添加图片到scrollerView中
    CGFloat scrollW = self.scrollView.width;
    CGFloat scrollH = self.scrollView.height;
    for (int i = 0; i<ImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x =i *scrollW;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        if(i == ImageCount - 1 ){
            [self setupLastImageView:imageView];
        }
    }
    
    //设置scrollView其他属性
    scrollView.contentSize =CGSizeMake(ImageCount*scrollW, 0);   //设置横向滑动
    scrollView.bounces = NO;                                    //取消弹簧效果
    scrollView.showsHorizontalScrollIndicator = NO;             //取消横向滚动条
    scrollView.pagingEnabled = YES;                             //开启一次滑动一张
    scrollView.delegate = self;
    
    //添加pageController分页
    UIPageControl *pageController = [[UIPageControl alloc]init];
    pageController.centerX = scrollW *0.5;
    pageController.centerY = scrollH - 50 ;
    pageController.numberOfPages = ImageCount;
    pageController.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    pageController.pageIndicatorTintColor =[UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    [self.view addSubview:pageController];
    self.pageController = pageController;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     double page = scrollView.contentOffset.x / scrollView.width;
    self.pageController.currentPage = (page+0.5);
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    //开启交互功能，不然屏幕的按钮不能点击
    imageView.userInteractionEnabled = YES;
    
    
    UIButton *shareButton = [[UIButton alloc]init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    shareButton.width = 200;
    shareButton.height = 30;
    shareButton.centerX = imageView.width *0.5;
    shareButton.centerY = imageView.height * 0.65;
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);     //影响按钮内部的titleLabel
    [imageView addSubview:shareButton];
    
    
    
    //开始微博按钮
    UIButton *startButton = [[UIButton alloc]init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = imageView.width * 0.5;
    startButton.centerY = imageView.height * 0.75;
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}

-(void) shareClick:(UIButton *)shareButton
{
    //状态取反
    shareButton.selected = !shareButton.isSelected;
}

-(void)startClick
{
    // 切换到HWTabBarController
    /*
     切换控制器的手段
     1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A
     3.切换window的rootViewController
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[TabBarController alloc]init];
}

@end
