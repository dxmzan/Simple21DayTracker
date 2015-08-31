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
@property (weak, nonatomic) IBOutlet UILabel *monthName;

@end
