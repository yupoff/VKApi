//
//  NSUserDefaults+TokenHelper.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccessToken;

@interface NSUserDefaults (TokenHelper)

+ (void)saveAccessToken:(AccessToken *)accessToken forKey:(NSString *)key;

+ (AccessToken *)getAccessTokenForKey:(NSString *)key;

+ (void)removeToken:(NSString *)key;
@end
