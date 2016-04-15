//
//  RecommendCategory.h
//  百思不得姐
//
//  Created by 索留元 on 16/4/14.
//  Copyright © 2016年 dianer. All rights reserved.
// 推荐关注--左边的数据模型

#import <Foundation/Foundation.h>

@interface RecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;

/** count */
@property (nonatomic, assign) NSInteger count;

/** name */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;


@end
