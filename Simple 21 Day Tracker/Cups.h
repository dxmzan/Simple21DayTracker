//
//  Cups.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/15/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <Realm/Realm.h>

@interface Cups : RLMObject
@property int purple, red, blue, green, water, orange, spoon, yellow;
@property (strong, nonatomic) NSString *purpleGoal, *redGoal, *blueGoal, *greenGoal, *waterGoal, *orangeGoal, *spoonGoal, *yellowGoal;
@property (strong, nonatomic) NSString *date;

- (int) addGreen: (int) n;
- (int) addRed: (int) n;
- (int) addBlue: (int) n;
- (int) addOrange: (int) n;
- (int) addWater: (int) n;
- (int) addSpoon: (int) n;
- (int) addYellow: (int) n;
- (int) addPurple: (int) n;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Cups>
RLM_ARRAY_TYPE(Cups)
