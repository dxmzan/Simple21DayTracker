//
//  Date.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 9/11/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "Date.h"

@implementation Date

-(NSString *)formattedDate {
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"MMMM d, yyyy";
    self.dateString = [self.formatter stringFromDate:[NSDate date]];
    return self.dateString;
}
@end
