//
//  EmptyState.m
//  StatefulTableViewDemo
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "EmptyState.h"
#import "StateDemoTableViewController.h"
#import "ComicData.h"

@implementation EmptyState

#pragma mark - StatefulTableViewStateProtocol

- (void)enterStateWithData:(id)data
{
    [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationBottom];
    
    [self.tableView setAllowsSelection:NO];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor brownColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
    NSShadow * shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowColor = [UIColor blackColor];
    
    NSDictionary * attributes = @{
        NSTextEffectAttributeName      : NSTextEffectLetterpressStyle,
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName            : [UIFont fontWithName:@"HelveticaNeue" size:18.0]
    };
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Transition To Populated State" attributes:attributes];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}

- (void)leaveState
{
    [self.tableView deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView setAllowsSelection:YES];
    self.refreshControl = nil;
}


#pragma mark - RefreshControl

- (void)reloadData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        
        // Give refreshControl time to finish it's animation or get a warning in your logs since we remove it in leaveState
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.statefulTableViewController transitionToState:STATE_DEMO_POPULATED_STATE withData:[ComicData data]];
        });
    });
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyState"];
    
    UILabel * label = (id)[cell viewWithTag:1];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"No Data Found" attributes:@{ NSTextEffectAttributeName:NSTextEffectLetterpressStyle }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [UIView new];
    footer.backgroundColor = [UIColor brownColor];
    UILabel * label = [UILabel new];
    
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    label.text = @"Pull to refresh to Populated View";
    label.textColor = [UIColor whiteColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    
    [footer addSubview:label];
    
    return footer;
}

#pragma mark - UITableViewDelegate

@end
