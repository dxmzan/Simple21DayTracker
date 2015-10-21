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

- (NSInteger)addCup:(NSInteger) cup {
    cup++;
    return cup;

}

- (NSInteger)subtractCup:(NSInteger)cup {
    cup--;
    return cup;
}

-(BOOL)goalIsNotMet:(NSString *)newDate {
    
    self.receiveDate = newDate;
    
    Date *dc = [[Date alloc]init];
    
    NSString *theDate = [dc returnTodaysDate];
    
    NSPredicate *predGoalNotMet = [NSPredicate predicateWithFormat:@"isGoalMet = YES AND green < greenGoal OR purple < purpleGoal OR red < redGoal OR yellow < yellowGoal OR blue < blueGoal OR orange < orangeGoal OR water < waterGoal OR spoon < spoonGoal"];
    
    // Check if there's an error and the goals are set to zero
    NSPredicate *predGoalIsZero = [NSPredicate predicateWithFormat:@"greenGoal = 0 OR purpleGoal = 0 OR redGoal = 0 OR yellowGoal = 0 OR blueGoal = 0 OR orangeGoal = 0 OR waterGoal = 0 OR spoonGoal = 0"];
    
    RLMResults *checkForError = [Cups objectsWithPredicate:predGoalIsZero];
    
    RLMResults *query = [Cups objectsWithPredicate:predGoalNotMet];
    RLMResults *queryForDate, *queryForError;
    
    if (self.receiveDate == nil){
        queryForDate = [query objectsWhere:@"date = %@", theDate];
        queryForError = [checkForError objectsWhere:@"date = %@", theDate];
        
    } else {
        queryForDate = [query objectsWhere:@"date = %@", self.receiveDate];
        queryForError = [checkForError objectsWhere:@"date = %@", self.receiveDate];
    }
    
    if (queryForDate.count > 0 || checkForError.count > 0){
        [[RLMRealm defaultRealm]transactionWithBlock:^{
            [[queryForDate firstObject]setValue:@NO forKey:@"isGoalMet"];
        }];
        return YES;
    }
    
    return NO;
    
}

-(void)goalIsMet:(NSString *)newDate{
    
    self.receiveDate = newDate;
    
    Date *dc = [[Date alloc]init];
    
    NSString *theDate = [dc returnTodaysDate];
    
    NSPredicate *predMetGoal = [NSPredicate predicateWithFormat:@"isGoalMet = NO AND green >= greenGoal AND purple >= purpleGoal AND red >= redGoal AND yellow >= yellowGoal AND blue >= blueGoal AND orange >= orangeGoal AND water >= waterGoal AND spoon >= spoonGoal"];
    
    RLMResults *query = [Cups objectsWithPredicate:predMetGoal];

    RLMResults *queryForDate;
    
    
    if (self.receiveDate == nil){
        queryForDate = [query objectsWhere:@"date = %@", theDate];
    } else {
        queryForDate = [query objectsWhere:@"date = %@", self.receiveDate];
    }
    
    [[RLMRealm defaultRealm]transactionWithBlock:^{
        if (queryForDate.count >= 1){
            [[queryForDate firstObject]setValue:@YES forKey:@"isGoalMet"];
        }
    }];
    
}


