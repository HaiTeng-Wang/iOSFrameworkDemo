//
//  AppRouter.h
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/23.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HHRouter.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN UIViewController * _Nullable getCurrentDisplayController(void);

typedef NS_ENUM(NSInteger, OpenMethod) {
    Push,
    Present
};

typedef NS_ENUM(NSInteger, PagePath) {
    Home,
    ProductList,
    ProductDeatils,
    UserInfo,
    UserRewards,
    Login
};

/**
 App路由器
 */
@interface AppRouter : NSObject

///-------------------------------
/// @name 注册
/// 全工程只需注册一次，注册之后才可以打开页面
///-------------------------------

+ (void)registered;

///-------------------------------
/// @name 跳转
/// 根据路径或URL打开页面
///-------------------------------

+ (void)open:(PagePath)pagePath;

+ (void)open:(PagePath)pagePath PageParams:(NSDictionary *)pageParams;

+ (void)openURL:(NSURL*)url;

///-------------------------------
/// @name 配置
/// 如果要改变默认配置，需要先配置。所有的配置仅影响这一次操作！下一次open仍是默认配置。
/**
 例如：
 [AppRouter setOpenMethod:Present];
 [AppRouter open:Login];
 */
///-------------------------------

/// 设置跳转方式，默认Push
+ (void)setOpenMethod:(OpenMethod)method;

/// 设置是否开启跳转动画，默认YES
+ (void)setPageAnimated:(BOOL)animate;

/// 目标控制器是否隐藏底部栏，默认NO
+ (void)setTargetViewControllerHidesBottomBarWhenPushed:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
