//
//  NewsService.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.02.17.
//  Copyright © 2017 Тимур Аюпов. All rights reserved.
//

#import "NewsService.h"

#import "ServerManager.h"

#import "NewsfeedResponseModel.h"

@interface NewsService ()
@property (strong, nonatomic) NSArray *news;
@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) NSString *startFrom;
@end

@implementation NewsService

- (News *)getNewsAtIndex:(NSInteger)index
{
    return self.news[index];
}

- (void)loadNews
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"post", @"filter",
                                   @"20", @"count",
                                   nil];
    if (self.startFrom)
    {
        [params setObject:self.startFrom forKey:@"start_from"];
    }
    
    [[ServerManager sharedManager] getRequest:@"newsfeed.get" withParams:params onSuccess:^(id responseObject) {
        NewsfeedResponseModel *responseModel = [[NewsfeedResponseModel alloc]initWithDictionary:responseObject[@"response"]];
        self.startFrom = responseModel.nextFrom;
        NSMutableArray *newsMutable = [NSMutableArray arrayWithArray:self.news];
        [newsMutable addObjectsFromArray:[self serializeDataSourceFromModel:responseModel]];
        self.news = [newsMutable copy];
        self.count = [self.news count];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsLoadedNotification object:nil];
    } onFailure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsLoadedNotification object:nil];
    }];
}

#pragma mark - Helpers Methods

- (NSArray *)serializeDataSourceFromModel:(NewsfeedResponseModel *)model
{
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < model.items.count; i++)
    {
        News *news = [[News alloc] init];
        news.text = model.items[i].text;
        news.date = [NSDate dateWithTimeIntervalSince1970:[model.items[i].date doubleValue]];
        news.photos = model.items[i].photos;
        news.author = [model getAuthorNameById:model.items[i].sourceId];
        news.avatar = [model getAvatarById:model.items[i].sourceId];
        [dataSource addObject:news];
    }
    return [dataSource copy];
}

@end
