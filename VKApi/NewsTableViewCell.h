//
//  NewsTableViewCell.h
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsTableViewCell : UITableViewCell

@property (strong, nonatomic) News *news;

@end
