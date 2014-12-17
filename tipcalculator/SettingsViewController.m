//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by User on 12/15/14.
//  Copyright (c) 2014 aw. All rights reserved.
//

#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercentage;

- (IBAction)defaultChanged:(id)sender;

@end

@implementation SettingsViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // load the default tip percentage setting
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defValue = (int)[defaults integerForKey:@"def_tip_percentage"];
    
    self.defaultTipPercentage.selectedSegmentIndex = defValue;
}

- (IBAction)defaultChanged:(id)sender {
    
    // save new default tip percentage setting
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defValue = (int)self.defaultTipPercentage.selectedSegmentIndex;
    
    [defaults setInteger:defValue forKey:@"def_tip_percentage"];
    [defaults synchronize];
    
    NSLog(@"saving index: %d", defValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
