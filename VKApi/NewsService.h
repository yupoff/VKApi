//
//  NewsService.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"

static NSString *const kNewsServiceNewsLoadedNotification = @"news_loaded_notification";
static NSString *const kNewsServiceNewsNextLoadedNotification = @"news_next_loaded_notification";
static NSString *const kNewsServiceNewsFailedLoadNotification = @"news_failed_load";

@interface NewsService : NSObject

@property (strong, readonly, nonatomic) NSArray *news;

- (News *)getNewsAtIndex:(NSInteger)index;
- (void)loadNews;- (void)loadNextNews;

- (void)logout;
@end
