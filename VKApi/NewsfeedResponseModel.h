//
//  NewsfeedResponseModel.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsResponseModel.h"
#import "ProfileResponseModel.h"
#import "GroupResponseModel.h"

@interface NewsfeedResponseModel : NSObject

@property (strong, nonatomic) NSArray <NewsResponseModel *> *items;
@property (strong, nonatomic) NSArray <ProfileResponseModel *> *profiles;
@property (strong, nonatomic) NSArray <GroupResponseModel *> *groups;
@property (strong, nonatomic) NSString *nextFrom;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSString *)getAuthorNameById:(NSNumber *)profileId;
- (NSString *)getAvatarById:(NSNumber *)profileId;

@end
