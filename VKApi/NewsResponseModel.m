//
//  NewsResponseModel.m
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "NewsResponseModel.h"
#import "Photo.h"

@implementation NewsResponseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.sourceId = dict[@"source_id"];
        self.date = dict[@"date"];
        self.text = dict[@"text"];
        NSMutableArray <Photo *> *mutablePhotos = [NSMutableArray <Photo *> array];
        for (NSDictionary *attachmentsDict in dict[@"attachments"])
        {
            if ([attachmentsDict[@"type"] isEqualToString:@"photo"])
            {
                Photo *photo = [[Photo alloc] initWithDictionary:attachmentsDict[@"photo"]];
                [mutablePhotos addObject:photo];
            }
        }
        self.photos = [mutablePhotos copy];
    }
    return self;
}

@end
