//
//  Date.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 9/11/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalendarViewController;

@interface Date : NSObject

@property (strong, nonatomic) NSString *dateString;

@property (strong, nonatomic) NSString *receivedDate;

@property (strong, nonatomic) NSString *currentDay, *currentMonth, *currentYear;

@property (strong, nonatomic) NSDate *currentDate;

@property (strong, nonatomic) NSDateComponents *componentsForDate;

@property (nonatomic) NSInteger newMonth;


-(NSString *)returnTodaysDate;
-(NSUInteger)numberOfDaysInMonth;
-(void)createCalendar;
-(void)updateCalendar;


@end
