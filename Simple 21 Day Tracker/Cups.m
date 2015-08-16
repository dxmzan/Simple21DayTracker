//
//  Cups.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/15/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "Cups.h"

@implementation Cups

+ (NSString *) primaryKey {
        return @"cupId";
}
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
             };
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
