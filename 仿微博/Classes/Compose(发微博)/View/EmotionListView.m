//
//  EmotionListView.m
//  仿微博
//
//  Created by Yzc on 15/11/13.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "EmotionListView.h"
#import "UIView+Extension.h"
#import "EmotionPageView.h"




@interface EmotionListView()<UIScrollViewDelegate>

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
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
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
        EmotionPageView *pageView = [[EmotionPageView alloc]init];
        //计算一页的表情范围
        NSRange range;
        range.location = i *EmotionPageSize;
        //left:剩余的表情数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if(left >= EmotionPageSize ){
            range.length =EmotionPageSize;
        }else{
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
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
        EmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage =(int)(pageNo + 0.5);
}

@end

