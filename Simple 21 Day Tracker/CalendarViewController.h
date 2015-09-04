//
//  CalendarViewController.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/26/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface CalendarViewController : UICollectionViewController

@property (strong, nonatomic) ViewController *logView;
@property (strong, nonatomic) NSString *currentMonth;
@property (nonatomic, assign) NSInteger activeDay;
@property (nonatomic, assign) NSInteger activeMonth;
@property (nonatomic, assign) NSInteger activeYear;
@property (strong, nonatomic) NSString *firstDateName;
@property (strong, nonatomic) NSDate *firstDateOfMonth;
@property (strong, nonatomic) NSDateComponents *dateComps;
@property (strong, nonatomic) UICollectionView *publicCollectionView;
@property (strong, nonatomic) NSDateFormatter *dayFormatter;
@property (strong, nonatomic) NSDateFormatter *monthFormatter;
@end
