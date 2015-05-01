//
//  RBStatefulTableViewContoller.m
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "RBStatefulTableViewContoller.h"
#import "RBTableViewState.h"

@interface RBStatefulTableViewContoller ()

@property (strong, nonatomic) NSMutableDictionary * states;
@property (strong, nonatomic) RBTableViewState * currentState;

@end

@implementation RBStatefulTableViewContoller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.states = [NSMutableDictionary dictionary];
}

- (void)setState:(RBTableViewState *)state forKey:(NSString *)key
{
    state.statefulTableViewController = self;
    [self.states setObject:state forKey:key];
}

- (void)transitionToState:(NSString *)stateName withData:(id)data
{
    [self.tableView beginUpdates];
    if (self.currentState == nil)
    {
        self.currentState = [self.states objectForKey:stateName];
        self.tableView.delegate = self.currentState;
        self.tableView.dataSource = self.currentState;
        [self.currentState enterStateWithData:data];
    }
    else
    {
        [self.currentState leaveState];
        self.currentState = [self.states objectForKey:stateName];
        self.tableView.delegate = self.currentState;
        self.tableView.dataSource = self.currentState;
        [self.currentState enterStateWithData:data];
    }
    [self.tableView endUpdates];
}

@end
