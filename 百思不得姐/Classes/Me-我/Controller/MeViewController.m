//
//  MeViewController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/12.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "MeViewController.h"

@implementation MeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationUI];
    // 设置背景色
    self.view.backgroundColor = HLGlobalBg;
}
- (void)setNavigationUI
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highLightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
}
- (void)settingClick
{
    HLLogFunc;
}

- (void)moonClick
{
    HLLogFunc;
}
@end
