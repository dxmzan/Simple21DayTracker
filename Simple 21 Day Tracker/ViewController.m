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
    self.cupType = @[@"Green", @"Purple", @"Red", @"Yellow", @"Blue", @"Orange", @"Water"];
    self.cupCount = [NSMutableArray arrayWithObjects: @0, @0, @0, @0, @0, @0, @0, nil];
    
//    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 375, 72)];
   
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"MMMM d, yyyy";
    NSString *dateString = [self.formatter stringFromDate:[NSDate date]];
//
//    date.text = dateString;
//    date.backgroundColor = [UIColor clearColor];
//    date.textColor = [UIColor blackColor];
//    date.textAlignment = NSTextAlignmentCenter;
//    date.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
//    
//    [self.view addSubview:date];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 375, 72)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    

    RLMRealm *realm = [RLMRealm defaultRealm];
    
    self.myCup = [[Cups alloc] init];
        
    NSPredicate *datePred =  [NSPredicate predicateWithFormat:@"date == %@", dateString];
    
    RLMResults *query = [Cups objectsWithPredicate:datePred];
    
    NSString *queryDate = [[query valueForKey:@"date"] componentsJoinedByString:@""];
    
    // Check if date is equal to today's date. If false, create new object.

    if ([queryDate isEqualToString:dateString])
    {
        // Update same-day object
        self.myCup = [query objectAtIndex:0];
        NSLog(@"Same day: %@", query);
    } else {
        // Create new object with new date and cupId
        [realm transactionWithBlock:^{
        [self.myCup setDate:dateString];
        //[self.myCup setCupId:@"5"];
        [realm addObject:self.myCup];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    // Cell image
    
//    UIImage *plusIcon = [UIImage imageNamed:@"add-new.png"];
//    cell.imageView.image = plusIcon;
    
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
        default: self.cell.backgroundColor = [UIColor clearColor];
    }
    
    // TODO: Queries should be separate file outside of ViewController
    
    // Container
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    [container addSubview:self.counter];
    
    self.cell.accessoryView = container;
    
    RLMRealm *realm = [RLMRealm defaultRealm];

    
    
//    UISwipeGestureRecognizer *gestureR;
//    gestureR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    gestureR.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.cell addGestureRecognizer:gestureR];
//    
//    UISwipeGestureRecognizer *gestureL;
//    gestureL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    gestureL.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.cell addGestureRecognizer:gestureL];

    self.cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Subtract" backgroundColor:[UIColor clearColor] callback:^BOOL(MGSwipeTableCell *sender){
        NSLog(@"Button clicked");
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
    }
        
    [realm commitWriteTransaction];
    
    [tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                     withRowAnimation: UITableViewRowAnimationNone];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

-(void)pickerChanged:(id)sender
{
    // This is broken
    
    NSString *dateStringFromSender = [self.formatter stringFromDate:[sender date]];
    
    RLMResults *query = [Cups objectsWhere:@"date == %@", dateStringFromSender];
    
    NSString *queryDate = [[query valueForKey:@"date"] componentsJoinedByString:@""];
    
    if ([queryDate length] > 0){
        NSLog(@"%@", queryDate);
        
        self.myCup = [query objectAtIndex:0];
        
        if (_cellRow == 0)
            self.counter.text = [NSString stringWithFormat:@"%d", [self.myCup green]];
        if (_cellRow == 1)
            self.counter.text = [NSString stringWithFormat:@"%d", self.myCup.purple];
        if (_cellRow == 2)
            self.counter.text = [NSString stringWithFormat:@"%d", self.myCup.red];
        if (_cellRow == 3)
            self.counter.text = [NSString stringWithFormat:@"%d", self.myCup.yellow];
        if (_cellRow == 4)
            self.counter.text = [NSString stringWithFormat:@"%d", self.myCup.blue];
        if (_cellRow == 5)
            self.counter.text = [NSString stringWithFormat:@"%d", self.myCup.orange];
        if (_cellRow == 6)
            self.counter.text = [NSString stringWithFormat:@"%d", self.myCup.water];
    } else {
        NSLog(@"No date on record");
    }
    [self.scopedTableView reloadData];

    
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight || sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
       
        RLMRealm *realm = [RLMRealm defaultRealm];
        
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
        }
        
        [realm commitWriteTransaction];
        
    }
}


@end
