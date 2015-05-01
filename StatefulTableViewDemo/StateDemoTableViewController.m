//
//  StateDemoTableViewController.m
//  StatefulTableViewDemo
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "StateDemoTableViewController.h"
#import "EmptyState.h"
#import "LoadingState.h"
#import "PopulatedState.h"


NSString * STATE_DEMO_EMPTY_STATE = @"emptyState";
NSString * STATE_DEMO_LOADING_STATE = @"loadingState";
NSString * STATE_DEMO_POPULATED_STATE = @"populatedState";

@implementation StateDemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setState:[[EmptyState alloc] init] forKey:STATE_DEMO_EMPTY_STATE];
    [self setState:[[LoadingState alloc] init] forKey:STATE_DEMO_LOADING_STATE];
    [self setState:[[PopulatedState alloc] init] forKey:STATE_DEMO_POPULATED_STATE];
    [self transitionToState:STATE_DEMO_LOADING_STATE withData:nil];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if (self.currentSate == nil)
//    {
//        [self transitionToState:STATE_DEMO_LOADING_STATE withData:nil];
//    }
//}

# pragma mark - Animation Helper

- (UITableViewRowAnimation)rowAnimation
{
    return UITableViewRowAnimationMiddle;
}

@end
