//
//  ProductDetailsViewController.m
//  TestPriveRepoSpec
//
//  Created by Hunter on 2018/5/14.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "AppRouter.h"

@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情";
    self.view.backgroundColor = [UIColor brownColor];
    NSLog(@"%@",self.params);
}

@end
