//
//  EmotionListView.m
//  仿微博
//
//  Created by Yzc on 15/11/13.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionListView.h"
#import "UIView+Extension.h"

// 每一页的表情个数
#define EmotionPageSize 20

// RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface EmotionListView()

@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, weak) UIPageControl *pageControl;

@end

@implementation EmotionListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor redColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = (emotions.count + EmotionPageSize - 1) / EmotionPageSize;
    self.pageControl.numberOfPages = count;
    for(int i = 0; i <self.pageControl.numberOfPages; i++)
    {
        UIView *pageView = [[UIView alloc]init];
        pageView.backgroundColor = RandomColor;
        [self.scrollView addSubview:pageView];
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //ScrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    //设置scrollview内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for(int i = 0; i <count; i++)
    {
        UIView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

@end

