//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/12.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "EssenceViewController.h"
#import "RecommendTagsViewController.h"

#import "HLTopicViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>

/** 标签底部的红色指示器*/
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签*/
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容*/
@property (nonatomic, weak) UIScrollView *contentView;
@end


@implementation EssenceViewController
//+ (void)initialize
//{}

- (void)viewDidLoad

{
    [super viewDidLoad];
    //setup Nav
    [self setNavigationUI];
    
    //initialize childViewController
    [self setupChildVces];
    
    //setup TitlesView
    [self setupTitlesView];
    
    //bottom scrollView
    [self setupContentView];
}

#pragma mark - initialize childViewController
- (void)setupChildVces
{
    HLTopicViewController *allVC = [[HLTopicViewController alloc] init];
    allVC.type = HLTopicTypeAll;
    [self addChildViewController:allVC];
    
    HLTopicViewController *vedioVC = [[HLTopicViewController alloc] init];
    vedioVC.type = HLTopicTypeVideo;
    [self addChildViewController:vedioVC];
    
    HLTopicViewController *voiceVC = [[HLTopicViewController alloc] init];
    voiceVC.type = HLTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    HLTopicViewController *pictureVC = [[HLTopicViewController alloc] init];
    pictureVC.type = HLTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    HLTopicViewController *wordVC = [[HLTopicViewController alloc] init];
    wordVC.type = HLTopicTypeWord;
    [self addChildViewController:wordVC];
}
#pragma mark - 设置标签栏
- (void)setupTitlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.tag = -1;
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部的子标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    for (int i = 0; i < titles.count ; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width ;
        button.x = i *width;
        button.y = 0;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titlesClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
        
        
        
    }
     [titlesView addSubview:indicatorView];
    
    
}
- (void)titlesClick:(UIButton *)sender
{
    self.selectedButton.enabled = YES;
    sender.enabled = NO;
    self.selectedButton = sender;
    [UIView animateWithDuration:0.5 animations:^{
       
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
    
    
    //scrollView滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = sender.tag *self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}
#pragma mark -   设置导航栏标题
- (void)setNavigationUI
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = HLGlobalBg;

}
- (void)tagClick
{
    HLLogFunc;
    RecommendTagsViewController *rtVC = [[RecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:rtVC animated:YES];
}
#pragma  mark - setupContentView
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width *self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20
//    //设置内边距
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView addSubview:vc.view];
    
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击
    NSInteger index = scrollView.contentOffset. x / scrollView.width;
    [self titlesClick:self.titlesView.subviews[index]];
}
@end
