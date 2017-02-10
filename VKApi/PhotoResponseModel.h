//
//  PhotoResponseModel.h
//  VKApi
//
//  Created by Тимур Аюпов on 10.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoResponseModel : NSObject

@property (strong, nonatomic) NSNumber *photoId;
@property (strong, nonatomic) NSString *photoSmall;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *width;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
