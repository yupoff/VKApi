//
//  NewsController.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "News.h"
#import "NewsController.h"
#import "NewsDataSource.h"
#import "NewsTableViewCell.h"
#import "NewsfeedResponseModel.h"
#import "DetailController.h"

static NSString *const CELL_ID = @"NewsTableViewCell";
static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"detailControllerSegue";

@interface NewsController ()
@property (strong, nonatomic) NewsDataSource *newsDataSource;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (assign, nonatomic) BOOL loadMoreStatus;

@end

@implementation NewsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:318.0];

    self.newsDataSource = [[NewsDataSource alloc] init];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Выход" style:UIBarButtonItemStyleDone target:self action:@selector(logout:)];

    [self.tableView.tableFooterView setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        [self.newsDataSource updateDataSource:^(NSArray *dataSource) {
          [self.tableView reloadData];
          self.loadMoreStatus = NO;
          [self.activityIndicator stopAnimating];
          [self.tableView.tableFooterView setHidden:YES];
        }
            onFailure:^(NSError *error){

            }];
    }
}

- (void)logout:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    DetailController *detailVC = [segue destinationViewController];
    detailVC.news = [self.newsDataSource getNewsAtIndexPath:indexPath];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CELL_ID];
    cell.news = [self.newsDataSource getNewsAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:indexPath];
}



@end
