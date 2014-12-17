//
//  TipViewController.m
//  tipcalculator
//
//  Created by User on 12/15/14.
//  Copyright (c) 2014 aw. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@property (strong, nonatomic) NSDate *lastUpdateTime;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load the time of the last bill amount update
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.lastUpdateTime = [defaults objectForKey:@"last_update_time"];
    
    // load the previous bill amount only if it was set within the last 5 minutes
    if (fabs([self.lastUpdateTime timeIntervalSinceNow]) < 300) {
        
        self.billTextField.text = [defaults objectForKey:@"bill_amt"];
    }
    
    // load the default tip percentage
    self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"def_tip_percentage"];
    
    // add a settings button to the navigation bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTap:(id)sender {    
    [self.view endEditing:YES];
    [self updateValues];
}
- (void)updateValues{
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
    self.lastUpdateTime = [[NSDate alloc] init];
    
    // save the new update time and bill amount
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *billAmountString = self.billTextField.text;
    
    [defaults setObject:billAmountString forKey:@"bill_amt"];
    [defaults setObject:self.lastUpdateTime forKey:@"last_update_time"];
    [defaults synchronize];
}

- (void)onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
