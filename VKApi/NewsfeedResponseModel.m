//
//  NewsfeedResponseModel.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "NewsfeedResponseModel.h"


@implementation NewsfeedResponseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.items = [self getArrayNewsResponseModel:dict[@"items"]];
        self.profiles = [self getArrayProfileResponseModel:dict[@"profiles"]];
        self.groups = [self getArrayGroupResponseModel:dict[@"groups"]];
        self.nextFrom = dict[@"next_from"];
    }
    return self;
}

-(NSArray <NewsResponseModel *> *)getArrayNewsResponseModel:(NSArray *)array
{
    NSMutableArray <NewsResponseModel *> *arrayNewsResponseModel = [[NSMutableArray <NewsResponseModel *>  alloc]init];
    for (NSDictionary *dict in array) {
        NewsResponseModel *newsResponseModel = [[NewsResponseModel alloc]initWithDictionary:dict];
        if (newsResponseModel) {
            [arrayNewsResponseModel addObject:newsResponseModel];
        }
    }
    return [arrayNewsResponseModel copy];
}

-(NSArray <ProfileResponseModel *> *)getArrayProfileResponseModel:(NSArray *)array
{
    NSMutableArray <ProfileResponseModel *> *arrayProfileResponseModel = [[NSMutableArray <ProfileResponseModel *>  alloc]init];
    for (NSDictionary *dict in array) {
        ProfileResponseModel *profileResponseModel = [[ProfileResponseModel alloc]initWithDictionary:dict];
        if (profileResponseModel) {
            [arrayProfileResponseModel addObject:profileResponseModel];
        }
    }
    return [arrayProfileResponseModel copy];
}

-(NSArray <GroupResponseModel *> *)getArrayGroupResponseModel:(NSArray *)array
{
    NSMutableArray <GroupResponseModel *> *arrayGroupResponseModel = [[NSMutableArray <GroupResponseModel *>  alloc]init];
    for (NSDictionary *dict in array) {
        GroupResponseModel *groupResponseModel = [[GroupResponseModel alloc]initWithDictionary:dict];
        if (groupResponseModel) {
            [arrayGroupResponseModel addObject:groupResponseModel];
        }
    }
    return [arrayGroupResponseModel copy];
}


- (NSString *)getAuthorNameById:(NSNumber *)profileId
{
    if ([profileId doubleValue] >= 0)
    {
        for (ProfileResponseModel *user in self.profiles)
        {
            if ([user.profileId isEqualToNumber:profileId])
            {
                return [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
            }
        }
    }
    else
    {
        for (GroupResponseModel *group in self.groups)
        {
            if ([group.groupId isEqualToNumber:[NSNumber numberWithDouble:fabs([profileId doubleValue])]])
            {
                return group.name;
            }
        }
    }
    return nil;
}

- (NSString *)getAvatarById:(NSNumber *)profileId
{
    if ([profileId doubleValue] >= 0)
    {
        for (ProfileResponseModel *user in self.profiles)
        {
            if ([user.profileId isEqualToNumber:profileId])
            {
                return user.photo;
            }
        }
    }
    else
    {
        for (GroupResponseModel *group in self.groups)
        {
            if ([group.groupId isEqualToNumber:[NSNumber numberWithDouble:fabs([profileId doubleValue])]])
            {
                return group.photo;
            }
        }
    }
    return nil;
}

@end
