//
//  SettingsViewController.m
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/22/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import "SettingsViewController.h"
#import "Cups.h"
#import "ViewController.h"

@interface SettingsViewController ()

@property (copy, nonatomic) NSArray *cycleSwitches;
@property (strong, nonatomic) NSString *switchNumString;

@end

@implementation SettingsViewController

@synthesize switchNumString;
@synthesize sentDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Cups = [[Cups alloc]init];
    
    self.cycleSwitches = @[@"switchOne", @"switchTwo", @"switchThree", @"switchFour"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    
        
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];

    self.calorieLabel.text = [userSettings stringForKey:@"calorieTarget"];
    self.switchOne.on = ([[userSettings stringForKey:@"switchOne"] isEqualToString:@"On"]) ? (YES) : (NO);
    self.switchTwo.on = ([[userSettings stringForKey:@"switchTwo"] isEqualToString:@"On"]) ? (YES) : (NO);
    self.switchThree.on = ([[userSettings stringForKey:@"switchThree"] isEqualToString:@"On"]) ? (YES) : (NO);
    self.switchFour.on = ([[userSettings stringForKey:@"switchFour"] isEqualToString:@"On"]) ? (YES) : (NO);
    
//    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
////    NSLog(@"Before Array: %@", navigationArray);
//    
//    //[navigationArray removeAllObjects];    // This is just for remove all view controller from navigation stack.
//   
//    if (navigationArray.count > 2){
//        for (int i = 0; i < navigationArray.count - 1; i++){
//            [navigationArray removeObjectAtIndex: 0];  // You can pass your index here
//        }
//    }
//
//    self.navigationController.viewControllers = navigationArray;
////    NSLog(@"After Array: %@", navigationArray);

    NSLog(@"VWA: %@", sentDate);
}


- (IBAction)weightButton:(UIButton *)sender {
    
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    
    NSInteger weight = [self.weightField.text integerValue];
    
    NSInteger caloricTarget = ((weight * 11) + 400) - 750;
    
    NSInteger switchToggled;
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber: [NSNumber numberWithInteger: caloricTarget]];
    
    [userSettings setObject:numberString forKey:@"calorieTarget"];
    
    self.calorieLabel.text = [userSettings stringForKey:@"calorieTarget"];
    
    if (caloricTarget < 1500){
        [self.switchOne setOn:YES animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:NO animated:YES];
        switchToggled = 0;
    } else if (caloricTarget > 1499 && caloricTarget < 1800){
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:YES animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:NO animated:YES];
        switchToggled = 1;
    } else if (caloricTarget > 1799 && caloricTarget < 2100){
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:YES animated:YES];
        [self.switchFour setOn:NO animated:YES];
        switchToggled = 2;
    } else {
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:YES animated:YES];
        switchToggled = 3;
    }
    
    // Clear settings in case multiple switches are active
    for (int i = 0; i < 4; i++){
        [userSettings removeObjectForKey:self.cycleSwitches[i]];
    }
    
    // Check if sender switch is on or off, then set settings
    if (switchToggled == 0){
        if (self.switchOne.on == 0){
            [userSettings setObject:@"Off" forKey:@"switchOne"];
        } else if (self.switchOne.on == 1){
            [userSettings setObject:@"On" forKey:@"switchOne"];
        }
    } else if (switchToggled == 1){
        if (self.switchTwo.on == 0){
            [userSettings setObject:@"Off" forKey:@"switchTwo"];
        } else if (self.switchTwo.on == 1){
            [userSettings setObject:@"On" forKey:@"switchTwo"];
        }
    } else if (switchToggled == 2){
        if (self.switchThree.on == 0){
            [userSettings setObject:@"Off" forKey:@"switchThree"];
        } else if (self.switchThree.on == 1){
            [userSettings setObject:@"On" forKey:@"switchThree"];
        }
    } else if (switchToggled == 3){
        if (self.switchFour.on == 0){
            [userSettings setObject:@"Off" forKey:@"switchFour"];
        } else if (self.switchFour.on == 1){
            [userSettings setObject:@"On" forKey:@"switchFour"];
        }
    }
    
    [userSettings synchronize];
    
    //NSString *switchUsed = [NSString stringWithFormat:@"%ld", (long)switchToggled];
}

