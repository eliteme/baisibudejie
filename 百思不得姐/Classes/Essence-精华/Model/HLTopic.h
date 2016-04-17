//
//  HLTopic.h
//  百思不得姐
//
//  Created by 索留元 on 16/4/16.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLTopic : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为Vip */
@property (nonatomic, assign, getter=is_sinaVip) BOOL is_vip;

@end
