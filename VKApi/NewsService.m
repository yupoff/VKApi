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

#import "NSUserDefaults+Helper.h"

static NSString *const kNewsStartFromKey = @"news_start_from";

@interface NewsService ()
@property (strong, nonatomic) NSArray *news;
@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) NSString *startFrom;
@property (strong, nonatomic) NSArray *cachedNews;
@property (strong, nonatomic) NSDictionary *params;
@end

@implementation NewsService

- (instancetype)init
{
    self = [super init];
    if (self) {
        RLMResults *cash = [[News allObjects] sortedResultsUsingKeyPath:@"date" ascending:NO];
        NSMutableArray *cashMutable = [NSMutableArray array];
        for (News *news in cash) {
            [cashMutable addObject:news];
        }
        self.cachedNews = [cashMutable copy];
        self.count = self.cachedNews.count;
        self.startFrom = [NSUserDefaults getStartFromForKey:kNewsStartFromKey];
        self.params = @{@"filters" : @"post", @"count" : @"20"};
        self.news = [NSArray array];
    }
    return self;
}

- (News *)getNewsAtIndex:(NSInteger)index
{
    return self.news[index];
}


- (void)loadNews
{
    if (self.cachedNews.count > 0) {
        self.news = self.cachedNews;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsLoadedNotification object:nil];
    }
    NSMutableDictionary *paramsMutable = [self.params mutableCopy];
    if (self.news.count > 0) {
        NSTimeInterval startTime = [((News *)self.news.firstObject).date timeIntervalSince1970];
        [paramsMutable setObject:@(startTime) forKey:@"start_time"];
    }
    __weak typeof(self) weakSelf = self;
    [[ServerManager sharedManager] getRequest:@"newsfeed.get" withParams:[paramsMutable copy] onSuccess:^(id responseObject) {
        __strong typeof(weakSelf) blockSelf = weakSelf;
        NewsfeedResponseModel *responseModel = [[NewsfeedResponseModel alloc]initWithDictionary:responseObject[@"response"]];
        NSArray *news = [blockSelf serializeDataSourceFromModel:responseModel];
        NSTimeInterval responseNewsTime = [((News *)news.lastObject).date timeIntervalSince1970];
        NSTimeInterval dbNewsTime = [((News *)blockSelf.news.firstObject).date timeIntervalSince1970];
        if (responseNewsTime > dbNewsTime)
        {
            [blockSelf clearCach];
            [blockSelf saveToCacheFromArray:news];
        }
        else
        {
        [blockSelf saveToCacheFromArray:news];
        }
        if (!blockSelf.startFrom) {
            blockSelf.startFrom = responseModel.nextFrom;
            [NSUserDefaults saveStartFrom:blockSelf.startFrom forKey:kNewsStartFromKey];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsLoadedNotification object:nil];
    } onFailure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsFailedLoadNotification object:nil];
    }];
}

- (void)loadNextNews
{
    NSMutableDictionary *paramsMutable = [self.params mutableCopy];
    if (self.startFrom)
    {
        [paramsMutable setObject:self.startFrom forKey:@"start_from"];
    }
    
    __weak typeof(self) weakSelf = self;
    [[ServerManager sharedManager] getRequest:@"newsfeed.get" withParams:[paramsMutable copy] onSuccess:^(id responseObject) {
        __strong typeof(weakSelf) blockSelf = weakSelf;
        NewsfeedResponseModel *responseModel = [[NewsfeedResponseModel alloc]initWithDictionary:responseObject[@"response"]];
        blockSelf.startFrom = responseModel.nextFrom;
        [NSUserDefaults saveStartFrom:blockSelf.startFrom forKey:kNewsStartFromKey];
         NSArray *news = [blockSelf serializeDataSourceFromModel:responseModel];
        [blockSelf saveToCacheFromArray:news];
       
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsLoadedNotification object:nil];
    } onFailure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsServiceNewsFailedLoadNotification object:nil];
    }];
}

- (void)logout
{
    [ServerManager clearSession];
    [self clearCach];
    [NSUserDefaults removeStartFrom:kNewsStartFromKey];
}

#pragma mark - Helpers Methods

- (void)clearCach
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    for (News *news in self.news) {
        [realm deleteObjects:news.photos];
    }
    [realm deleteObjects:self.news];
    [realm commitWriteTransaction];
    self.news = @[];
    self.cachedNews = @[];
}

- (void)saveToCacheFromArray:(NSArray *)news
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSURL *url = [RLMRealmConfiguration defaultConfiguration].fileURL;
    NSLog(@"%@", url.path);
    [realm beginWriteTransaction];

    [realm addOrUpdateObjectsFromArray:news];
    [realm commitWriteTransaction];
    RLMResults *cash = [[News allObjects] sortedResultsUsingKeyPath:@"date" ascending:NO];
    NSMutableArray *cashMutable = [NSMutableArray array];
    for (News *news in cash) {
        [cashMutable addObject:news];
    }
    self.cachedNews = [cashMutable copy];
    self.count = self.cachedNews.count;
    self.news = self.cachedNews;
}

- (NSArray *)serializeDataSourceFromModel:(NewsfeedResponseModel *)model
{
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < model.items.count; i++)
    {
        News *news = [[News alloc] init];
        news.newsId = model.items[i].newsId;
        news.text = model.items[i].text;
        news.date = [NSDate dateWithTimeIntervalSince1970:[model.items[i].date doubleValue]];
        RLMArray<Photo *><Photo> *photosMutable = [[RLMArray<Photo *><Photo> alloc]initWithObjectClassName:@"Photo"];
        for (Photo *photo in model.items[i].photos) {
            Photo *dbPhoto = [[Photo alloc] init];
            dbPhoto.photoId = photo.photoId;
            dbPhoto.photoSmall = photo.photoSmall;
            dbPhoto.photo = photo.photo;
            dbPhoto.height = photo.height;
            dbPhoto.width = photo.width;
            [photosMutable addObject:dbPhoto];
        }
        news.photos = photosMutable;
        news.author = [model getAuthorNameById:model.items[i].sourceId];
        news.avatar = [model getAvatarById:model.items[i].sourceId];
        [dataSource addObject:news];
    }
    return [dataSource copy];
}


@end
