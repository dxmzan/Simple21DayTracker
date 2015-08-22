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

@property Cups *myCup;

@property NSDateFormatter *formatter;

@property NSInteger cellRow;

@property MGSwipeTableCell *cell;

@property (strong) UILabel *counter;

@end