-(void)setGoals:(int)switchNum setDate:(NSString *)newDate{
    
    int target = switchNum;
    self.receiveDate = newDate;
    
    Date *dc = [[Date alloc]init];
    
    NSString *theDate = [dc returnTodaysDate];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    if (self.receiveDate == nil){
        self.receiveDate = theDate;
    }
    
    RLMResults *query = [Cups objectsWhere:@"date = %@", self.receiveDate];
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    
    
    if (target <= 3){
        [realm transactionWithBlock:^{
            switch(target)
            {
                case 0:
                    [[query objectAtIndex:0] setGreenGoal:3];
                    [[query objectAtIndex:0] setPurpleGoal:2];
                    [[query objectAtIndex:0] setRedGoal:4];
                    [[query objectAtIndex:0] setYellowGoal:2];
                    [[query objectAtIndex:0] setBlueGoal:1];
                    [[query objectAtIndex:0] setOrangeGoal:1];
                    [[query objectAtIndex:0] setSpoonGoal:2];
                    [[query objectAtIndex:0] setWaterGoal:12];
                    break;
                case 1:
                    [[query objectAtIndex:0] setGreenGoal:4];
                    [[query objectAtIndex:0] setPurpleGoal:3];
                    [[query objectAtIndex:0] setRedGoal:4];
                    [[query objectAtIndex:0] setYellowGoal:3];
                    [[query objectAtIndex:0] setBlueGoal:1];
                    [[query objectAtIndex:0] setOrangeGoal:1];
                    [[query objectAtIndex:0] setSpoonGoal:4];
                    [[query objectAtIndex:0] setWaterGoal:12];
                    break;
                case 2:
                    [[query objectAtIndex:0] setGreenGoal:5];
                    [[query objectAtIndex:0] setPurpleGoal:3];
                    [[query objectAtIndex:0] setRedGoal:5];
                    [[query objectAtIndex:0] setYellowGoal:4];
                    [[query objectAtIndex:0] setBlueGoal:1];
                    [[query objectAtIndex:0] setOrangeGoal:1];
                    [[query objectAtIndex:0] setSpoonGoal:5];
                    [[query objectAtIndex:0] setWaterGoal:12];
                    break;
                case 3:
                    [[query objectAtIndex:0] setGreenGoal:6];
                    [[query objectAtIndex:0] setPurpleGoal:4];
                    [[query objectAtIndex:0] setRedGoal:6];
                    [[query objectAtIndex:0] setYellowGoal:4];
                    [[query objectAtIndex:0] setBlueGoal:1];
                    [[query objectAtIndex:0] setOrangeGoal:1];
                    [[query objectAtIndex:0] setSpoonGoal:6];
                    [[query objectAtIndex:0] setWaterGoal:12];
                    break;
            }
        }];
        // Register default goals for new dates
        [defaults setInteger:[[query objectAtIndex:0] greenGoal] forKey:@"greenGoal"];
        [defaults setInteger:[[query objectAtIndex:0] purpleGoal] forKey:@"purpleGoal"];
        [defaults setInteger:[[query objectAtIndex:0] redGoal] forKey:@"redGoal"];
        [defaults setInteger:[[query objectAtIndex:0] yellowGoal ]forKey:@"yellowGoal"];
        [defaults setInteger:[[query objectAtIndex:0] blueGoal] forKey:@"blueGoal"];
        [defaults setInteger:[[query objectAtIndex:0] orangeGoal] forKey:@"orangeGoal"];
        [defaults setInteger:[[query objectAtIndex:0] waterGoal] forKey:@"waterGoal"];
        [defaults setInteger:[[query objectAtIndex:0] spoonGoal] forKey:@"spoonGoal"];

        [defaults synchronize];
        
    } else {
        
        [realm transactionWithBlock:^{
            
            [[query objectAtIndex:0] setGreenGoal:[defaults integerForKey:@"greenGoal"]];
            [[query objectAtIndex:0] setPurpleGoal:[defaults integerForKey:@"purpleGoal"]];
            [[query objectAtIndex:0] setRedGoal:[defaults integerForKey:@"redGoal"]];
            [[query objectAtIndex:0] setYellowGoal:[defaults integerForKey:@"yellowGoal"]];
            [[query objectAtIndex:0] setBlueGoal:[defaults integerForKey:@"blueGoal"]];
            [[query objectAtIndex:0] setOrangeGoal:[defaults integerForKey:@"orangeGoal"]];
            [[query objectAtIndex:0] setWaterGoal:[defaults integerForKey:@"waterGoal"]];
            [[query objectAtIndex:0] setSpoonGoal:[defaults integerForKey:@"spoonGoal"]];
        }];
    }
}

@end
