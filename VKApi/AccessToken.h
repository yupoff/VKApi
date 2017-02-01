//
//  AccessToken.h
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expirationDate;
@property (strong, nonatomic) NSString *userId;
@end
