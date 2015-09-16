//
//  CalendarViewController.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/26/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class CalendarViewCell;


@interface CalendarViewController : UICollectionViewController

@property (strong, nonatomic) ViewController *logView;
@property (strong, nonatomic) NSString *currentMonth;
@property (strong, nonatomic) NSString *currentYear;
@property (nonatomic, assign) NSInteger setDay;
@property (nonatomic, assign) NSInteger setMonth;
@property (nonatomic, assign) NSInteger setYear;
@property (strong, nonatomic) NSString *firstDateName;
@property (strong, nonatomic) NSString *selectedDayString;
@property (strong, nonatomic) NSDate *firstDateOfMonth;
@property (strong, nonatomic) NSDateComponents *dateComps;
@property (strong, nonatomic) UICollectionView *publicCollectionView;
@property (strong, nonatomic) NSDateFormatter *dayFormatter;
@property (strong, nonatomic) NSDateFormatter *monthFormatter;
@property (strong, nonatomic) NSDateFormatter *yearFormatter;
@property (strong, nonatomic) NSIndexPath *publicIndexPath;
@property (strong, nonatomic) NSMutableArray *days;
@property (nonatomic) CalendarViewCell *cell;
@property (nonatomic) NSInteger queryCount;
@end
