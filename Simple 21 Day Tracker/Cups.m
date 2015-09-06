//
//  Cups.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/15/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "Cups.h"

@implementation Cups

@synthesize purple, red, blue, green, water, orange, spoon, yellow, date;


//+ (NSString *) primaryKey {
//        return @"cupId";
//}
// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{
             @"purple": @0,
             @"red": @0,
             @"blue": @0,
             @"green": @0,
             @"water": @0,
             @"orange": @0,
             @"spoon": @0,
             @"yellow": @0,
             @"purpleGoal": @"0",
             @"redGoal": @"0",
             @"blueGoal": @"0",
             @"greenGoal": @"0",
             @"waterGoal": @"0",
             @"orangeGoal": @"0",
             @"spoonGoal": @"0",
             @"yellowGoal":  @"0",
             @"day": @"",
             @"month": @"",
             @"year": @"",
             @"isGoalMet": @NO,
             };
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

- (int)addGreen: (int) n
{
    green = n + 1;
    
    return green;
}

- (int)addBlue:(int) n
{
    blue = n + 1;
    
    return blue;
}

- (int)addOrange:(int) n
{
    orange = n + 1;
    
    return orange;
}

- (int)addPurple:(int) n
{
    purple = n + 1;
    
    return purple;
}

- (int)addRed: (int) n
{
    red = n + 1;
    
    return red;
}

- (int)addYellow: (int) n
{
    yellow = n + 1;
    
    return yellow;
}

- (int)addWater: (int) n
{
    water = n + 1;
    
    return water;
}

- (int)addSpoon: (int) n
{
    spoon = n + 1;
    
    return spoon;
}

@end
