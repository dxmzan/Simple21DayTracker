//
//  CalendarHeader.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/31/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "CalendarHeader.h"
#import "CalendarViewController.h"

@implementation CalendarHeader

- (IBAction)prevButton:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"previousButtonPressed" object:nil];
}

- (IBAction)nextButton:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextButtonPressed" object:nil];

}

@end
