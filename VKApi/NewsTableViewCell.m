//
//  NewsTableViewCell.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "News.h"
#import "NewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface NewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *textNewsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation NewsTableViewCell

- (void)setNews:(News *)news
{
    _news = news;
    [self setupData];
}

- (void)setupData
{
    [self.authorLabel setText:self.news.author];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocalizedDateFormatFromTemplate:@"dd MMMM yyyy HH:mm"];
    [self.dateLabel setText:[formatter stringFromDate:self.news.date]];
    [self.textNewsLabel setText:self.news.text];
    [self.avatarImageView setImage:nil];
    [self.photoImageView setImage:nil];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.news.avatar]];
    if (self.news.photos.count > 0)
    {
        [self.photoImageView setImageWithURL:[NSURL URLWithString:[self.news.photos firstObject].photo] placeholderImage:[self getPlaceholder]];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImage *)getPlaceholder
{
    CGRect rect = CGRectMake(0, 0, [[self.news.photos firstObject].height integerValue], [[self.news.photos firstObject].width integerValue]);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
