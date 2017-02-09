//
//  AccessToken.h
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject <NSCoding>

@property (strong, readonly, nonatomic) NSString *token;
@property (assign, readonly, nonatomic) NSInteger expiresIn;
@property (strong, readonly, nonatomic) NSString *userId;
@property (assign, readonly, nonatomic) NSTimeInterval created;
@property (strong, readonly, nonatomic) NSArray *scope;
@property (assign, readonly, nonatomic) BOOL isExpired;

- (instancetype)initWithAccessToken:(NSString *)token expiresIn:(NSInteger)expiresIn userId:(NSString *)userId scope:(NSArray *)scope;

@end
