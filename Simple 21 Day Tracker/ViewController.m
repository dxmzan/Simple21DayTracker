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
#import "CalendarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Cups = [[Cups alloc] init];
    self.Log = [[Log alloc] init];
    self.Date = [[Date alloc] init];
    self.CalendarViewController =[[CalendarViewController alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self printGoals];
    NSLog(@"What is this: %@", self.receivedDate);
    [self.Cups setReceiveDate:self.receivedDate];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 375, 72)];

    dateLabel.text = [self.Date formattedDate];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor blackColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    [self.view addSubview:dateLabel];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    if (self.receivedDate == nil){
        self.receivedDate = [self.Date formattedDate];
    }
    
    NSLog(@"VC date: %@", self.receivedDate);
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
        //NSLog(@"Same day: %@", query);
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
    }
    
    // Observer for settings switches
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(targetSwitchEnabled:)
                                                 name:@"switchToggled"
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    // Check if goal is still met
    [self isGoalMet];
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
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups green]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups greenGoal]];

            break;
        case 1:
            self.cell.backgroundColor = [UIColor colorWithRed:0.878 green:0.251 blue:0.984 alpha:1]; // Purple
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups purple]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups purpleGoal]];
            break;
        case 2:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.251 blue:0.506 alpha:1]; // Red
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups red]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups redGoal]];
            break;
        case 3:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1]; // Yellow
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups yellow]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups yellowGoal]];
            break;
        case 4:
            self.cell.backgroundColor = [UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1]; // Blue
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups blue]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups blueGoal]];
            break;
        case 5:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.596 blue:0 alpha:1]; // Orange
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups orange]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups orangeGoal]];
            break;
        case 6:
            self.cell.backgroundColor = [UIColor colorWithRed:0.502 green:0.871 blue:0.918 alpha:1]; // Water
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups water]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups waterGoal]];
            break;
        case 7:
            self.cell.backgroundColor = [UIColor colorWithRed:0.74 green:0.67 blue:0.64 alpha:1.0];; // Spoon
            self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups spoon]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups spoonGoal]];
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
        switch (_cellRow)
        {
            case 0:
                if ([self.Cups green] > 0){
                    [self.Cups setGreen: [self.Cups subtractCup:[self.Cups green]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups green]];
                }
                break;
            case 1:
                if ([self.Cups purple] > 0){
                    [self.Cups setPurple:[self.Cups subtractCup:[self.Cups purple]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups purple]];
                }
                break;
            case 2:
                if ([self.Cups red] > 0){
                    [self.Cups setRed:[self.Cups subtractCup:[self.Cups red]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups red]];
                }
                break;
            case 3:
                if ([self.Cups yellow] > 0){
                    [self.Cups setYellow:[self.Cups subtractCup:[self.Cups yellow]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups yellow]];
                }
                break;
            case 4:
                if ([self.Cups blue] > 0){
                    [self.Cups setBlue:[self.Cups subtractCup:[self.Cups blue]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups blue]];
                }
                break;
            case 5:
                if ([self.Cups orange] > 0){
                    [self.Cups setOrange:[self.Cups subtractCup:[self.Cups orange]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups orange]];
                }
                break;
            case 6:
                if ([self.Cups water] > 0){
                    [self.Cups setWater:[self.Cups subtractCup:[self.Cups water]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups water]];
                }
                break;
            case 7:
                if ([self.Cups spoon] > 0){
                    [self.Cups setSpoon:[self.Cups subtractCup:[self.Cups spoon]]];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.Cups spoon]];
                }
                break;
        }
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

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
    return 68;
}

-(void)targetSwitchEnabled: (NSNotification *) notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *idSwitch = (NSString *) userInfo[@"Switch"];
    
    int switchNum = [idSwitch intValue];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    switch(switchNum)
    {
        case 0:
            [self.Cups setGreenGoal:3];
            [self.Cups setPurpleGoal:2];
            [self.Cups setRedGoal:4];
            [self.Cups setYellowGoal:2];
            [self.Cups setBlueGoal:1];
            [self.Cups setOrangeGoal:1];
            [self.Cups setSpoonGoal:2];
            [self.Cups setWaterGoal:12];
            break;
        case 1:
            [self.Cups setGreenGoal:4];
            [self.Cups setPurpleGoal:3];
            [self.Cups setRedGoal:4];
            [self.Cups setYellowGoal:3];
            [self.Cups setBlueGoal:1];
            [self.Cups setOrangeGoal:1];
            [self.Cups setSpoonGoal:4];
            [self.Cups setWaterGoal:12];
            break;
        case 2:
            [self.Cups setGreenGoal:5];
            [self.Cups setPurpleGoal:3];
            [self.Cups setRedGoal:5];
            [self.Cups setYellowGoal:4];
            [self.Cups setBlueGoal:1];
            [self.Cups setOrangeGoal:1];
            [self.Cups setSpoonGoal:5];
            [self.Cups setWaterGoal:12];
            break;
        case 3:
            [self.Cups setGreenGoal:6];
            [self.Cups setPurpleGoal:4];
            [self.Cups setRedGoal:6];
            [self.Cups setYellowGoal:4];
            [self.Cups setBlueGoal:1];
            [self.Cups setOrangeGoal:1];
            [self.Cups setSpoonGoal:6];
            [self.Cups setWaterGoal:12];
            break;
    }
    [realm commitWriteTransaction];
    
    [self printGoals];

}

-(void)printGoals{
    
    switch (_cellRow){
        case 0:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups greenGoal]];
            break;
        case 1:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups purpleGoal]];
            break;
        case 2:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups redGoal]];
            break;
        case 3:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups yellowGoal]];
            break;
        case 4:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups blueGoal]];
            break;
        case 5:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups orangeGoal]];
            break;
        case 6:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups waterGoal]];
            break;
        case 7:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %d", [self.Cups spoonGoal]];
            break;
    }
    [self.scopedTableView reloadData];
    
}


-(void)isGoalMet {
    if (![self.Cups goalIsNotMet]){
        [self.Cups goalIsMet];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"switchToggled" object:nil];
}

@end
