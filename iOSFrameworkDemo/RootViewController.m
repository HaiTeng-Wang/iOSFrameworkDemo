//
//  RootViewController.m
//  xjf
//
//  Created by yiban on 16/4/5.
//  Copyright © 2016年 lcb. All rights reserved.

#import "RootViewController.h"
#import "HomePageViewController.h"
#import "ProductListViewController.h"
#import "UserInfoViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedIndex = 0;
        self.tabBar.translucent = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewControllers];
}

- (void)setupAllChildViewControllers {
    HomePageViewController *vc1 = [[HomePageViewController alloc] init];
    [self setupChildViewController:vc1
            title:@"首页"
            imageName:@"tab_home"
            selectedImageName:@"tab_home_selected"];

    ProductListViewController *vc2 = [ProductListViewController new];
    [self setupChildViewController:vc2
                             title:@"产品列表"
                         imageName:@"tab_senior"
                 selectedImageName:@"tab_senior_selected"];

    UserInfoViewController *vc3 = [[UserInfoViewController alloc] init];
    [self setupChildViewController:vc3
            title:@"用户中心"
            imageName:@"tab_live"
            selectedImageName:@"tab_live_selected"];
}

- (void)setupChildViewController:(UIViewController *)childVc
                           title:(NSString *)title
                       imageName:(NSString *)imageName
               selectedImageName:(NSString *)selectedImageName {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBar.translucent = NO;
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title
            image:[UIImage imageNamed:imageName]
            selectedImage:[UIImage imageNamed:selectedImageName]];
    item.titlePositionAdjustment = UIOffsetMake(0, -4.5f);
    nav.tabBarItem = item;
    [self addChildViewController:nav];
}

@end
