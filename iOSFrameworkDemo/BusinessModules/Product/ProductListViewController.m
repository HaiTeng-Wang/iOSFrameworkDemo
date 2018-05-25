//
//  ProductListViewController.m
//  TestPriveRepoSpec
//
//  Created by Hunter on 2018/5/14.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "ProductListViewController.h"
#import "AppRouter.h"

@interface ProductListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"产品列表"];
    self.view.backgroundColor = [UIColor whiteColor];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;

    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor redColor];
    tableView.tableHeaderView = headerView;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, tableView.frame.size.width, 300);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderView = [UIView new];
    sectionHeaderView.backgroundColor = [UIColor yellowColor];
    return sectionHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [AppRouter setTargetViewControllerHidesBottomBarWhenPushed:YES];
    [AppRouter open:ProductDeatils PageParams:@{@"productID":@(666666)}];
}

@end
