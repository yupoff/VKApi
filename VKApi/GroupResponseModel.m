//
//  GroupResponseModel.m
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "GroupResponseModel.h"

@implementation GroupResponseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.groupId = dict[@"id"];
        self.name = dict[@"name"];
        self.photo = dict[@"photo_50"];
    }
    return self;
}

@end
