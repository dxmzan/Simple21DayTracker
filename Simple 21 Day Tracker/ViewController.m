//
//  ViewController.m
//  T1DF
//
//  Created by Shaun on 8/10/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int finalCount;

int greenCount = 0;
int purpleCount = 0;
int redCount = 0;
int yellowCount = 0;
int blueCount = 0;
int orangeCount = 0;
int waterCount = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.cupType = @[@"Green", @"Purple", @"Red", @"Yellow", @"Blue", @"Orange", @"Water"];
    self.cupCount = [NSMutableArray arrayWithObjects: @0, @0, @0, @0, @0, @0, @0, nil];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 375, 72)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM d, yyyy";
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    date.text = dateString;
    date.backgroundColor = [UIColor clearColor];
    date.textColor = [UIColor blackColor];
    date.textAlignment = NSTextAlignmentCenter;
    date.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    [self.view addSubview:date];
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
    
    // Container
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    [container addSubview:counter];
    
    
    NSString *countString = [NSString stringWithFormat:@"%d", finalCount];
    
    counter.text = countString;
    counter.textAlignment = NSTextAlignmentCenter;
    cell.accessoryView = container;
    
    
    return cell;
}
//
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row)
    {
        case 0:
            finalCount = ++greenCount;
            break;
        case 1:
            finalCount = ++purpleCount;
            break;
        case 2:
            finalCount = ++redCount;
            break;
        case 3:
            finalCount = ++yellowCount;
            break;
        case 4:
            finalCount = ++blueCount;
            break;
        case 5:
            finalCount = ++orangeCount;
            break;
        case 6:
            finalCount = ++waterCount;
            break;
            
    }
    
    [tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                     withRowAnimation: UITableViewRowAnimationNone];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

@end
