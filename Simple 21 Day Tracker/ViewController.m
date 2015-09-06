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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cupType = @[@"Green", @"Purple", @"Red", @"Yellow", @"Blue", @"Orange", @"Water", @"Spoon"];
    self.cupCount = [NSMutableArray arrayWithObjects: @0, @0, @0, @0, @0, @0, @0,@0, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 375, 72)];
    
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"MMMM d, yyyy";
    NSString *dateString = [self.formatter stringFromDate:[NSDate date]];
    
    date.text = dateString;
    date.backgroundColor = [UIColor clearColor];
    date.textColor = [UIColor blackColor];
    date.textAlignment = NSTextAlignmentCenter;
    date.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    [self.view addSubview:date];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    self.myCup = [[Cups alloc] init];
    
    if (self.receivedDate == nil){
        self.receivedDate = dateString;
    }
    
    NSLog(@"Received date: %@", self.receivedDate);
    NSString *newReceivedDate = [self.receivedDate stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSArray *breakUpDate = [newReceivedDate componentsSeparatedByString:@" "];
    
    NSPredicate *datePred =  [NSPredicate predicateWithFormat:@"date == %@", self.receivedDate];
    
    RLMResults *query = [Cups objectsWithPredicate:datePred];
    
    NSString *queryDate = [[query valueForKey:@"date"] componentsJoinedByString:@""];
    
    // Check if date is equal to today's date. If false, create new object.
    
    if ([queryDate isEqualToString:self.receivedDate])
    {
        // Update same-day object
        self.myCup = [query objectAtIndex:0];
        date.text = self.receivedDate;
        NSLog(@"Same day: %@", query);
    } else {
        // Create new object with new date
        [realm transactionWithBlock:^{
            [self.myCup setDate:self.receivedDate];
            [self.myCup setMonth:breakUpDate[0]];
            [self.myCup setDay:breakUpDate[1]];
            [self.myCup setYear:breakUpDate[2]];
            [realm addObject:self.myCup];
            date.text = self.receivedDate;
        }];
    }
    
    // Observer for settings switches
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(targetSwitchEnabled:)
                                                 name:@"switchToggled"
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"switchToggled" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cupType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"SimpleIdentifer";
    self.scopedTableView = tableView;
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (self.cell == nil)
    {
        self.cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleIdentifier];
    }
    
    tableView.backgroundColor = [UIColor clearColor];
    _cellRow = indexPath.row;
        
    // Label text
        
    self.cell.textLabel.text = self.cupType[indexPath.row];
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
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup green]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup greenGoal]];

            break;
        case 1:
            self.cell.backgroundColor = [UIColor colorWithRed:0.878 green:0.251 blue:0.984 alpha:1]; // Purple
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup purple]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup purpleGoal]];
            break;
        case 2:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.251 blue:0.506 alpha:1]; // Red
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup red]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup redGoal]];
            break;
        case 3:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1]; // Yellow
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup yellow]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup yellowGoal]];
            break;
        case 4:
            self.cell.backgroundColor = [UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1]; // Blue
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup blue]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup blueGoal]];
            break;
        case 5:
            self.cell.backgroundColor = [UIColor colorWithRed:1 green:0.596 blue:0 alpha:1]; // Orange
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup orange]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup orangeGoal]];
            break;
        case 6:
            self.cell.backgroundColor = [UIColor colorWithRed:0.502 green:0.871 blue:0.918 alpha:1]; // Water
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup water]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup waterGoal]];
            break;
        case 7:
            self.cell.backgroundColor = [UIColor colorWithRed:0.74 green:0.67 blue:0.64 alpha:1.0];; // Spoon
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup spoon]];
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup spoonGoal]];
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
                if ([self.myCup green] > 0){
                    [self.myCup setGreen: [self.myCup green] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup green]];
                }
                break;
            case 1:
                if ([self.myCup purple] > 0){
                    [self.myCup setPurple:[self.myCup purple] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup purple]];
                }
                break;
            case 2:
                if ([self.myCup red] > 0){
                    [self.myCup setRed:[self.myCup red] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup red]];
                }
                break;
            case 3:
                if ([self.myCup yellow] > 0){
                    [self.myCup setYellow:[self.myCup yellow] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup yellow]];
                }
                break;
            case 4:
                if ([self.myCup blue] > 0){
                    [self.myCup setBlue:[self.myCup blue] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup blue]];
                }
                break;
            case 5:
                if ([self.myCup orange] > 0){
                    [self.myCup setOrange:[self.myCup orange] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup orange]];
                }
                break;
            case 6:
                if ([self.myCup water] > 0){
                    [self.myCup setWater:[self.myCup water] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup water]];
                }
                break;
            case 7:
                if ([self.myCup spoon] > 0){
                    [self.myCup setSpoon:[self.myCup spoon] - 1];
                    self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup spoon]];
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
            [self.myCup setGreen: [self.myCup addGreen:[self.myCup green]]];
            break;
        case 1:
            [self.myCup setPurple:[self.myCup addPurple:[self.myCup purple]]];
            break;
        case 2:
            [self.myCup setRed:[self.myCup addRed:[self.myCup red]]];
            break;
        case 3:
            [self.myCup setYellow:[self.myCup addYellow:[self.myCup yellow]]];
            break;
        case 4:
            [self.myCup setBlue:[self.myCup addBlue:[self.myCup blue]]];
            break;
        case 5:
            [self.myCup setOrange:[self.myCup addOrange:[self.myCup orange]]];
            break;
        case 6:
            [self.myCup setWater:[self.myCup addWater:[self.myCup water]]];
            break;
        case 7:
            [self.myCup setSpoon:[self.myCup addSpoon:[self.myCup spoon]]];
            break;
    }
        
    [realm commitWriteTransaction];
    
    [tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                     withRowAnimation: UITableViewRowAnimationNone];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59;
}

