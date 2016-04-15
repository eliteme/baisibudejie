//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/12.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "EssenceViewController.h"
#import "RecommendTagsViewController.h"
@implementation EssenceViewController
- (void)viewDidLoad

{
    [super viewDidLoad];
    [self setNavigationUI];
    self.view.backgroundColor = HLGlobalBg;
}
#pragma mark -   设置导航栏标题
- (void)setNavigationUI
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}
- (void)tagClick
{
    HLLogFunc;
    RecommendTagsViewController *rtVC = [[RecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:rtVC animated:YES];
}
@end
