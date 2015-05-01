//
//  RBTableViewState.m
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "RBTableViewState.h"

@implementation RBTableViewState

#pragma mark - Getters & Setters

- (UITableView *)tableView
{
    return self.statefulTableViewController.tableView;
}

- (UIRefreshControl *)refreshControl
{
    return self.statefulTableViewController.refreshControl;
}

- (void)setRefreshControl:(UIRefreshControl *)refreshControl
{
    self.statefulTableViewController.refreshControl = refreshControl;
}

#pragma mark - StatefulTableViewStateProtocol

- (void)enterStateWithData:(id)data
{
    NSLog(@"enterStateWithData: not overwritten in %@", self.class);
}

- (void)leaveState
{
    NSLog(@"leaveState not overwritten in %@", self.class);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSAssert(false, @"%@ not implemented in %@", NSStringFromSelector(_cmd), self.class);
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(false, @"%@ not implemented in %@", NSStringFromSelector(_cmd), self.class);
    return nil;
}

@end
