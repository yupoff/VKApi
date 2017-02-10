//
//  ServerManager.m
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//
#import "ServerManager.h"

#import "AFNetworking.h"
#import <Realm/Realm.h>

#import "AccessToken.h"
#import "NewsfeedResponseModel.h"

#import "AuthorizeController.h"

#import "NSUserDefaults+Helper.h"

static NSString *const kVersionApi = @"5.53";
static NSString *const kURL = @"https://api.vk.com/method/";
static NSString *const kAccessToken = @"acces_token";

@interface ServerManager () <AuthorizeControllerDelegate>
@property (strong, nonatomic) AFHTTPSessionManager *requestOperationManager;
@end

@implementation ServerManager

+ (ServerManager *)sharedManager
{
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSURL *baseURL =  [NSURL URLWithString:kURL];
        self.requestOperationManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    }
    return self;
}

+ (void)tryResumeLastSessionCompletion:(void (^)(AuthorizationState state))completion
{
    AccessToken *accessToken = [NSUserDefaults getAccessTokenForKey:kAccessToken];
    if (!accessToken || accessToken.isExpired)
    {
        completion(AuthorizationStateNotAuthorized);
    }
    else
    {
        completion(AuthorizationStateAuthorized);
    }
}

+ (void)authorizeUser:(NSArray *)scope
{
    AuthorizeController *authorizeController = [[AuthorizeController alloc]init];
    authorizeController.delegate = [ServerManager sharedManager];
    authorizeController.clientId = [[ServerManager sharedManager]clientId];
    authorizeController.scope = scope;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:authorizeController];
    
    [[[ServerManager sharedManager] delegate] presentViewController:nav];
    
}

+ (void)clearSession
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    for (NSHTTPCookie *cookie in cookies)
        if (NSNotFound != [cookie.domain rangeOfString:@"vk.com"].location) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage]
             deleteCookie:cookie];
        }
    [NSUserDefaults removeToken:kAccessToken];
}

- (void)getRequest:(NSString *)method withParams:(NSDictionary *)params onSuccess:(void (^) (id responseObject))success onFailure:(void(^)(NSError *error))failure
{
    NSString *token = [self token];
    if (!token) {
        return;
    }
    NSMutableDictionary *mutableParams = [params mutableCopy];
    [mutableParams setObject:token forKey:@"access_token"];
    [mutableParams setObject:kVersionApi forKey:@"v"];
    params = [mutableParams copy];
	[self.requestOperationManager GET:method parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        if (responseObject[@"error"])
        {
            failure(nil);
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failure(error);
    }];
}

#pragma mark - AuthorizeControllerDelegate methods

- (void)authorizeCompleteWithToken:(AccessToken *)accessToken
{
    if (accessToken)
    {
        [NSUserDefaults saveAccessToken:accessToken forKey:kAccessToken];
        [self.delegate authorizationComplete];
    }
    else
    {
        [self.delegate authorizationFailed];
    }
}

#pragma mark - Helpers Method

- (NSString *)token
{
    AccessToken *accessToken = [NSUserDefaults getAccessTokenForKey:kAccessToken];
    if (accessToken.isExpired) {
        [ServerManager authorizeUser:accessToken.scope];
         [NSUserDefaults removeToken:kAccessToken];
        return nil;
    }
    return accessToken.token;
}

@end
