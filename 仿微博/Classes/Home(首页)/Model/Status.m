//
//  Status.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "Status.h"
#import "Photo.h"
#import "MJExtension.h"
#import "NSDate+Extension.h"

@implementation Status

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}

-(void)setSource:(NSString *)source
{
    if(source.length){
    NSRange range ;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
    }else{
        _source = @"";
    }
}

-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //微博创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    
    //日历对象（方便比较两个日期之间的差距）
    NSCalendar *calender = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calender components:unit fromDate:createDate toDate:now options:0];
    if([createDate isThisYear]){ //今年
        if([createDate isYesterday]){ //昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if([createDate isToday]){ //今天
            if(cmps.hour >= 1){
                return [NSString stringWithFormat:@"%d小时前",cmps.hour];
            }else if(cmps.minute >= 1){
                return [NSString stringWithFormat:@"%d分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
                
        }else{  //今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
        
    }else{  //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}
@end
