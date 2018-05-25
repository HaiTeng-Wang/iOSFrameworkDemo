//
//  WebViewController.m
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/24.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
        self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return self;
}

- (void)loadView{
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)dealloc{
    
}

@end
