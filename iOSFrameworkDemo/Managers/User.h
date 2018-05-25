//
//  User.h
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/25.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户
 */
@interface User : NSObject

+ (instancetype)shared;

@property (nonatomic, getter=islogin) BOOL login;

@end
