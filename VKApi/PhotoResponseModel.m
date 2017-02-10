//
//  PhotoResponseModel.m
//  VKApi
//
//  Created by Тимур Аюпов on 10.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import "PhotoResponseModel.h"

@implementation PhotoResponseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.photoId = dict[@"id"];
        self.photo = dict[@"photo_604"];
        self.photoSmall = dict[@"photo_130"];
        self.height = dict[@"height"];
        self.width = dict[@"width"];
    }
    return self;
}

@end
