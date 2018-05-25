//
//  AppRouter.m
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/23.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "AppRouter.h"
#import "User.h"
#import "ViewControllers.h"

NSString *const AppScheme = @"AppScheme";

static BOOL PageAnimated = YES;
static BOOL HidesBottomBarWhenPushed = NO;
static OpenMethod PageOpenMethod = Push;

@implementation AppRouter

#pragma mark - Public

#pragma mark registered

+ (void)registered
{
    [[self routingTable] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyStr = [NSString stringWithFormat:@"%@",key];
        NSString *objcStr = [NSString stringWithFormat:@"%@",obj];
        NSString *urlStr = [NSString stringWithFormat:@"%@://%@",AppScheme,objcStr];

        if ([keyStr isEqualToString:@"首页"]) {
            [[HHRouter shared] map:urlStr toControllerClass:[HomePageViewController class]];
        }
        if ([keyStr isEqualToString:@"产品列表"]) {
            [[HHRouter shared] map:urlStr toControllerClass:[ProductListViewController class]];
        }
        if ([keyStr isEqualToString:@"产品详情"]) {
            [[HHRouter shared] map:urlStr toControllerClass:[ProductDetailsViewController class]];
        }
        if ([keyStr isEqualToString:@"用户中心"]) {
            [[HHRouter shared] map:urlStr toControllerClass:[UserInfoViewController class]];
        }
        if ([keyStr isEqualToString:@"登录"]) {
            [[HHRouter shared] map:urlStr toControllerClass:[LoginViewController class]];
        }
        if ([keyStr isEqualToString:@"用户奖励"]) {
            [[HHRouter shared] map:urlStr toControllerClass:[UserRewardsViewController class]];
        }
    }];
}

#pragma mark open

+ (void)open:(PagePath)pagePath
{
    [self open:pagePath PageParams:@{}];
}

+ (void)open:(PagePath)pagePath PageParams:(NSDictionary *)pageParams
{
    NSURL *router = [self routeFromPagePath:pagePath PageParams:pageParams];
    [self openURL:router];
}

+ (void)openURL:(NSURL*)url
{
    // 这些页面需要登录才可进入(相当于一个拦截器)
    if (![[User shared] islogin]) {
        NSString *path = [self routingTable][@"用户奖励"];
        NSString *urlStr = [NSString stringWithFormat:@"%@://%@",AppScheme,path];
        NSURL *locationUrl = [NSURL URLWithString:urlStr];
        if ([url.path isEqualToString:locationUrl.path]) {
            [self presentLoginViewController];
            return;
        }
    }

    // 剩下的页面无需拦截
    UIViewController *targetViewController;
    UIViewController *currentViewController = getCurrentDisplayController();
    if ([url.scheme isEqualToString:AppScheme]) {
        targetViewController = [[HHRouter shared] matchController:[NSString stringWithFormat:@"%@",url]];

    } else {
        targetViewController = [[WebViewController alloc] initWithUrl:url];
    }
    targetViewController.hidesBottomBarWhenPushed = HidesBottomBarWhenPushed;
    switch (PageOpenMethod) {
        case Push:{
            [currentViewController.navigationController pushViewController:targetViewController animated:PageAnimated];
        }
            break;
        case Present:{
            [currentViewController presentViewController:targetViewController animated:PageAnimated completion:nil];
        }
            break;
    }

    // 恢复默认设置
    [self restoreDefaultConfiguration];
}

#pragma mark config

+ (void)setOpenMethod:(OpenMethod)method
{
    PageOpenMethod = method;
}

+ (void)setPageAnimated:(BOOL)animate
{
    PageAnimated = animate;
}

+ (void)setTargetViewControllerHidesBottomBarWhenPushed:(BOOL)hidden
{
    HidesBottomBarWhenPushed = hidden;
}

#pragma mark - private

+ (void)restoreDefaultConfiguration
{
    PageOpenMethod = Push;
    PageAnimated = YES;
    HidesBottomBarWhenPushed = NO;
}

+ (void)presentLoginViewController
{
    NSString *path = [self routingTable][@"登录"];
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@",AppScheme,path];
    UIViewController *targetViewController = [[HHRouter shared] matchController:urlStr];
    UIViewController *currentViewController = getCurrentDisplayController();
    [currentViewController presentViewController:targetViewController animated:YES completion:nil];
}

+ (NSDictionary *)routingTable
{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RoutingTable" ofType:@"plist"]];
}

+ (NSURL *)routeFromPagePath:(PagePath)path PageParams:(NSDictionary *)pageParams
{
    NSString *pathComponent;
    NSString *pageParamsStr =[self pageParamsStrFromParamsDictionary:pageParams];
    switch (path) {
        case Home:{
            pathComponent = [self routingTable][@"首页"];
        }
            break;
        case ProductList:{
            pathComponent = [self routingTable][@"产品列表"];
        }
            break;
        case ProductDeatils:{
            pathComponent = [self routingTable][@"产品详情"];
        }
            break;
        case UserInfo:{
            pathComponent = [self routingTable][@"用户中心"];
        }
            break;
        case Login:{
            pathComponent = [self routingTable][@"登录"];
        }
            break;
        case UserRewards:{
            pathComponent = [self routingTable][@"用户奖励"];
        }
            break;
    }

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@%@",AppScheme,pathComponent,pageParamsStr]];
}

+ (NSString *)pageParamsStrFromParamsDictionary:(NSDictionary *)paramsDic
{
    if (paramsDic == nil || paramsDic.count == 0) { return @"";}

    NSMutableString *paramsStr = [NSMutableString stringWithFormat:@"?"];

    [paramsDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyStr = [NSString stringWithFormat:@"%@",key];
        NSString *objStr = [NSString stringWithFormat:@"%@",obj];
        NSString *param = [NSString stringWithFormat:@"%@=%@&",keyStr,objStr];
        [paramsStr appendString:param];
    }];

    NSString *lastCharacter = [paramsStr substringFromIndex:paramsStr.length - 1];

    if ([lastCharacter isEqualToString:@"&"]) {
        paramsStr = [[paramsStr substringToIndex:paramsStr.length - 1] mutableCopy];
    }

    return [paramsStr copy];
}

#pragma mark - 获取当前显示的控制器

UIWindow *getCurrentWindow(UIWindow *window)
{
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                return tmpWin;
            }
        }
    }
    return window;
}

UIViewController *getAvailableViewController(UIViewController *viewController)
{
    UIViewController *result;

    if ([viewController presentedViewController]) {
        UIViewController *controller = viewController.presentedViewController;
        result = getAvailableViewController(controller);
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nvc = (UINavigationController *) viewController;
        UIViewController *controller = nvc.topViewController;
        result = getAvailableViewController(controller);
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *) viewController;
        UIViewController *controller = tab.selectedViewController;
        result = getAvailableViewController(controller);
    } else {
        result = viewController;
    }
    return result;
}

UIViewController *_Nullable getCurrentDisplayController(void)
{
    UIWindow *window = getCurrentWindow([[UIApplication sharedApplication] keyWindow]);
    UIViewController *controller = window.rootViewController;
    UIViewController *vc = getAvailableViewController(controller);
    return vc;
}

@end
