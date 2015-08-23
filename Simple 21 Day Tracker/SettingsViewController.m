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

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)weightButton:(UIButton *)sender {
    int weight = [self.weightField.text intValue];
    
    int caloricTarget = ((weight * 11) + 400) - 750;
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber: [NSNumber numberWithInteger: caloricTarget]];
    
    self.calorieLabel.text = numberString;
        
    if (caloricTarget < 1500){
        [self.switchOne setOn:YES animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:NO animated:YES];
        

        
    } else if (caloricTarget > 1499 && caloricTarget < 1800){
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:YES animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:NO animated:YES];
    } else if (caloricTarget > 1799 && caloricTarget < 2100){
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:YES animated:YES];
        [self.switchFour setOn:NO animated:YES];
    } else {
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:YES animated:YES];
    }
}

- (IBAction)switchOnePressed:(UISwitch *)sender {
    if ([sender isOn]){
    [self.switchTwo setOn:NO animated:YES];
    [self.switchThree setOn:NO animated:YES];
    [self.switchFour setOn:NO animated:YES];
    }
}

- (IBAction)switchTwoPressed:(UISwitch *)sender {
    if ([sender isOn]){
        [self.switchOne setOn:NO animated:YES];
        [self.switchThree setOn:NO animated:YES];
        [self.switchFour setOn:NO animated:YES];
    }
}

- (IBAction)switchThreePressed:(UISwitch *)sender {
    if ([sender isOn]){
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchFour setOn:NO animated:YES];
    }
}

- (IBAction)switchFourPressed:(UISwitch *)sender {
    if ([sender isOn]){
        [self.switchOne setOn:NO animated:YES];
        [self.switchTwo setOn:NO animated:YES];
        [self.switchThree setOn:NO animated:YES];
    }
}
@end
