//
//  SettingsViewController.h
//  Simple 21 Day Tracker
//
//  Created by Shaun on 8/22/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cups;


@interface SettingsViewController : UIViewController

@property (strong, nonatomic) Cups *Cups;

@property (weak, nonatomic) IBOutlet UITextField *weightField;

@property (weak, nonatomic) IBOutlet UILabel *calorieLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchOne;
@property (weak, nonatomic) IBOutlet UISwitch *switchTwo;
@property (weak, nonatomic) IBOutlet UISwitch *switchThree;
@property (weak, nonatomic) IBOutlet UISwitch *switchFour;

@property (strong, nonatomic) NSString *sentDate;

- (IBAction)switchPressed:(UISwitch *)sender;

- (IBAction)weightButton:(UIButton *)sender;

@end
