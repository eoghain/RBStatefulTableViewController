//
//  PopulatedState.m
//  StatefulTableViewDemo
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "PopulatedState.h"
#import "StateDemoTableViewController.h"
#import "ComicViewController.h"

@interface PopulatedState ()

@property (strong, nonatomic) NSDictionary * data;
@property (nonatomic, strong) NSCache * imageCache;

@end

@implementation PopulatedState

#pragma mark - Initialization & Dealloc

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}


#pragma mark - StatefulTableViewStateProtocol

- (void)enterStateWithData:(id)data
{
    self.data = data;

    // Add all the data we just recieved
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger index = 0; index < [self.data[@"data"][@"count"] integerValue]; index++)
    {
        [array addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationBottom];
    
    // Setup refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];

    NSDictionary * attributes = @{
        NSTextEffectAttributeName      : NSTextEffectLetterpressStyle,
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName            : [UIFont fontWithName:@"HelveticaNeue" size:18.0]
    };
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Transition To Empty State" attributes:attributes];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}

- (void)leaveState
{
    // Remove all of our rows
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger index = 0; index < [self.data[@"data"][@"count"] integerValue]; index++)
    {
        [array addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
    
    self.refreshControl = nil;
}

#pragma mark - RefreshControl

- (void)reloadData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];

        // Give refreshControl time to finish it's animation or get a warning in your logs since we remove it in leaveState
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.statefulTableViewController transitionToState:STATE_DEMO_EMPTY_STATE withData:nil];
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
    return [self.data[@"data"][@"count"] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PopulatedState"];
    
    NSDictionary * data = self.data[@"data"][@"results"][indexPath.row];
    
    cell.textLabel.text = data[@"title"];
    cell.detailTextLabel.text = data[@"upc"];
    
    NSString * imagePath = data[@"thumbnail"][@"path"];
    imagePath = [imagePath stringByAppendingString:@"/landscape_small."];
    imagePath = [imagePath stringByAppendingString:data[@"thumbnail"][@"extension"]];
    NSURL * imageURL = [NSURL URLWithString:imagePath];
    
    if ([self.imageCache objectForKey:imageURL] == nil)
    {
        __weak typeof(self) weakSelf = self;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [weakSelf.imageCache setObject:image forKey:imageURL];
                
                [cell.imageView setImage:image];
                [cell setNeedsLayout];
            });
        });
    }
    else
    {
        [cell.imageView setImage:[self.imageCache objectForKey:imageURL]];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [UIView new];
    footer.backgroundColor = [UIColor purpleColor];
    UILabel * label = [UILabel new];
    
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    label.text = self.data[@"attributionText"];
    label.textColor = [UIColor whiteColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    
    [footer addSubview:label];
    
    return footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Comics Found";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 66.0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * comicData = self.data[@"data"][@"results"][indexPath.row];
    
    ComicViewController * comicVC = [self.statefulTableViewController.storyboard instantiateViewControllerWithIdentifier:@"ComicViewController"];
    comicVC.comicData = comicData;
    
    [self.statefulTableViewController.navigationController pushViewController:comicVC animated:YES];
//    [self.statefulTableViewController.navigationController presentViewController:comicVC animated:YES completion:^{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    }];
}

@end
