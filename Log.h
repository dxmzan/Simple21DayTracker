//
//  Log.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 9/9/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Log : NSObject

@property (strong, nonatomic) NSArray *cupNames;

- (NSString *) chooseCupName:(NSInteger) row;
- (NSUInteger) countOfCups;

@end
