//
//  LoginRegisterViewController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/15.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
    if (self.loginViewLeftMargin.constant == 0) {
       self.loginViewLeftMargin.constant = - self.view.width;
        sender.selected = YES;
    } else {
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;

    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}
- (IBAction)close:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
