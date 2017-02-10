//
//  NSUserDefaults+Helper.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccessToken;

@interface NSUserDefaults (Helper)

+ (void)saveAccessToken:(AccessToken *)accessToken forKey:(NSString *)key;

+ (AccessToken *)getAccessTokenForKey:(NSString *)key;

+ (void)removeToken:(NSString *)key;

+ (void)saveStartFrom:(NSString *)startFrom forKey:(NSString *)key;

+ (NSString *)getStartFromForKey:(NSString *)key;

+ (void)removeStartFrom:(NSString *)key;
@end
