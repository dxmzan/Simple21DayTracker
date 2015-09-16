//
//  Cups.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/15/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <Realm/Realm.h>
@class Date;

@interface Cups : RLMObject
@property int purple, red, blue, green, water, orange, spoon, yellow;
@property int purpleGoal, redGoal, blueGoal, greenGoal, waterGoal, orangeGoal, spoonGoal, yellowGoal;
@property (strong, nonatomic) NSString *date, *day, *month, *year;
@property (assign, nonatomic) BOOL isGoalMet;

@property (strong, nonatomic) NSString *receiveDate;

- (int)addCup: (int) cup;
- (int)subtractCup: (int) cup;
- (void)goalIsMet;
- (BOOL)goalIsNotMet;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Cups>
RLM_ARRAY_TYPE(Cups)
