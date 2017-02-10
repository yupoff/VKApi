//
//  Photo.h
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface Photo : RLMObject

@property (strong, nonatomic) NSNumber<RLMInt> *photoId;
@property (strong, nonatomic) NSString *photoSmall;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSNumber<RLMFloat> *height;
@property (strong, nonatomic) NSNumber<RLMFloat> *width;

@end
RLM_ARRAY_TYPE(Photo)
