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
@property (nonatomic) NSString *currentMonth;
@property (nonatomic) NSInteger activeDay;
@property (nonatomic) NSInteger activeMonth;
@property (nonatomic) NSInteger activeYear;
@property (nonatomic) NSString *firstDateName;
@property (nonatomic) NSDate *firstDateOfMonth;
@property (nonatomic) NSDateComponents *dateComps;
@property (nonatomic) UICollectionView *publicCollectionView;
@property (nonatomic) NSDateFormatter *dayFormatter;
@property (nonatomic) NSDateFormatter *monthFormatter;
@end
