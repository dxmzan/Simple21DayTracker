//
//  Cups.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/15/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <Realm/Realm.h>
#import "ViewController.h"
@class Date;

@interface Cups : RLMObject
@property (assign, nonatomic) NSInteger purple, red, blue, green, water, orange, spoon, yellow;
@property (assign, nonatomic) NSInteger purpleGoal, redGoal, blueGoal, greenGoal, waterGoal, orangeGoal, spoonGoal, yellowGoal;
@property (strong, nonatomic) NSString *date, *day, *month, *year;
@property (assign, nonatomic) BOOL isGoalMet;

@property (copy, nonatomic) NSString *receiveDate;

- (NSInteger)addCup: (NSInteger) cup;
- (NSInteger)subtractCup: (NSInteger) cup;
- (BOOL)goalIsNotMet:(NSString *)newDate;
- (void)goalIsMet:(NSString *)newDate;
- (void)setGoals:(int) switchNumber setDate:(NSString *)newDate;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Cups>
RLM_ARRAY_TYPE(Cups)
