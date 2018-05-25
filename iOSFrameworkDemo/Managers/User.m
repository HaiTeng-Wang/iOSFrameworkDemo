//
//  User.m
//  iOSFrameworkDemo
//
//  Created by Hunter on 2018/5/25.
//  Copyright © 2018 Hunter. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)shared
{
    static User *user = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (!user) {
            user = [[self alloc] init];
        }
    });
    return user;
}


@end
