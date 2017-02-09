//
//  GroupResponseModel.h
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupResponseModel : NSObject

@property (strong, nonatomic) NSNumber *groupId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *photo;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
