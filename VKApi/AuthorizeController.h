//
//  AuthorizeController.h
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccessToken;
@protocol AuthorizeControllerDelegate <NSObject>

-(void)authorizeCompleteWithToken:(AccessToken *)accessToken;

@end

@interface AuthorizeController : UIViewController
@property (weak, nonatomic) id <AuthorizeControllerDelegate> delegate;
@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSArray *scope;
@end
