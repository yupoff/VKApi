//
//  DetailNewsTableViewCell.m
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DetailNewsTableViewCell.h"
#import "News.h"
#import "PhotosCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

static NSString *const CELL_ID = @"PhotosCollectionViewCell";

@interface DetailNewsTableViewCell () < UICollectionViewDelegate, UICollectionViewDataSource >
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *textNewsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation DetailNewsTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setNews:(News *)news
{
    _news = news;
    [self setupData];
}

- (void)setupData
{
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.authorLabel setText:self.news.author];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocalizedDateFormatFromTemplate:@"dd MMMM yyyy HH:mm"];
    [self.dateLabel setText:[formatter stringFromDate:self.news.date]];
    [self.textNewsLabel setText:self.news.text];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.news.avatar]];
    [self.photoImageView setImageWithURL:[NSURL URLWithString:[self.news.photos firstObject].photo]];
    if (self.news.photos.count <= 1)
    {
        [self.collectionView removeFromSuperview];
    }
    [self.collectionView reloadData];
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.news.photos.count ?: 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    [cell.photoImageView setImageWithURL:[NSURL URLWithString:self.news.photos[indexPath.row].photoSmall]];
    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.photoImageView setImageWithURL:[NSURL URLWithString:self.news.photos[indexPath.row].photo]];
}

@end
