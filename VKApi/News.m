//
//  News.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "News.h"

@implementation News

+ (NSArray *)requiredProperties {
    return @[@"newsId"];
}

+(NSString *)primaryKey {
    return @"newsId";
}

@end
