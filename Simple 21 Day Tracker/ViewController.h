//
//  ViewController.h
//  T1DF
//
//  Created by Shaun on 8/10/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cups.h"
#import "MGSwipeTableCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *cupType;

@property (copy, nonatomic) NSMutableArray *cupCount;

@property (strong, nonatomic) Cups *myCup;

@property (strong, nonatomic) NSDateFormatter *formatter;

@property (assign, nonatomic) NSInteger cellRow;

@property (strong, nonatomic) MGSwipeTableCell *cell;

@property (strong, nonatomic) UILabel *counter;

@property (strong, nonatomic) UITableView *scopedTableView;

@property (assign, nonatomic) BOOL *isSwitchOneEnabled;

@property (strong, nonatomic) NSString *receivedDate;

@end
