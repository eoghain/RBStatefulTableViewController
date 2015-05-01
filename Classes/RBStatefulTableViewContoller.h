//
//  RBStatefulTableViewContoller.h
//
//  Created by Rob Booth on 4/30/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RBTableViewState;

@protocol RBStatefulTableViewStateProtocol <NSObject>

- (void)enterStateWithData:(id)data;
- (void)leaveState;

@end

@interface RBStatefulTableViewContoller : UITableViewController

- (void)setState:(RBTableViewState *)state forKey:(NSString *)key;
- (void)transitionToState:(NSString *)stateName withData:(id)data;

@end
