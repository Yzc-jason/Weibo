//
//  Status.h
//  仿微博
//
//  Created by Yzc on 15/11/6.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject
/**	string	字符串型的用户ID*/
@property (nonatomic, copy) NSString *idstr;
/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/**	string	微博信息内容  带有属性的文字*/
@property (nonatomic, copy) NSAttributedString *attributedText;


/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) User *user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;
/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property(nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property(nonatomic, strong) Status *retweeted_status;

/**	string	被微博信息内容  带有属性的文字*/
@property (nonatomic, copy) NSAttributedString *retweeted_attributedText;


/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
