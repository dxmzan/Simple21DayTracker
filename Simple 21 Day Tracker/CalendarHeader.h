//
//  CalendarHeader.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/31/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarHeader : UICollectionReusableView
- (IBAction)prevButton:(id)sender;
- (IBAction)nextButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *monthName;
@property (strong, nonatomic) UILabel *theDays;

@property (strong, nonatomic) UILabel *monday;
@property (strong, nonatomic) UILabel *tuesday;
@property (strong, nonatomic) UILabel *wednesday;
@property (strong, nonatomic) UILabel *thursday;
@property (strong, nonatomic) UILabel *friday;
@property (strong, nonatomic) UILabel *saturday;
@property (strong, nonatomic) UILabel *sunday;


@end
