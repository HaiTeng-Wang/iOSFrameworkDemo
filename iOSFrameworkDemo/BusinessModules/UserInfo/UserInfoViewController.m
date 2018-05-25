//
//  UserInfoViewController.m
//  TestPriveRepoSpec
//
//  Created by Hunter on 2018/5/14.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AppRouter.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"用户中心"];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.frame = CGRectMake(100, 200, 100, 30);
    [self.view addSubview:loginBtn];
}

- (void)login:(UIButton *)sender{
    [AppRouter setTargetViewControllerHidesBottomBarWhenPushed:YES];
    [AppRouter open:UserRewards];
}

@end
