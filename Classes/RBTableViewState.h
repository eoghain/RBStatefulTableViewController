//
//  RBTableViewState.h
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBStatefulTableViewController.h"

@interface RBTableViewState : NSObject < RBStatefulTableViewStateProtocol, UITableViewDataSource, UITableViewDelegate >

@property (strong, nonatomic) RBStatefulTableViewController * statefulTableViewController;
@property (readonly) UITableView * tableView;
@property (nonatomic) UIRefreshControl * refreshControl;

@end
