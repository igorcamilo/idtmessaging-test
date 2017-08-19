//
//  ICForecastTableViewController.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecastTableViewController.h"
#import "ICForecastTableViewModel.h"

@interface ICForecastTableViewController () <ICForecastTableViewModelDelegate>

@property (nonatomic, strong) ICForecastTableViewModel *viewModel;

@end

@implementation ICForecastTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ICForecastTableViewModel alloc] init];
    self.viewModel.delegate = self;
    [self.refreshControl beginRefreshing];
    [self.refreshControl addTarget:self.viewModel action:@selector(update) forControlEvents:UIControlEventValueChanged];
    // Fix for hidden refresh control
    CGPoint offset = self.tableView.contentOffset;
    offset.y -= 44;
    self.tableView.contentOffset = offset;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.viewModel update];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsForSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.viewModel titleForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell" forIndexPath:indexPath];
    ICForecastItem *item = [self.viewModel forecastItemForIndexPath:indexPath];
    cell.textLabel.text = item.labelText;
    cell.detailTextLabel.text = item.valueText;
    return cell;
}

#pragma mark ICForecastTableViewModelDelegate

- (void)forecastTableViewModelUpdateDidSucceed:(ICForecastTableViewModel *)ftvm {
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)forecastTableViewModel:(ICForecastTableViewModel *)ftvm updateDidFailWithError:(NSError *)error {
    [self.refreshControl endRefreshing];
    
    // Check if there is already an alert on screen
    if (self.presentedViewController) {
        return;
    }
    
    // Fix for presenting alert during a pull to refresh
    [self.tableView setContentOffset:CGPointMake(0, -self.tableView.contentInset.top) animated:YES];
    self.tableView.scrollEnabled = NO;
    self.tableView.scrollEnabled = YES;
    
    // Present error alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"An error occurred. Try again?", nil) message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Yes", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.refreshControl beginRefreshing];
        [self.viewModel update];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"No", nil) style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
