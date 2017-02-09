//
//  Photo.h
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSNumber *photoId;
@property (strong, nonatomic) NSString *photoSmall;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *width;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