-(void)targetSwitchEnabled: (NSNotification *) notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *idSwitch = (NSString *) userInfo[@"Switch"];
    NSLog(@"Switch %@ pushed", idSwitch);

    int switchNum = [idSwitch intValue];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    switch(switchNum)
    {
        case 0:
            [self.myCup setGreenGoal:@"3"];
            [self.myCup setPurpleGoal:@"2"];
            [self.myCup setRedGoal:@"4"];
            [self.myCup setYellowGoal:@"2"];
            [self.myCup setBlueGoal:@"1"];
            [self.myCup setOrangeGoal:@"1"];
            [self.myCup setSpoonGoal:@"2"];
            [self.myCup setWaterGoal:@"12"];
            break;
        case 1:
            [self.myCup setGreenGoal:@"4"];
            [self.myCup setPurpleGoal:@"3"];
            [self.myCup setRedGoal:@"4"];
            [self.myCup setYellowGoal:@"3"];
            [self.myCup setBlueGoal:@"1"];
            [self.myCup setOrangeGoal:@"1"];
            [self.myCup setSpoonGoal:@"4"];
            [self.myCup setWaterGoal:@"12"];
            break;
        case 2:
            [self.myCup setGreenGoal:@"5"];
            [self.myCup setPurpleGoal:@"3"];
            [self.myCup setRedGoal:@"5"];
            [self.myCup setYellowGoal:@"4"];
            [self.myCup setBlueGoal:@"1"];
            [self.myCup setOrangeGoal:@"1"];
            [self.myCup setSpoonGoal:@"5"];
            [self.myCup setWaterGoal:@"12"];
            break;
        case 3:
            [self.myCup setGreenGoal:@"6"];
            [self.myCup setPurpleGoal:@"4"];
            [self.myCup setRedGoal:@"6"];
            [self.myCup setYellowGoal:@"4"];
            [self.myCup setBlueGoal:@"1"];
            [self.myCup setOrangeGoal:@"1"];
            [self.myCup setSpoonGoal:@"6"];
            [self.myCup setWaterGoal:@"12"];
            break;
    }
    [realm commitWriteTransaction];
    
    switch (_cellRow){
        case 0:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup greenGoal]];
            break;
        case 1:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup purpleGoal]];
            break;
        case 2:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup redGoal]];
            break;
        case 3:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup yellowGoal]];
            break;
        case 4:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup blueGoal]];
            break;
        case 5:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup orangeGoal]];
            break;
        case 6:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup waterGoal]];
            break;
        case 7:
            self.cell.detailTextLabel.text = [NSString stringWithFormat:@"Goal: %@", [self.myCup spoonGoal]];
            break;
    }
    [self.scopedTableView reloadData];
}

@end
