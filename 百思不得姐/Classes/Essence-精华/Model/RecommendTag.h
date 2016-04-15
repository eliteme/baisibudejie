//
//  RecommendTag.h
//  百思不得姐
//
//  Created by 索留元 on 16/4/14.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendTag : NSObject
/**
 *  image_list : http://img.spriteapp.cn/ugc/2014/12/08/193911_24529.png,
    theme_id : 61,
	theme_name : 恶搞,
	is_sub : 0,
	is_default : 0,
	sub_number : 1886908
 */

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅量 */
@property (nonatomic, assign) NSInteger sub_number;


@end
