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

@interface CalendarViewController ()


@end

@implementation CalendarViewController

NSString *month = @"September";
NSString *year = @"2015";
int i = 0;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self logCalendar]; // Load calendar

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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
    
    
    NSLog(@"Observers removed");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"previousButtonPressed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"nextButtonPressed" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Calendar Setup

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.firstDateOfMonth];
    NSUInteger numberOfDaysInMonth = range.length;
    
    if ([self.firstDateName isEqualToString:@"Sunday"]){
        return numberOfDaysInMonth;
    } else if ([self.firstDateName isEqualToString:@"Monday"]){
        return numberOfDaysInMonth + 1;
    } else if ([self.firstDateName isEqualToString:@"Tuesday"]){
        return numberOfDaysInMonth + 2;
    } else if ([self.firstDateName isEqualToString:@"Wednesday"]){
        return numberOfDaysInMonth + 3;
    } else if ([self.firstDateName isEqualToString:@"Thursday"]){
        return numberOfDaysInMonth + 4;
    } else if ([self.firstDateName isEqualToString:@"Friday"]){
        return numberOfDaysInMonth + 5;
    } else if ([self.firstDateName isEqualToString:@"Saturday"]){
        return numberOfDaysInMonth + 6;
    } else {
        return numberOfDaysInMonth;
    }
    
}

-(void)logCalendar {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    self.dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    [self.dateComps setDay:1]; // Set first day to 1
    
    self.setMonth = [self.dateComps month];
    
    self.setYear = [self.dateComps year];
    
    [self formatDate]; // Formatting both date and month
    
    self.firstDateOfMonth = [calendar dateFromComponents:self.dateComps]; // This is an NSDate
    
    self.currentMonth = [self.monthFormatter stringFromDate:self.firstDateOfMonth]; // "September"
    
    self.firstDateName = [self.dayFormatter stringFromDate:self.firstDateOfMonth]; // "Tuesday"
    
    self.currentYear = [self.yearFormatter stringFromDate:self.firstDateOfMonth]; // "2015"
    
    NSLog(@"Month: %@", self.currentMonth);
    
    [self queryCalendar];

}

-(void)updateCalendar {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    self.firstDateOfMonth = [calendar dateFromComponents:self.dateComps];
    
    self.currentMonth = [self.monthFormatter stringFromDate:self.firstDateOfMonth];
    self.firstDateName = [self.dayFormatter stringFromDate:self.firstDateOfMonth];
    self.currentYear = [self.yearFormatter stringFromDate:self.firstDateOfMonth];
    
    [self queryCalendar];
    
    [self.publicCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

#pragma mark View Setup

- (void)queryCalendar {   
    NSPredicate *datePred =  [NSPredicate predicateWithFormat:@"isGoalMet == YES AND month == %@ AND year == %@", self.currentMonth, self.currentYear];
    
    RLMResults *query = [Cups objectsWithPredicate:datePred];
    
    // Add days into array
    self.days = [query valueForKey:@"day"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    self.publicCollectionView = collectionView;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:self.firstDateOfMonth];
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
    if ([self.firstDateName isEqualToString:@"Sunday"]){
        [self.cell.dayLabel setText: [NSString stringWithFormat:@"%ld", (long) indexPath.row + 1]];
    }
    
    // Monday
    if ([self.firstDateName isEqualToString:@"Monday"]){
        if (indexPath.row < 1){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row]];
        }
    }
    
    // Tuesday
    if ([self.firstDateName isEqualToString:@"Tuesday"]){
        if (indexPath.row < 2){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row-1]];
        }
    }
    
    // Wednesday
    if ([self.firstDateName isEqualToString:@"Wednesday"]){
        if (indexPath.row < 3){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 2]];
        }
    }
    
    // Thursday
    if ([self.firstDateName isEqualToString:@"Thursday"]){
        if (indexPath.row < 4){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 3]];
        }
    }
    
    // Friday
    if ([self.firstDateName isEqualToString:@"Friday"]){
        if (indexPath.row < 5){
            [self.cell.dayLabel setText:@""];
        } else {
            [self.cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 4]];
        }
    }

    // Saturday
    if ([self.firstDateName isEqualToString:@"Saturday"]){
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
        
        headerView.monthName.text = self.currentMonth;
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(50, 75);
}
-(void)prevButton {
    self.setMonth--;
    [self.dateComps setMonth:self.setMonth];
    [self updateCalendar];
    
}

-(void)nextButton {
    self.setMonth++;
    [self.dateComps setMonth:self.setMonth];
    [self updateCalendar];
    
}

-(void)formatDate {
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"EEEE"];
    
    self.monthFormatter = [[NSDateFormatter alloc] init];
    [self.monthFormatter setDateFormat:@"MMMM"];
    
    self.yearFormatter = [[NSDateFormatter alloc] init];
    [self.yearFormatter setDateFormat:@"YYYY"];
    
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:sender];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:self.firstDateOfMonth];
    NSInteger calendarOffset = weekday - calendar.firstWeekday;
    NSInteger selectedDay = (indexPath.row - calendarOffset) + 1;
    
    self.selectedDayString = [NSString stringWithFormat:@"%@ %ld, %@", self.currentMonth, (long) selectedDay, self.currentYear];
    
    
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
        NSLog(@"Date sent: %@", self.selectedDayString);
    }
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
