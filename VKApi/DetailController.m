//
//  DetailController.m
//  VKApi
//
//  Created by Тимур Аюпов on 10.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DetailController.h"
#import "News.h"
#import "DetailNewsTableViewCell.h"

static NSUInteger const COUNT_ROWS = 1;
static NSString *const CELL_ID = @"DetailNewsTableViewCell";

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:318.0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return COUNT_ROWS;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.news = self.news;
    return cell;
}

@end
