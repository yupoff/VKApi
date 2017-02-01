//
//  Photo.m
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Photo.h"

@implementation Photo
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
