//
//  NSUserDefaults+TokenHelper.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import "NSUserDefaults+TokenHelper.h"

#import "AccessToken.h"

@implementation NSUserDefaults (TokenHelper)

+ (void)saveAccessToken:(AccessToken *)accessToken forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedAccessToken = [NSKeyedArchiver archivedDataWithRootObject:accessToken];
    [userDefaults setObject:encodedAccessToken forKey:key];
    [userDefaults synchronize];
}

+ (AccessToken *)getAccessTokenForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedAccessToken = [userDefaults objectForKey:key];
    AccessToken *accessToken = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAccessToken];
    return accessToken;
}

+ (void)removeToken:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

@end
