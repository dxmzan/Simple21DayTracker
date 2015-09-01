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
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
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
    
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDate *firstDateofMonth = [calendar dateFromComponents:dateComps];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    self.firstDayOfMonth = [dateFormatter stringFromDate:firstDateofMonth];
    
    NSLog(@"Starting day of the month: %@", self.firstDayOfMonth);
    
    NSLog(@"First date of Month: %@", firstDateofMonth);

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // If the first day of the month begins on ...
    
    // Sunday
    if ([self.firstDayOfMonth isEqualToString:@"Sunday"]){
            cell.backgroundColor = [UIColor whiteColor];
            [cell.dayLabel setText: [NSString stringWithFormat:@"%ld", (long) indexPath.row + 1]];
    }
    
    // Monday
    if ([self.firstDayOfMonth isEqualToString:@"Monday"]){
        if (indexPath.row < 1){
            cell.backgroundColor = [UIColor lightGrayColor];
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
        reusableview = headerView;
    }
    return reusableview;
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
