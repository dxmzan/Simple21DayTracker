//
//  Cups.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/15/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "Cups.h"
#import "CalendarViewController.h"
#import "Date.h"
#import "ViewController.h"

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
             @"purpleGoal": @2,
             @"redGoal": @4,
             @"blueGoal": @1,
             @"greenGoal": @3,
             @"waterGoal": @12,
             @"orangeGoal": @1,
             @"spoonGoal": @2,
             @"yellowGoal":  @2,
             @"date": @"",
             @"day": @"",
             @"month": @"",
             @"year": @"",
             @"isGoalMet": @NO,
             };
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"receiveDate"];
}

- (int)addCup:(int) cup {
    cup++;
    return cup;
}

- (int)subtractCup:(int)cup {
    cup--;
    return cup;
}

-(BOOL)goalIsNotMet {
    
    Date *dc = [[Date alloc]init];
    
    NSString *theDate = [dc formattedDate];
    
    NSPredicate *predGoalNotMet = [NSPredicate predicateWithFormat:@"isGoalMet = YES AND green < greenGoal OR purple < purpleGoal OR red < redGoal OR yellow < yellowGoal OR blue < blueGoal OR orange < orangeGoal OR water < waterGoal OR spoon < spoonGoal"];
    RLMResults *query = [Cups objectsWithPredicate:predGoalNotMet];
    RLMResults *queryForDate;
    
    NSLog(@"Recieve date: %@", self.receiveDate);

    if (self.receiveDate == nil){
        queryForDate = [query objectsWhere:@"date = %@", theDate];
    } else {
        queryForDate = [query objectsWhere:@"date = %@", self.receiveDate];
    }
    
    NSLog(@"Query: %@", queryForDate);

    
    if (queryForDate.count >= 1){
        [[RLMRealm defaultRealm]transactionWithBlock:^{
            [[queryForDate firstObject]setValue:@NO forKey:@"isGoalMet"];
        }];
        NSLog(@"Goal is not met");
        return YES;
    }
    
    return NO;
    
}

-(void)goalIsMet{
    
    Date *dc = [[Date alloc]init];
    
    NSString *theDate = [dc formattedDate];
    
    NSLog(@"Goal is met");
    NSLog(@"Recieve date: %@", self.receiveDate);
    
    NSPredicate *predMetGoal = [NSPredicate predicateWithFormat:@"isGoalMet = NO AND green >= greenGoal AND purple >= purpleGoal AND red >= redGoal AND yellow >= yellowGoal AND blue >= blueGoal AND orange >= orangeGoal AND water >= waterGoal AND spoon >= spoonGoal"];
    
    RLMResults *query = [Cups objectsWithPredicate:predMetGoal];

    RLMResults *queryForDate;
    
    
    if (self.receiveDate == nil){
        queryForDate = [query objectsWhere:@"date = %@", theDate];
    } else {
        queryForDate = [query objectsWhere:@"date = %@", self.receiveDate];
    }
    NSLog(@"Query: %@", queryForDate);

    
    [[RLMRealm defaultRealm]transactionWithBlock:^{
        if (queryForDate.count >= 1){
            [[queryForDate firstObject]setValue:@YES forKey:@"isGoalMet"];
    }
    }];
    
}


@end
