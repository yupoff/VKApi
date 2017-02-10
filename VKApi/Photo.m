//
//  Photo.m
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Photo.h"

@implementation Photo

+ (NSArray *)requiredProperties {
    return @[@"photoId"];
}

+(NSString *)primaryKey {
    return @"photoId";
}

@end
