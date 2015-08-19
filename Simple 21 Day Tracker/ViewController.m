//
//  ViewController.m
//  T1DF
//
//  Created by Shaun on 8/10/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "ViewController.h"
#import "Cups.h"

@interface ViewController ()

@end

@implementation ViewController

int finalCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cupType = @[@"Green", @"Purple", @"Red", @"Yellow", @"Blue", @"Orange", @"Water"];
    self.cupCount = [NSMutableArray arrayWithObjects: @0, @0, @0, @0, @0, @0, @0, nil];
    
//    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 375, 72)];
//    
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
        NSLog(@"Same day: %@", query);
        // TOOD: Update object if it already exists.
    } else {
        [realm transactionWithBlock:^{
        [self.myCup setDate:dateString];
        [self.myCup setCupId:@"4"];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleIdentifier];
    }
    
    tableView.backgroundColor = [UIColor clearColor];
    
    // Cell image
    
    UIImage *plusIcon = [UIImage imageNamed:@"add-new.png"];
    cell.imageView.image = plusIcon;
    
    // Label text
    
    cell.textLabel.text = self.cupType[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    
    //Detail text
    cell.detailTextLabel.text = @"Goal";
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    switch(indexPath.row)
    {
        case 0: cell.backgroundColor = [UIColor colorWithRed:0 green:0.902 blue:0.463 alpha:1]; // Green
            break;
        case 1: cell.backgroundColor = [UIColor colorWithRed:0.878 green:0.251 blue:0.984 alpha:1]; // Purple
            break;
        case 2: cell.backgroundColor = [UIColor colorWithRed:1 green:0.251 blue:0.506 alpha:1]; // Red
            break;
        case 3: cell.backgroundColor = [UIColor colorWithRed:1 green:0.757 blue:0.027 alpha:1]; // Yellow
            break;
        case 4: cell.backgroundColor = [UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1]; // Blue
            break;
        case 5: cell.backgroundColor = [UIColor colorWithRed:1 green:0.596 blue:0 alpha:1]; // Orange
            break;
        case 6: cell.backgroundColor = [UIColor colorWithRed:0.502 green:0.871 blue:0.918 alpha:1]; // Water
            break;
        default: cell.backgroundColor = [UIColor clearColor];
    }
    
    
    // Counter
    UILabel *counter = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    counter.backgroundColor = [UIColor clearColor];
    counter.textColor = [UIColor whiteColor];
    
    [counter setFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    
    NSString *countString = [NSString stringWithFormat:@"%d", finalCount];
    
    counter.text = countString;
    counter.textAlignment = NSTextAlignmentCenter;
    
    // TODO: Dynamically pull counter from database
    // TODO: Queries should be separate file outside of ViewController
    
    // Container
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    [container addSubview:counter];
    
    cell.accessoryView = container;
    
    
    return cell;
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
            finalCount = [self.myCup green];
            break;
        case 1:
            [self.myCup setPurple:[self.myCup addPurple:[self.myCup purple]]];
            finalCount = [self.myCup purple];
            break;
        case 2:
            [self.myCup setRed:[self.myCup addRed:[self.myCup red]]];
            finalCount = [self.myCup red];
            break;
        case 3:
            [self.myCup setYellow:[self.myCup addYellow:[self.myCup yellow]]];
            finalCount = [self.myCup yellow];
            break;
        case 4:
            [self.myCup setBlue:[self.myCup addBlue:[self.myCup blue]]];
            finalCount = [self.myCup blue];
            break;
        case 5:
            [self.myCup setOrange:[self.myCup addOrange:[self.myCup orange]]];
            finalCount = [self.myCup orange];
            break;
        case 6:
            [self.myCup setWater:[self.myCup addWater:[self.myCup water]]];
            finalCount = [self.myCup water];
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
    NSString *dateStringFromSender = [self.formatter stringFromDate:[sender date]];

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [self.myCup setDate:dateStringFromSender];
    [realm commitWriteTransaction];
}


@end
