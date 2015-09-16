//
//  Date.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 9/11/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "Date.h"
#import "CalendarViewController.h"

@implementation Date {
    NSCalendar *calendar;
    
    // Date formatters
    NSDateFormatter *dateFormatter, *formatDay, *formatMonth, *formatYear;
    
}


- (void)createCalendar {
    
    [self formatDate];
    
    calendar = [NSCalendar currentCalendar];
    
    self.componentsForDate = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    // Setting up the calendar with starting day, month, year
    
    [self.componentsForDate setDay:1];
    
    self.newMonth = [self.componentsForDate month];
    
    self.currentDate = [calendar dateFromComponents:self.componentsForDate]; // NSDate
    
    self.currentDay = [formatDay stringFromDate:self.currentDate]; // September
    self.currentMonth = [formatMonth stringFromDate:self.currentDate]; // Tuesday
    self.currentYear = [formatYear stringFromDate:self.currentDate]; // 2015
    
}

-(void)updateCalendar {
    
    // Update current day, month, year with updated NSDate
    self.currentDate = [calendar dateFromComponents:self.componentsForDate]; // NSDate
    
    self.currentDay = [formatDay stringFromDate:self.currentDate]; // Tuesday
    self.currentMonth = [formatMonth stringFromDate:self.currentDate]; // September
    self.currentYear = [formatYear stringFromDate:self.currentDate]; // 2015
    
}

-(NSString *)returnTodaysDate {
    
    dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MMMM d, yyyy";
    self.dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return self.dateString;
}

-(NSUInteger)numberOfDaysInMonth {
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.currentDate];
    NSUInteger days = range.length;
    
    return days;
}


-(void)formatDate {
    
    formatDay = [[NSDateFormatter alloc] init];
    [formatDay setDateFormat:@"EEEE"];
    
    formatMonth = [[NSDateFormatter alloc] init];
    [formatMonth setDateFormat:@"MMMM"];
    
    formatYear = [[NSDateFormatter alloc] init];
    [formatYear setDateFormat:@"YYYY"];
    
}
@end
