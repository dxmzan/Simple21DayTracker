//
//  CalendarViewController.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/26/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class CalendarViewCell;
@class Date;
@class Cups;


@interface CalendarViewController : UICollectionViewController

@property (strong, nonatomic) Date *Date;
@property (strong, nonatomic) Cups *Cups;
@property (strong, nonatomic) ViewController *logView;
@property (strong, nonatomic) NSString *selectedDayString;
@property (strong, nonatomic) UICollectionView *publicCollectionView;
@property (strong, nonatomic) NSMutableArray *days;
@property (nonatomic) CalendarViewCell *cell;

@end
