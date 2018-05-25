//
//  LoginViewController.m
//  TestPriveRepoSpec
//
//  Created by Hunter on 2018/5/14.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "LoginViewController.h"
#import "AppRouter.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录页";
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"%@",self.params);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[User shared] setLogin:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
