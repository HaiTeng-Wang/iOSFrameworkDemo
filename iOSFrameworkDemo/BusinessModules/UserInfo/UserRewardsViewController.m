//
//  UserRewardsViewController.m
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/24.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "UserRewardsViewController.h"
#import "AppRouter.h"

@interface UserRewardsViewController ()

@end

@implementation UserRewardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的奖励";
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [AppRouter open:ProductDeatils];
}

@end
