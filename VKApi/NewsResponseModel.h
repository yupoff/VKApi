//
//  NewsResponseModel.h
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoResponseModel;

@interface NewsResponseModel : NSObject

@property (assign, nonatomic) NSNumber *newsId;
@property (assign, nonatomic) NSNumber *sourceId;
@property (strong, nonatomic) NSNumber *date;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray <PhotoResponseModel *> *photos;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
