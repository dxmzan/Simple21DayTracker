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

@interface CalendarViewController ()

@end

@implementation CalendarViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self logCalendar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(prevButton)
                                                 name:@"previousButtonPressed"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nextButton)
                                                 name:@"nextButtonPressed"
                                               object:nil];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.firstDateofMonth];
    NSUInteger numberOfDaysInMonth = range.length;
    
    if ([self.firstDayOfMonth isEqualToString:@"Sunday"]){
        return numberOfDaysInMonth;
    } else if ([self.firstDayOfMonth isEqualToString:@"Monday"]){
        return numberOfDaysInMonth + 1;
    } else if ([self.firstDayOfMonth isEqualToString:@"Tuesday"]){
        return numberOfDaysInMonth + 2;
    } else if ([self.firstDayOfMonth isEqualToString:@"Wednesday"]){
        return numberOfDaysInMonth + 3;
    } else if ([self.firstDayOfMonth isEqualToString:@"Thursday"]){
        return numberOfDaysInMonth + 4;
    } else if ([self.firstDayOfMonth isEqualToString:@"Friday"]){
        return numberOfDaysInMonth + 5;
    } else if ([self.firstDayOfMonth isEqualToString:@"Saturday"]){
        return numberOfDaysInMonth + 6;
    } else {
        return numberOfDaysInMonth;
    }
    
}

-(void)logCalendar {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    self.dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday fromDate:[NSDate date]];
    //[dateComps setMonth: NSCalendarUnitMonth];
    [self.dateComps setDay:1];
    
    self.firstDateofMonth = [calendar dateFromComponents:self.dateComps];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"EEEE"];
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MMMM"];

    
    self.currentMonth = [monthFormatter stringFromDate:self.firstDateofMonth];
    
    self.firstDayOfMonth = [dayFormatter stringFromDate:self.firstDateofMonth];
    
    NSLog(@"Starting day of the month: %@", self.firstDayOfMonth);
    NSLog(@"Month: %@", self.currentMonth);
    
    NSLog(@"First date of Month: %@", self.firstDateofMonth);

}

-(void)updateCalendar {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];

    [self.dateComps setMonth:NSCalendarUnitMonth + 2];
    
    //NSLog(@"%lu", (unsigned long)NSCalendarUnitMonth);
    
    self.firstDateofMonth = [calendar dateFromComponents:self.dateComps];
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MMMM"];

    self.currentMonth = [monthFormatter stringFromDate:self.firstDateofMonth];

    NSLog(@"Updated month: %@", self.currentMonth);
    
    [self.publicCollectionView reloadData];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    self.publicCollectionView = collectionView;
    // If the first day of the month begins on ...
    
    UIFontDescriptor *cellFont = [cell.dayLabel.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    // Sunday
    if ([self.firstDayOfMonth isEqualToString:@"Sunday"]){
        cell.backgroundColor = [UIColor whiteColor];
        cell.dayLabel.font = [UIFont fontWithDescriptor:cellFont size:0];
        [cell.dayLabel setText: [NSString stringWithFormat:@"%ld", (long) indexPath.row + 1]];
    }
    
    // Monday
    if ([self.firstDayOfMonth isEqualToString:@"Monday"]){
        if (indexPath.row < 1){
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.dayLabel.font = [UIFont fontWithDescriptor:cellFont size:0];
            [cell.dayLabel setText:@""];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            [cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row]];
        }
    }
    
    // Tuesday
    if ([self.firstDayOfMonth isEqualToString:@"Tuesday"]){
        if (indexPath.row < 2){
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.dayLabel.font = [UIFont fontWithDescriptor:cellFont size:10];
            [cell.dayLabel setText:@""];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            [cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row-1]];
        }
    }
    
    // Wednesday
    if ([self.firstDayOfMonth isEqualToString:@"Wednesday"]){
        if (indexPath.row < 3){
            cell.backgroundColor = [UIColor lightGrayColor];
            [cell.dayLabel setText:@""];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            [cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 2]];
        }
    }
    
    // Thursday
    if ([self.firstDayOfMonth isEqualToString:@"Thursday"]){
        if (indexPath.row < 4){
            cell.backgroundColor = [UIColor lightGrayColor];
            [cell.dayLabel setText:@""];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            [cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 3]];
        }
    }
    
    // Friday
    if ([self.firstDayOfMonth isEqualToString:@"Friday"]){
        if (indexPath.row < 5){
            cell.backgroundColor = [UIColor lightGrayColor];
            [cell.dayLabel setText:@""];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            [cell.dayLabel setText:[NSString stringWithFormat:@"%ld", (long) indexPath.row - 4]];
        }
    }

    // Saturday
    if ([self.firstDayOfMonth isEqualToString:@"Saturday"]){
            if(indexPath.row < 6){
                cell.backgroundColor = [UIColor lightGrayColor];
                [cell.dayLabel setText:@""];
            } else {
                cell.backgroundColor = [UIColor whiteColor];
                [cell.dayLabel setText: [NSString stringWithFormat:@"%ld", (long) indexPath.row-5]];
            }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

-(void)prevButton {
    NSLog(@"Previous button pressed");
    [self updateCalendar];
    
}

-(void)nextButton {
    NSLog(@"Next button pressed");
    
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"previousButtonPressed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"nextButtonPressed" object:nil];
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
