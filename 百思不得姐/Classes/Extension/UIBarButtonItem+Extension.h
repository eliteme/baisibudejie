//
//  UIBarButtonItem+Extension.h
//  百思不得姐
//
//  Created by 索留元 on 16/4/13.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)imageName highLightImage:(NSString *)hightLightImageName target:(id)target action:(SEL)action;
@end
