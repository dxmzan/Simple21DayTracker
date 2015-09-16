//
//  ViewController.h
//  T1DF
//
//  Created by Shaun on 8/10/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cups;
@class Log;
@class Date;
@class MGSwipeTableCell;
@class CalendarViewController;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Cups *Cups;

@property (strong, nonatomic) Log *Log;

@property (strong, nonatomic) Date *Date;

@property (strong, nonatomic) CalendarViewController *CalendarViewController;

@property (assign, nonatomic) NSInteger cellRow;

@property (strong, nonatomic) MGSwipeTableCell *cell;

@property (strong, nonatomic) UILabel *counter;

@property (strong, nonatomic) UITableView *scopedTableView;

@property (assign, nonatomic) BOOL *isSwitchOneEnabled;

@property (strong, nonatomic) NSString *receivedDate;


@end
