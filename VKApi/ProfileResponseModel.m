//
//  ProfileResponseModel.m
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "ProfileResponseModel.h"

@implementation ProfileResponseModel
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.profileId = dict[@"id"];
        self.firstName = dict[@"first_name"];
        self.lastName = dict[@"last_name"];
        self.photo = dict[@"photo_50"];
    }
    return self;
}
@end
