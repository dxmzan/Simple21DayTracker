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
@property (nonatomic) NSInteger currentDay;
@property (nonatomic) NSString *currentMonth;
@property (nonatomic) NSString *selectedMonth;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSString *firstDayOfMonth;
@property (nonatomic) NSDate *firstDateofMonth;
@property (nonatomic) NSDateComponents *dateComps;
@property (nonatomic) UICollectionView *publicCollectionView;
@end
