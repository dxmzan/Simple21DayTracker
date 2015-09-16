//
//  Date.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 9/11/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject

@property (strong, nonatomic) NSDateFormatter *formatter;

@property (strong, nonatomic) NSString *dateString;

@property (strong, nonatomic) NSString *receivedDate;

-(NSString *)formattedDate;


@end
