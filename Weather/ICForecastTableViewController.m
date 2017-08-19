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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.viewModel update];
}

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

- (void)forecastTableViewModelUpdateDidSucceed:(ICForecastTableViewModel *)ftvm {
    [self.tableView reloadData];
}

- (void)forecastTableViewModel:(ICForecastTableViewModel *)ftvm updateDidFailWithError:(NSError *)error {
    
}

@end
