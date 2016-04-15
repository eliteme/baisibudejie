//
//  MainTabBar.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/12.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "MainTabBar.h"
@interface MainTabBar()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation MainTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;

    }
    return self;
}
- (void)publishClick
{
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
            continue;
        }
        CGFloat buttonX = buttonW *((index > 1) ? (index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //索引++
        index++;
        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    added = YES;

}
- (void)buttonClick
{
    
}
@end
