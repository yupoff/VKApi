//
//  NewsController.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "News.h"
#import "NewsController.h"
#import "DetailController.h"
#import "NewsTableViewCell.h"

#import "NewsService.h"

#import "ServerManager.h"

static NSString *const kCellId = @"NewsTableViewCell";
static NSString *const kDetailControllerSegueId = @"detailControllerSegue";

@interface NewsController ()
@property (strong, nonatomic) NewsService *newsService;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (assign, nonatomic) BOOL loadMoreStatus;

@end

@implementation NewsController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:318.0];

    self.newsService = [[NewsService alloc] init];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Выход" style:UIBarButtonItemStyleDone target:self action:@selector(logout:)];

    [self.tableView.tableFooterView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsLoaded:) name:kNewsServiceNewsLoadedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Data Loading methods

- (void)loadNews
{
    [self.newsService loadNews];
}

- (void)newsLoaded:(NSNotification *)notification
{
    if (self.loadMoreStatus) {
        self.loadMoreStatus = NO;
        [self.activityIndicator stopAnimating];
        [self.tableView.tableFooterView setHidden:YES];
    }
    [self.tableView reloadData];
}

#pragma Helpers Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    NSInteger deltaOffset = maximumOffset - currentOffset;

    if (deltaOffset <= 0)
    {
        [self loadMore];
    }
}

- (void)loadMore
{
    if (!self.loadMoreStatus)
    {
        self.loadMoreStatus = YES;
        [self.activityIndicator startAnimating];
        [self.tableView.tableFooterView setHidden:NO];
        [self loadNews];
    }
}

#pragma mark - Navigation Methods

- (void)logout:(id)sender
{
    [ServerManager logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    DetailController *detailVC = [segue destinationViewController];
    detailVC.news = [self.newsService getNewsAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsService.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellId];
    cell.news = [self.newsService getNewsAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kDetailControllerSegueId sender:indexPath];
}

@end
