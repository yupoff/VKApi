//
//  AccessToken.m
//  FlatStackTestTask
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "AccessToken.h"

static NSString *const kToken = @"token";
static NSString *const kExpiresIn = @"expires_in";
static NSString *const kUserId = @"user_id";
static NSString *const kCreated = @"created";
static NSString *const kScope = @"scope";

@interface AccessToken ()
@property (strong, nonatomic) NSString *token;
@end

@implementation AccessToken

- (instancetype)initWithAccessToken:(NSString *)token expiresIn:(NSInteger)expiresIn userId:(NSString *)userId scope:(NSArray *)scope
{
    return [self initWithAccessToken:token expiresIn:expiresIn userId:userId scope:scope created:[[NSDate date] timeIntervalSince1970]];
}

- (instancetype)initWithAccessToken:(NSString *)token expiresIn:(NSInteger)expiresIn userId:(NSString *)userId scope:(NSArray *)scope created:(NSTimeInterval)created
{
    self = [super init];
    if (self) {
        _token = token;
        _expiresIn = expiresIn;
        _userId = userId;
        _scope = scope;
        _created = created;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _token = [coder decodeObjectForKey:kToken];
        _expiresIn = [coder decodeIntegerForKey:kExpiresIn];
        _userId = [coder decodeObjectForKey:kUserId];
        _created = [coder decodeDoubleForKey:kCreated];
        _scope = [coder decodeObjectForKey:kScope];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if (self.token)
    {
        [aCoder encodeObject:self.token forKey:kToken];
    }
    if (self.userId)
    {
        [aCoder encodeObject:self.userId forKey:kUserId];
    }
    if (self.scope)
    {
        [aCoder encodeObject:self.scope forKey:kScope];
    }
    [aCoder encodeInteger:self.expiresIn forKey:kExpiresIn];
    [aCoder encodeDouble:self.created forKey:kCreated];
}

- (NSString *)token
{
    if(_token && self.isExpired)
    {
        
    }
    return _token;
}

- (BOOL)isExpired {
    return self.expiresIn > 0 && self.expiresIn + self.created < [[NSDate date] timeIntervalSince1970];
}



@end