- (IBAction)switchPressed:(UISwitch *)sender {
    
    UISwitch *switchObj = (UISwitch *) sender;
    
    NSString *switchName;
    
    switch (switchObj.tag) {
        case 0:
            [sender setOn:YES animated:YES];
            [self.switchTwo setOn:NO animated:YES];
            [self.switchThree setOn:NO animated:YES];
            [self.switchFour setOn:NO animated:YES];
            switchName = self.cycleSwitches[switchObj.tag];
            break;
        case 1:
            [sender setOn:YES animated:YES];
            [self.switchOne setOn:NO animated:YES];
            [self.switchThree setOn:NO animated:YES];
            [self.switchFour setOn:NO animated:YES];
            switchName = self.cycleSwitches[switchObj.tag];
            break;
        case 2:
            [sender setOn:YES animated:YES];
            [self.switchOne setOn:NO animated:YES];
            [self.switchTwo setOn:NO animated:YES];
            [self.switchFour setOn:NO animated:YES];
            switchName = self.cycleSwitches[switchObj.tag];
            break;
        case 3:
            [sender setOn:YES animated:YES];
            [self.switchOne setOn:NO animated:YES];
            [self.switchTwo setOn:NO animated:YES];
            [self.switchThree setOn:NO animated:YES];
            switchName = self.cycleSwitches[switchObj.tag];
            break;   
    }
    
    // Save settings
    
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    
    // Clear settings in case multiple switches are active
    for (int i = 0; i < 4; i++){
        [userSettings removeObjectForKey:self.cycleSwitches[i]];
    }

    // Check if sender switch is on or off, then set settings
    if (sender.on == 0){
        [userSettings setObject:@"Off" forKey:switchName];
    } else if (sender.on == 1){
        [userSettings setObject:@"On" forKey:switchName];
    }
    
    [userSettings synchronize];
    
    
    // Sending notifcation to viewcontroller to set goals
    self.switchNumString = [NSString stringWithFormat:@"%ld", (long)switchObj.tag];
    
    NSLog(@"SentDate: %@", sentDate);
    
    [self.Cups setGoals:(int)switchObj.tag setDate:sentDate];

}


-(void)setDefaultGoals{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    
    
    [defaults setInteger:[self.Cups greenGoal] forKey:@"greenGoal"];
    [defaults setInteger:[self.Cups purpleGoal] forKey:@"purpleGoal"];
    [defaults setInteger:[self.Cups redGoal] forKey:@"redGoal"];
    [defaults setInteger:[self.Cups yellowGoal] forKey:@"yellowGoal"];
    [defaults setInteger:[self.Cups blueGoal] forKey:@"blueGoal"];
    [defaults setInteger:[self.Cups orangeGoal] forKey:@"orangeGoal"];
    [defaults setInteger:[self.Cups waterGoal] forKey:@"waterGoal"];
    [defaults setInteger:[self.Cups spoonGoal] forKey:@"spoonGoal"];
    
    [defaults synchronize];
    
}

-(void)updateGoals{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    
    RLMResults *cups = [Cups allObjects];
        
    [[RLMRealm defaultRealm]transactionWithBlock:^{
        
        [[cups lastObject] setGreenGoal:[defaults integerForKey:@"greenGoal"]];
        [[cups lastObject] setPurpleGoal:[defaults integerForKey:@"purpleGoal"]];
        [[cups lastObject] setRedGoal:[defaults integerForKey:@"redGoal"]];
        [[cups lastObject] setYellowGoal:[defaults integerForKey:@"yellowGoal"]];
        [[cups lastObject] setBlueGoal:[defaults integerForKey:@"blueGoal"]];
        [[cups lastObject] setOrangeGoal:[defaults integerForKey:@"orangeGoal"]];
        [[cups lastObject] setWaterGoal:[defaults integerForKey:@"waterGoal"]];
        [[cups lastObject] setSpoonGoal:[defaults integerForKey:@"spoonGoal"]];
    }];
    
}




@end
