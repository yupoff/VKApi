//
//  News.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface News : NSObject
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSArray <Photo *> *photos;
@end
