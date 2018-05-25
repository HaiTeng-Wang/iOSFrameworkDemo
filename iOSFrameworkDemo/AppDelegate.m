//
//  AppDelegate.m
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/23.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "AppRouter.h"

extern CFAbsoluteTime StartTime;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[RootViewController alloc] init];

    [AppRouter registered];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"App启动时间--%f",(CFAbsoluteTimeGetCurrent()-StartTime));
    });
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 通过路由进入App指定页面
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 通过路由进入App指定页面
    return YES;
}

@end
