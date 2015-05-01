//
//  StateDemoTableViewController.h
//  StatefulTableViewDemo
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "RBStatefulTableViewContoller.h"


extern NSString * STATE_DEMO_EMPTY_STATE;
extern NSString * STATE_DEMO_LOADING_STATE;
extern NSString * STATE_DEMO_POPULATED_STATE;

@interface StateDemoTableViewController : RBStatefulTableViewContoller

- (UITableViewRowAnimation)rowAnimation;

@end
