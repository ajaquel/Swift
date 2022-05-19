//
//  Copyright (c) 2013 Parse. All rights reserved.

#import "ViewController.h"
#import <Parse/Parse.h>

@implementation ViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Parse Push Notifications", @"Parse Push Notifications")];
    
    [self loadInstallData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UIViewController

/* Touch handler for the button */
- (IBAction)broadcastPushNotification:(id)sender  {
    [PFPush sendPushMessageToChannelInBackground:@"global" withMessage:@"Hello World!"];
}

- (IBAction)updateInstallation:(id)sender {
    NSString *gender = @"male";
    if (self.genderControl.selectedSegmentIndex == 1) {
        gender = @"female";
    }

    NSNumber *age = @((int)self.ageControl.value);
    [PFInstallation currentInstallation][@"age"] = age;
    [PFInstallation currentInstallation][@"gender"] = gender;
    [[PFInstallation currentInstallation] saveInBackground];
}

- (IBAction)updateAgeLabel:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    self.ageLabel.text = [formatter stringFromNumber:[NSNumber numberWithInt:(int)self.ageControl.value]];
}

- (void)loadInstallData {
    NSNumber *age = [PFInstallation currentInstallation][@"age"];
    NSString *gender = [PFInstallation currentInstallation][@"gender"];

    // Handle saved age, or populate default age.
    if (!age) {
        age = @(35);
        [PFInstallation currentInstallation][@"age"] = age;
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@", age];
    self.ageControl.value = [age floatValue];
    
    // Handle saved gender, or populate default gender.
    if ([gender isEqualToString:@"male"]) {
        self.genderControl.selectedSegmentIndex = 0;
    } else if ([gender isEqualToString:@"female"]) {
        self.genderControl.selectedSegmentIndex = 1;
    } else {
        self.genderControl.selectedSegmentIndex = 0;
        [PFInstallation currentInstallation][@"gender"] = @"male";
    }
    
    [[PFInstallation currentInstallation] saveInBackground];
}

@end
