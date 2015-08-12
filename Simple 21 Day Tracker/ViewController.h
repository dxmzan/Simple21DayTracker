//
//  ViewController.h
//  T1DF
//
//  Created by Shaun on 8/10/15.
//  Copyright (c) 2015 Shaun Bevan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *cupType;

@property (assign, nonatomic) int counter;

@property (copy, nonatomic) NSMutableArray *cupCount;

@end
