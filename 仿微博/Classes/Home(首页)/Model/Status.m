//
//  Status.m
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//


#import "Status.h"
#import "UIKit/UIKit.h"
#import "Photo.h"
#import "User.h"
#import "MJExtension.h"
#import "NSDate+Extension.h"
#import "RegexKitLite.h"
#import "TextPart.h"
#import "EmotionTool.h"
#import "Emoition.h"
#import "Special.h"

@implementation Status

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}
-(NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    NSMutableArray *parts = [NSMutableArray array];
    //遍历所有的特殊字符串
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if((*capturedRanges).length == 0) return ;
        
        TextPart *part = [[TextPart alloc]init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    //遍历所有的非特殊字符串
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if((*capturedRanges).length == 0) return ;
        
        TextPart *part = [[TextPart alloc]init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    [parts sortUsingComparator:^NSComparisonResult(TextPart *part1, TextPart *part2) {
        if(part1.range.location > part2.range.location)
        {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
    UIFont *font =[UIFont systemFontOfSize:14];
    NSMutableArray *specials = [NSMutableArray array];
    //按顺序拼接文字
    for (TextPart *part in parts) {
        NSAttributedString *subStr = nil;
        if(part.isEmotion)
        { //表情
            NSTextAttachment *attch = [[NSTextAttachment alloc]init];
            NSString *name =[EmotionTool emotionWithChs:part.text].png;
            if(name)
            { //找到相应图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                subStr = [NSAttributedString attributedStringWithAttachment:attch];
            }else{ //表情图片不存在
                subStr = [[NSAttributedString alloc]initWithString:part.text];
            }
        }else  if(part.special){ //非表情特殊文字
            subStr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                            NSForegroundColorAttributeName : [UIColor redColor]
                                                        }];
            Special *special = [[Special alloc]init];
            special.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            special.range = NSMakeRange(loc, len);
            [specials addObject:special];
        }else{//非特殊文字
            subStr = [[NSAttributedString alloc]initWithString:part.text];

        }
        [attributedText appendAttributedString:subStr];
    }
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    return attributedText;
}

-(void)setText:(NSString *)text
{
    _text = [text copy];
    self.attributedText = [self attributedTextWithText:text];
}

-(void)setRetweeted_status:(Status *)retweeted_status
{
    _retweeted_status = retweeted_status;
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name,retweeted_status.text];
    self.retweeted_attributedText = [self attributedTextWithText:retweetContent];
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
