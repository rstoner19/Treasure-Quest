//
//  LeaderBoardViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import <Parse/Parse.h>

@interface LeaderBoardViewController ()
@property (strong, nonatomic) IBOutlet UIView *pushTestButton;

@end

@implementation LeaderBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pushTestButtonPressed:(id)sender {
    NSLog(@"got it");
    
    [PFCloud callFunctionInBackground:@"iosPushTest"
                       withParameters:@{@"text": @"Welcome to the Matrix"}
                                block:^(NSNumber *ratings, NSError *error) {
                                    if (!error) {
                                        // ratings is 4.5
                                    }
                                }];
}


@end
