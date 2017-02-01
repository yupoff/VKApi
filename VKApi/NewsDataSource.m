//
//  NewsDataSource.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "News.h"
#import "NewsDataSource.h"
#import "NewsfeedResponseModel.h"
#import "ServerManager.h"

@implementation NewsDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}

-(News *)getNewsAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource[indexPath.row];
}

- (void)updateDataSource:(void (^)(NSArray *dataSource))succes onFailure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                   @"post", @"filter",
                                                                   @"20", @"count",
                                                                   nil];
    if (self.startFrom)
    {
        [params setObject:self.startFrom forKey:@"start_from"];
    }

//    [NetworkService loadNewsWithParams:params andBlock:^(NewsfeedResponseModel *data) {
//      self.startFrom = data.nextFrom;
//      [self.dataSource addObjectsFromArray:[self serializeDataSourceFromModel:data]];
//      self.count = [self.dataSource count];
//      succes(self.dataSource);
//    }
//        onFailure:^(NSError *error) {
//          failure(error);
//        }];
    [[ServerManager sharedManager]getNewsWithParams:params onSuccess:^(NewsfeedResponseModel *responseModel) {
        self.startFrom = responseModel.nextFrom;
        [self.dataSource addObjectsFromArray:[self serializeDataSourceFromModel:responseModel]];
        self.count = [self.dataSource count];
        succes(self.dataSource);
    } onFailure:^(NSError *error, NSInteger statusCode) {
        failure(error);
    }];
}

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
