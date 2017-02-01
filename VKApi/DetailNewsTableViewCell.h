//
//  DetailNewsTableViewCell.h
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface DetailNewsTableViewCell : UITableViewCell
@property (strong, nonatomic) News *news;
@end
