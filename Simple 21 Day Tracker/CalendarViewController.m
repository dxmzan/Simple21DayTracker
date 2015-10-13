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

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

@interface CalendarViewController ()

@property (strong, nonatomic) UILabel *theDays;
@end

@implementation CalendarViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Date = [[Date alloc]init];
    self.Cups = [[Cups alloc]init];
    
    [self.Date createCalendar];

}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [super viewWillDisappear:animated];
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
        
        NSString *monthYearLabel = [NSString stringWithFormat:@"%@ %@", [self.Date currentMonth], [self.Date currentYear]];
        headerView.monthName.text = monthYearLabel;
        
        if (IS_IPHONE_6){
            headerView.sunday = [[UILabel alloc]initWithFrame:CGRectMake(30, 46, 42, 17)];
            headerView.monday = [[UILabel alloc]initWithFrame:CGRectMake(81, 46, 42, 17)];
            headerView.tuesday = [[UILabel alloc]initWithFrame:CGRectMake(131, 46, 42, 17)];
            headerView.wednesday = [[UILabel alloc]initWithFrame:CGRectMake(181, 46, 42, 17)];
            headerView.thursday = [[UILabel alloc]initWithFrame:CGRectMake(232, 46, 42, 17)];
            headerView.friday = [[UILabel alloc]initWithFrame:CGRectMake(282, 46, 42, 17)];
            headerView.saturday = [[UILabel alloc]initWithFrame:CGRectMake(332, 46, 42, 17)];
        } else if (IS_IPHONE_6_PLUS){
            headerView.sunday = [[UILabel alloc]initWithFrame:CGRectMake(32, 46, 42, 17)];
            headerView.monday = [[UILabel alloc]initWithFrame:CGRectMake(86, 46, 42, 17)];
            headerView.tuesday = [[UILabel alloc]initWithFrame:CGRectMake(145, 46, 42, 17)];
            headerView.wednesday = [[UILabel alloc]initWithFrame:CGRectMake(199, 46, 42, 17)];
            headerView.thursday = [[UILabel alloc]initWithFrame:CGRectMake(258, 46, 42, 17)];
            headerView.friday = [[UILabel alloc]initWithFrame:CGRectMake(315, 46, 42, 17)];
            headerView.saturday = [[UILabel alloc]initWithFrame:CGRectMake(371, 46, 42, 17)];
        } else if (IS_IPHONE_5){
            headerView.sunday = [[UILabel alloc]initWithFrame:CGRectMake(26, 46, 42, 17)];
            headerView.monday = [[UILabel alloc]initWithFrame:CGRectMake(66, 46, 42, 17)];
            headerView.tuesday = [[UILabel alloc]initWithFrame:CGRectMake(112, 46, 42, 17)];
            headerView.wednesday = [[UILabel alloc]initWithFrame:CGRectMake(152, 46, 42, 17)];
            headerView.thursday = [[UILabel alloc]initWithFrame:CGRectMake(198, 46, 42, 17)];
            headerView.friday = [[UILabel alloc]initWithFrame:CGRectMake(242, 46, 42, 17)];
            headerView.saturday = [[UILabel alloc]initWithFrame:CGRectMake(283, 46, 42, 17)];
        } else if (IS_IPHONE_4){
            headerView.sunday = [[UILabel alloc]initWithFrame:CGRectMake(26, 46, 42, 17)];
            headerView.monday = [[UILabel alloc]initWithFrame:CGRectMake(66, 46, 42, 17)];
            headerView.tuesday = [[UILabel alloc]initWithFrame:CGRectMake(112, 46, 42, 17)];
            headerView.wednesday = [[UILabel alloc]initWithFrame:CGRectMake(152, 46, 42, 17)];
            headerView.thursday = [[UILabel alloc]initWithFrame:CGRectMake(198, 46, 42, 17)];
            headerView.friday = [[UILabel alloc]initWithFrame:CGRectMake(242, 46, 42, 17)];
            headerView.saturday = [[UILabel alloc]initWithFrame:CGRectMake(283, 46, 42, 17)];
        }
        
        
        headerView.sunday.text = @"S";
        headerView.monday.text = @"M";
        headerView.tuesday.text = @"T";
        headerView.wednesday.text = @"W";
        headerView.thursday.text = @"T";
        headerView.friday.text = @"F";
        headerView.saturday.text = @"S";
        
        [headerView addSubview:headerView.sunday];
        [headerView addSubview:headerView.monday];
        [headerView addSubview:headerView.tuesday];
        [headerView addSubview:headerView.wednesday];
        [headerView addSubview:headerView.thursday];
        [headerView addSubview:headerView.friday];
        [headerView addSubview:headerView.saturday];

        reusableview = headerView;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_6_PLUS){
        return CGSizeMake(55, 75);
    } else if (IS_IPHONE_6){
        return CGSizeMake(50, 75);
    } else {
        return CGSizeMake(42, 75);
    }
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
    
    // Clear old viewcontroller and calendarviewcontroller off the stack
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];

    for (int i = 0; i < navigationArray.count - 1; i++){
        [navigationArray removeObjectAtIndex: 0];
    }
    
    self.navigationController.viewControllers = navigationArray;

}

@end
