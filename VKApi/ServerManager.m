//
//  ServerManager.m
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "ServerManager.h"
#import "AuthorizeController.h"
#import "AccessToken.h"
#import "NewsfeedResponseModel.h"
#import "AFNetworking.h"

static NSString *const VERSION_API = @"5.53";

@interface ServerManager () <AuthorizeControllerDelegate>
@property (strong, nonatomic) AccessToken *accessToken;
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

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseURL =  [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestOperationManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
        self.accessToken = [[AccessToken alloc]init];
    }
    return self;
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

-(void)getNewsWithParams:(NSDictionary *)params onSuccess:(void (^) (NewsfeedResponseModel *responseModel))success onFailure:(void(^)(NSError *error, NSInteger statusCode))failure
{
    NSMutableDictionary *mutableParams = [params mutableCopy];
    [mutableParams setObject:self.accessToken.token forKey:@"access_token"];
    [mutableParams setObject:VERSION_API forKey:@"v"];
	[self.requestOperationManager GET:@"newsfeed.get" parameters:mutableParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsfeedResponseModel *responseModel = [[NewsfeedResponseModel alloc]initWithDictionary:responseObject[@"response"]];
        success(responseModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - AuthorizeControllerDelegate methods

-(void)authorizeCompleteWithToken:(AccessToken *)accessToken
{
    if (accessToken) {
        self.accessToken = accessToken;
        [self.delegate authorizationComplete];
    }
    else {
        [self.delegate authorizationFailed];
    }
}

@end
