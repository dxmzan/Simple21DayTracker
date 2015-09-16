//
//  Log.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 9/9/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "Log.h"

@implementation Log

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cupNames = [[NSArray alloc]initWithObjects:@"Vegetables", @"Fruits", @"Protein", @"Carbs", @"Dairy", @"Seeds & Oils", @"Water", @"Teaspoon", nil];
    }
    return self;
}

- (NSString *) chooseCupName:(NSInteger)row {
    return [self.cupNames objectAtIndex:row];
}

- (NSUInteger)countOfCups {
    return [self.cupNames count];
}

@end
