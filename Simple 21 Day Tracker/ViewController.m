//
//  ViewController.m
//  T1DF
//
//  Created by Shaun on 8/10/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "ViewController.h"
#import "Cups.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
#import "Log.h"
#import "Date.h"
#import "SettingsViewController.h"

#define DEFAULT_GOALS 5
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Cups = [[Cups alloc] init];
    self.Log = [[Log alloc] init];
    self.Date = [[Date alloc] init];
    self.SettingsViewController = [[SettingsViewController alloc]init];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self isGoalMet];
}


- (void)viewWillAppear:(BOOL)animated{
    [self.scopedTableView reloadData];
    CGRect screen = [[UIScreen mainScreen]bounds];
    CGFloat screenWidth = screen.size.width;
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, screenWidth, 72)];

    dateLabel.text = [self.Date returnTodaysDate];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor blackColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    [self.view addSubview:dateLabel];
    
    // Query
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    if (self.receivedDate == nil){
        self.receivedDate = [self.Date returnTodaysDate];
    }
    
    NSString *newReceivedDate = [self.receivedDate stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSArray *breakUpDate = [newReceivedDate componentsSeparatedByString:@" "];
    
    NSPredicate *datePred =  [NSPredicate predicateWithFormat:@"date == %@", self.receivedDate];
    
    RLMResults *query = [Cups objectsWithPredicate:datePred];
    
    NSString *queryDate = [[query valueForKey:@"date"] componentsJoinedByString:@""];
    
    // Check if date is equal to today's date. If false, create new object.
    
    if ([queryDate isEqualToString:self.receivedDate])
    {
        // Update same-day object
        self.Cups = [query objectAtIndex:0];
        dateLabel.text = self.receivedDate;
    } else {
        // Create new object with new date
        [realm transactionWithBlock:^{
            [self.Cups setDate:self.receivedDate];
            [self.Cups setMonth:breakUpDate[0]];
            [self.Cups setDay:breakUpDate[1]];
            [self.Cups setYear:breakUpDate[2]];
            [realm addObject:self.Cups];
            dateLabel.text = self.receivedDate;
        }];
        [self.Cups setGoals:DEFAULT_GOALS setDate:self.receivedDate];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.Log countOfCups];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"SimpleIdentifer";
    self.scopedTableView = tableView;
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (self.cell == nil)
    {
        self.cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SimpleIdentifier"];
    }
    
    tableView.backgroundColor = [UIColor clearColor];
    _cellRow = indexPath.row;
        
    // Label text
        
    self.cell.textLabel.text = [self.Log chooseCupName:indexPath.row];
    self.cell.textLabel.textColor = [UIColor whiteColor];
    self.cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    
    //Detail text
    self.cell.detailTextLabel.text = @"Goal";
    self.cell.detailTextLabel.textColor = [UIColor whiteColor];
    self.cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    // Counter
    self.counter = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    self.counter.backgroundColor = [UIColor clearColor];
    self.counter.textColor = [UIColor whiteColor];
    
    [self.counter setFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    
    self.counter.textAlignment = NSTextAlignmentCenter;
    
    switch(indexPath.row)
    {
        case 0:
            self.cell.backgroundColor = [UIColor colorWithRed:0 green:0.902 blue:0.463 alpha:1]; // Green
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups green]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups greenGoal]];
            break;
        case 1:
            self.cell.backgroundColor = [UIColor colorWithRed:0.878 green:0.251 blue:0.984 alpha:1]; // Purple
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups purple]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups purpleGoal]];
            break;
        case 2:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.251 blue:0.506 alpha:1]; // Red
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups red]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups redGoal]];
            break;
        case 3:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1]; // Yellow
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups yellow]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups yellowGoal]];
            break;
        case 4:
            self.cell.backgroundColor = [UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1]; // Blue
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups blue]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups blueGoal]];
            break;
        case 5:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.596 blue:0 alpha:1]; // Orange
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups orange]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups orangeGoal]];
            break;
        case 6:
            self.cell.backgroundColor = [UIColor colorWithRed:0.502 green:0.871 blue:0.918 alpha:1]; // Water
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups water]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups waterGoal]];
            break;
        case 7:
            self.cell.backgroundColor = [UIColor colorWithRed:0.74 green:0.67 blue:0.64 alpha:1.0];; // Spoon
            self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups spoon]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %ld", (long)[self.Cups spoonGoal]];
            break;
            
        default: self.cell.backgroundColor = [UIColor clearColor];
    }
    
    // Container
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    [container addSubview:self.counter];
    
    self.cell.accessoryView = container;
    
    RLMRealm *realm = [RLMRealm defaultRealm];

    self.cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Subtract" backgroundColor:[UIColor grayColor] callback:^BOOL(MGSwipeTableCell *sender){
        [realm beginWriteTransaction];
        // Minus 1 from counter
        switch (indexPath.row)
        {
            case 0:
                if ([self.Cups green] > 0){
                    [self.Cups setGreen: [self.Cups subtractCup:[self.Cups green]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups green]];
                }
                break;
            case 1:
                if ([self.Cups purple] > 0){
                    [self.Cups setPurple:[self.Cups subtractCup:[self.Cups purple]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups purple]];
                }
                break;
            case 2:
                if ([self.Cups red] > 0){
                    [self.Cups setRed:[self.Cups subtractCup:[self.Cups red]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups red]];
                }
                break;
            case 3:
                if ([self.Cups yellow] > 0){
                    [self.Cups setYellow:[self.Cups subtractCup:[self.Cups yellow]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups yellow]];
                }
                break;
            case 4:
                if ([self.Cups blue] > 0){
                    [self.Cups setBlue:[self.Cups subtractCup:[self.Cups blue]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups blue]];
                }
                break;
            case 5:
                if ([self.Cups orange] > 0){
                    [self.Cups setOrange:[self.Cups subtractCup:[self.Cups orange]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups orange]];
                }
                break;
            case 6:
                if ([self.Cups water] > 0){
                    [self.Cups setWater:[self.Cups subtractCup:[self.Cups water]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups water]];
                }
                break;
            case 7:
                if ([self.Cups spoon] > 0){
                    [self.Cups setSpoon:[self.Cups subtractCup:[self.Cups spoon]]];
                    self.counter.text = [NSString stringWithFormat:@"%ld", (long)[self.Cups spoon]];
                }
                break;
        }
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];

        [realm commitWriteTransaction];
         return NO;
    }]];

    self.cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;

    
    return self.cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    switch (indexPath.row)
    {
        case 0:
            [self.Cups setGreen: [self.Cups addCup:[self.Cups green]]];
            break;
        case 1:
            [self.Cups setPurple:[self.Cups addCup:[self.Cups purple]]];
            break;
        case 2:
            [self.Cups setRed:[self.Cups addCup:[self.Cups red]]];
            break;
        case 3:
            [self.Cups setYellow:[self.Cups addCup:[self.Cups yellow]]];
            break;
        case 4:
            [self.Cups setBlue:[self.Cups addCup:[self.Cups blue]]];
            break;
        case 5:
            [self.Cups setOrange:[self.Cups addCup:[self.Cups orange]]];
            break;
        case 6:
            [self.Cups setWater:[self.Cups addCup:[self.Cups water]]];
            break;
        case 7:
            [self.Cups setSpoon:[self.Cups addCup:[self.Cups spoon]]];
            break;
    }
        
    [realm commitWriteTransaction];
    
    [tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                     withRowAnimation: UITableViewRowAnimationNone];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE_6_PLUS){
        return 76;
    } else if (IS_IPHONE_5){
        return 55;
    } else if (IS_IPHONE_4) {
        return 44;
    } else {
        return 68;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toSettings"]){
        SettingsViewController *svc = [segue destinationViewController];
        svc.sentDate = self.receivedDate;
    }
    
}

-(void)isGoalMet {
    if (![self.Cups goalIsNotMet:self.receivedDate]){
        [self.Cups goalIsMet:self.receivedDate];
    }
}


@end
