//
//  HomePageViewController.m
//  TestPriveRepoSpec
//
//  Created by Hunter on 2018/5/14.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "HomePageViewController.h"
#import "AppRouter.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"首页"];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"进入WebView" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn addTarget:self action:@selector(goWebView:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.frame = CGRectMake(100, 200, 200, 50);
    [self.view addSubview:loginBtn];
}

- (void)goWebView:(UIButton *)sender{
    [AppRouter setTargetViewControllerHidesBottomBarWhenPushed:YES];
    [AppRouter openURL:[NSURL URLWithString:@"https://github.com/HaiTeng-Wang"]];
}
@end
