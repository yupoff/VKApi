//
//  NewsDataSource.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDataSource : NSObject

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) NSString *startFrom;

- (void)updateDataSource:(void (^)(NSArray *dataSource))succes onFailure:(void (^)(NSError *error))failure;
- (News *)getNewsAtIndexPath:(NSIndexPath *)indexPath;
@end
