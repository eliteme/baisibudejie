//
//  MainTabBarController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/12.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "MainTabBarController.h"
#import "EssenceViewController.h"
#import "MeViewController.h"
#import "FriendTrendsViewController.h"
#import "NewViewController.h"
#import "MainNavigationController.h"
#import "MainTabBar.h"
@implementation MainTabBarController
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildViewControllers];
}

- (void)addChildViewControllers
{
   
    /*
     tabBar_essence_icon
     tabBar_essence_click_icon
     tabBar_new_icon
     tabBar_new_click_icon
     tabBar_friendTrends_icon
     tabBar_friendTrends_click_icon"
     tabBar_me_icon"
     tabBar_me_click_icon"
     */
    
    [self addChildViewController:[[EssenceViewController alloc] init] title:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    [self addChildViewController:[[NewViewController alloc] init] title:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    [self addChildViewController:[[FriendTrendsViewController alloc] init] title:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:[[MeViewController alloc] init] title:@"我" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];

    // 更换tabBar
    [self setValue:[[MainTabBar alloc] init] forKeyPath:@"tabBar"];
    
}
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVC.navigationItem.title = title;
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:mainNav];
    
}

@end
