//
//  StatusCell.h
//  仿微博
//
//  Created by Yzc on 15/11/8.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusFrame;
@interface StatusCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) StatusFrame *statusFrame;

@end
