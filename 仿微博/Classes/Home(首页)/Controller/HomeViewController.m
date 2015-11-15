//
//  HomeViewController.m
//  仿微博
//
//  Created by Yzc on 15/11/2.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "DropDownMenu.h"
#import "TitleMenuController.h"
#import "TitleButton.h"
#import "AccountTool.h"
#import "HttpTool.h"
#import "User.h"
#import "MJExtension.h"
#import "Status.h"
#import "UIImageView+WebCache.h"
#import "LoadMoreFooter.h"
#import "StatusCell.h"
#import "StatusFrame.h"
#import "MJRefresh.h"

@interface HomeViewController()<DropDownMenuDelegate>

@property(nonatomic, strong) NSMutableArray *statuesFrame;

@end

@implementation HomeViewController


-(NSMutableArray *)statuesFrame
{
    if(_statuesFrame == nil)
    {
        self.statuesFrame = [NSMutableArray array];
    }
    return _statuesFrame;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    //设置导航栏内容
    [self setupNav];
    
    //获得用户信息
    [self setupUserInfo];
    
    //下拉刷新控件
    [self setDownRefresh];
    
    //上拉刷新控件
    [self setupRefresh];
    
    //获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //主线程也会抽时间处理一下timer（不管主线程是否在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


#pragma mark - 初始化控件

/**
 *  获得未读数
 */
-(void) setupUnreadCount
{

    Account *account = [AccountTool account];
    NSMutableDictionary *paramgs = [NSMutableDictionary dictionary];
    paramgs[@"access_token"] =account.access_token ;
    paramgs[@"uid"] = account.uid ;
    
    [HttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" paramgs:paramgs success:^(id json) {
          NSString *status = [json[@"status"] description];
        if([status isEqualToString:@"0"])
        {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status;
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败---%@",error);
    }];
}

/**
 *  将status模型转为statausFrame模型
 *
 */
-(NSArray *)stausFrameWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *frame = [[StatusFrame alloc] init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}



/**
 *  上拉刷新
 */
-(void) setupRefresh
{

    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    self.tableView.footerRefreshingText = @"正在加载数据...";
    
}

/**
 *  加载更多的微博数据
 */
-(void) loadMoreStatus
{
    
    Account *account = [AccountTool account];
    NSMutableDictionary *paramgs = [NSMutableDictionary dictionary];
    paramgs[@"access_token"] =account.access_token ;
    
    //取出最前面的微博（最新的微博，ID最大的微博）
    StatusFrame *lastStatusF = [self.statuesFrame lastObject];
    if(lastStatusF)
    {
        long long maxId =lastStatusF.status.idstr.longLongValue - 1;
        paramgs[@"max_id"] = @(maxId);
    }

    
    [HttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json"  paramgs:paramgs success:^(id json) {
        //将“微博字典”数组转为 “微博模型” 数组
        NSArray *newStatuses = [Status objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        NSArray *newFrames = [self stausFrameWithStatuses:newStatuses];
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuesFrame addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSError *error) {
        self.tableView.tableFooterView.hidden = YES;
        NSLog(@"请求失败---%@",error);

    }];
}

/**
 *  下拉刷新
 */
-(void) setDownRefresh
{
//    UIRefreshControl *control = [[UIRefreshControl alloc]init];
//    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:control];
//    
//    [control beginRefreshing];
//    [self refreshStateChange:control];
    
    //1.添加刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(refreshStateChange)];
    self.tableView.headerRefreshingText = @"正在加载数据...";
    //2.进入刷新状态
    [self.tableView headerBeginRefreshing];
}

-(void)refreshStateChange
{
    Account *account = [AccountTool account];
    NSMutableDictionary *paramgs = [NSMutableDictionary dictionary];
    paramgs[@"access_token"] =account.access_token ;
    
    //取出最前面的微博（最新的微博，ID最大的微博）
    StatusFrame *firstStatusF = [self.statuesFrame firstObject];
    if(firstStatusF)
    {
        paramgs[@"since_id"] = firstStatusF.status.idstr;
    }
    
    
    [HttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json"  paramgs:paramgs success:^(id json) {
        //将“微博字典”数组转为 “微博模型” 数组
        
        NSArray *newStatuses = [Status objectArrayWithKeyValuesArray:json[@"statuses"]];
        NSArray *newFrames = [self stausFrameWithStatuses:newStatuses];
        
        //将最新的微博数据，添加到总数组最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuesFrame insertObjects:newFrames atIndexes:set];
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        
        //显示最新的微博数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        NSLog(@"请求失败---%@",error);
    }];

  }


-(void) setupUserInfo
{
    Account *account = [AccountTool account];
    NSMutableDictionary *paramgs = [NSMutableDictionary dictionary];
    paramgs[@"access_token"] =account.access_token ;
     paramgs[@"uid"] =account.uid ;

    
    [HttpTool get:@"https://api.weibo.com/2/users/show.json" paramgs:paramgs success:^(id json) {
        UIButton *titleButton =(UIButton *) self.navigationItem.titleView;
        User *user = [User objectWithKeyValues:json];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称
        account.name = user.name;
        [AccountTool saveAccount:account];
    } failure:^(NSError *error) {
         NSLog(@"请求失败---%@",error);
    }];
}


/**
 *  显示最新微博数量
 *
 *  @param count 最新微博数
 */
-(void) showNewStatusCount:(int)count
{
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //创建label
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 30;
    
    //设置其他属性
    if(count == 0)
    {
        
        label.text = @"没有新的微博数据，请稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //添加
    label.y = 64 - label.height;
    //将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //延迟1s后，再利用1s时间，让label回到原始位置
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}




/* 设置导航栏上面的内容 */
-(void)setupNav
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //中间标题
    TitleButton *titleBtn = [[TitleButton alloc]init];
    //设置标题文字
    NSString *name = [AccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;

}


-(void) titleClick:(UIButton *)button
{
    // 1.创建下拉菜单
    DropDownMenu *menu = [DropDownMenu menu];
    menu.delegate = self;
    // 2.设置内容
    TitleMenuController *vc = [[TitleMenuController alloc]init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    
    //3.显示
    [menu showFrom:button];
}

#pragma mark - HWDropdownMenuDelegate
/**
 *  下拉菜单被销毁
 */

-(void)dropDownMenuDidDismiss:(DropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

/**
 *  下拉菜单显示
 */
-(void)dropDownMenuDisShow:(DropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}


- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}

#pragma mark - tableViewDelegate & tableViewDataSource
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuesFrame.count;
}
// 行高,调用顺序比cellForRowAtIndexPath方法优先
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frame = self.statuesFrame[indexPath.row];
    return frame.cellHeight;
}

// 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

// Cell循环利用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statuesFrame[indexPath.row];
    return cell;
}
//
//-(void) scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //如果tableView还没有数据，就直接返回
//    if(self.statuesFrame.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
//    CGFloat offsetY = scrollView.contentOffset.y;
//    //当最后一个cell完全显示在眼前是，contentOffset的y值
//    CGFloat judgeOffsetY = scrollView.contentSize.height +scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
//    if(offsetY >= judgeOffsetY)   //最后一个cell完全进入视野范围内
//    {
//        //显示footer
//        self.tableView.tableFooterView.hidden = NO;
//        //加载更多的数据
//        [self loadMoreStatus];
//    }
//}


@end
