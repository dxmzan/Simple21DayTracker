//
//  CalendarViewController.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/26/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarViewCell.h"
#import "ViewController.h"
#import "CalendarHeader.h"
#import "Cups.h"
#import "Date.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Date = [[Date alloc]init];
    
    [self.Date createCalendar];

}

- (void) viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(prevButton)
                                                 name:@"previousButtonPressed"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nextButton)
                                                 name:@"nextButtonPressed"
                                               object:nil];
    [self queryCalendar];
}

- (void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"previousButtonPressed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"nextButtonPressed" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Calendar Setup

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger days = [self.Date numberOfDaysInMonth];
    
    if ([[self.Date currentDay] isEqualToString:@"Sunday"]){
        return days;
    } else if ([[self.Date currentDay] isEqualToString:@"Monday"]){
        return days + 1;
    } else if ([[self.Date currentDay] isEqualToString:@"Tuesday"]){
        return days + 2;
    } else if ([[self.Date currentDay] isEqualToString:@"Wednesday"]){
        return days + 3;
    } else if ([[self.Date currentDay] isEqualToString:@"Thursday"]){
        return days + 4;
    } else if ([[self.Date currentDay] isEqualToString:@"Friday"]){
        return days + 5;
    } else if ([[self.Date currentDay] isEqualToString:@"Saturday"]){
        return days + 6;
    } else {
        return days;
    }
    
}

#pragma mark View Setup

- (void)queryCalendar {   
    NSPredicate *datePred =  [NSPredicate predicateWithFormat:@"isGoalMet == YES AND month == %@ AND year == %@", [self.Date currentMonth], [self.Date currentYear]];
    
    RLMResults *query = [Cups objectsWithPredicate:datePred];
        
    // Add days into array — this is used to color the days.
    self.days = [query valueForKey:@"day"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    self.publicCollectionView = collectionView;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:[self.Date currentDate]];
    NSInteger calendarOffset = weekday - calendar.firstWeekday;
    NSInteger selectedDay = (indexPath.row - calendarOffset) + 1;
      
    // Check if query returns isGoalMet and then color cells appropriately.
    
    if ([self.days containsObject:[NSString stringWithFormat:@"%ld", (long) selectedDay]]){
        self.cell.backgroundColor =  [UIColor colorWithRed:0.73 green:0.96 blue:0.79 alpha:1.0];
    } else {
        self.cell.backgroundColor = [UIColor whiteColor];
    }
    
    // If the first day of the month begins on ...
    
    // Sunday
    if ([[self.Date currentDay] isEqualToString:@"Sunday"]){
        [self.cell.dayLabel setText: [NSString stringWithFormat:@"%ld", (long) indexPath.row + 1]];
    }
    
    // Monday
    if ([[self.Date currentDay] isEqualToString:@"Monday"]){
        if (indexPath.row < 1){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row]];
        }
    }
    
    // Tuesday
    if ([[self.Date currentDay] isEqualToString:@"Tuesday"]){
        if (indexPath.row < 2){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row-1]];
        }
    }
    
    // Wednesday
    if ([[self.Date currentDay] isEqualToString:@"Wednesday"]){
        if (indexPath.row < 3){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 2]];
        }
    }
    
    // Thursday
    if ([[self.Date currentDay] isEqualToString:@"Thursday"]){
        if (indexPath.row < 4){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 3]];
        }
    }
    
    // Friday
    if ([[self.Date currentDay] isEqualToString:@"Friday"]){
        if (indexPath.row < 5){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 4]];
        }
    }

    // Saturday
    if ([[self.Date currentDay] isEqualToString:@"Saturday"]){
            if(indexPath.row < 6){
                [self.cell.dayLabel setText:@""];
            } else {
                [self.cell.dayLabel setText: [NSString stringWithFormat:@"%ld", (long) indexPath.row-5]];
            }
    }
        return self.cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        CalendarHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeaderView" forIndexPath:indexPath];
        
        headerView.monthName.text = [self.Date currentMonth];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 75);
}

-(void)prevButton {

    self.Date.newMonth--;
    
    self.Date.componentsForDate.month = self.Date.newMonth;
    
    [self.Date updateCalendar];
    
    [self queryCalendar];
    
    [self.publicCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
}

-(void)nextButton {
    
    self.Date.newMonth++;
    
    self.Date.componentsForDate.month = self.Date.newMonth;
    
    [self.Date updateCalendar];
    
    [self queryCalendar];
    
    [self.publicCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];

}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:sender];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:[self.Date currentDate]];
    NSInteger calendarOffset = weekday - calendar.firstWeekday;
    NSInteger selectedDay = (indexPath.row - calendarOffset) + 1;
    
    self.selectedDayString = [NSString stringWithFormat:@"%@ %ld, %@", [self.Date currentMonth], (long) selectedDay, [self.Date currentYear]];
    
    
    if (indexPath.row < calendarOffset){
        return NO;
    } else {
        return YES;
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"dateSegue"]){
        ViewController *vc = [segue destinationViewController];
        vc.receivedDate = self.selectedDayString;
    }
}


@end
