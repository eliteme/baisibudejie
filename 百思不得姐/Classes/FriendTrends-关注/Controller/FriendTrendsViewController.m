//
//  FriendTrendsViewController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/12.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "FriendTrendsViewController.h"
#import "RecommendViewController.h"
#import "LoginRegisterViewController.h"

@interface FriendTrendsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end
@implementation FriendTrendsViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
   
}
- (IBAction)login:(id)sender {
    
    LoginRegisterViewController *loginRegisterVC = [[LoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad ];
    [self setNavigationUI];
    // 设置背景色
    self.view.backgroundColor = HLGlobalBg;
}
- (void)setNavigationUI
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highLightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
}
- (void)friendsClick
{
    HLLogFunc;
    RecommendViewController *rVC = [[RecommendViewController alloc] init];
    [self.navigationController pushViewController:rVC animated:YES];
}

@end
