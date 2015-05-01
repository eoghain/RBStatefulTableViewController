//
//  LoadingState.m
//  StatefulTableViewDemo
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "LoadingState.h"
#import "StateDemoTableViewController.h"
#import "ComicData.h"

@implementation LoadingState

#pragma mark - StatefulTableViewStateProtocol

- (void)enterStateWithData:(id)data
{
     [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationBottom];
    
    [self.tableView setAllowsSelection:NO];
    
    // Simulate making call to network
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Oops no data returned.
//        [self.statefulTableViewController transitionToState:STATE_DEMO_EMPTY_STATE withData:nil];
        
        // Got data
        [self.statefulTableViewController transitionToState:STATE_DEMO_POPULATED_STATE withData:[ComicData data]];
    });
}

- (void)leaveState
{
    [self.tableView deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView setAllowsSelection:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingState"];
    
    UILabel * label = (id)[cell viewWithTag:1];
    label.alpha = 1.0;
    label.attributedText = [[NSAttributedString alloc] initWithString:@"Loading Data" attributes:@{ NSTextEffectAttributeName:NSTextEffectLetterpressStyle }];
    
    UIActivityIndicatorView * activity = (id)[cell viewWithTag:2];
    [activity startAnimating];
    activity.alpha = 1.0;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height;
}

#pragma mark - UITableViewDelegate

@end
