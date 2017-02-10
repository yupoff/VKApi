//
//  ServerManager.h
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AuthorizationState) {
    AuthorizationStateAuthorized,
    AuthorizationStateNotAuthorized
};

@class NewsfeedResponseModel;

@protocol ServerManagerDelegate <NSObject>

- (void)authorizationComplete;
- (void)authorizationFailed;
- (void)presentViewController:(UIViewController *)controller;

@end

@protocol AuthorizeControllerDelegate;

@interface ServerManager : NSObject 

@property (nonatomic, strong) NSString *clientId;
@property (weak, nonatomic) id <ServerManagerDelegate> delegate;
@property (strong, nonatomic, readonly) id user;

+ (ServerManager *)sharedManager;

+ (void)authorizeUser:(NSArray *)scope;
+ (void)tryResumeLastSessionCompletion:(void (^)(AuthorizationState state))completion;

- (void)getRequest:(NSString *)method withParams:(NSDictionary *)params onSuccess:(void (^) (id responseObject))success onFailure:(void(^)(NSError *error))failure;

+ (void)clearSession;

@end
