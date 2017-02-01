//
//  ProfileResponseModel.h
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileResponseModel : NSObject
@property (strong, nonatomic) NSNumber *profileId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *photo;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
