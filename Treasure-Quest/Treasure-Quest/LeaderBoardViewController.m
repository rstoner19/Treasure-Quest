//
//  LeaderBoardViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "LeaderBoardViewController.h"
//#import <Parse/Parse.h>
#import "Quest.h"

@import Parse;


@interface LeaderBoardViewController ()
@property (strong, nonatomic) IBOutlet UIView *pushTestButton;
@property (strong, nonatomic) Quest *currentQuest;

@end

@implementation LeaderBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (IBAction)pushTestButtonPressed:(id)sender {
    NSLog(@"got it");
    
    [PFCloud callFunctionInBackground:@"currentPlayers"
                       withParameters:@{@"objectId": @"eWCJIWiL4B"}
                                block:^(NSString *response, NSError *error) {
                                    if (!error) {
                                        // ratings is 4.5
                                        NSLog(@"%@",response );
                                    }
                                }];
}

- (void) setup {
    
    PFQuery *query= [PFQuery queryWithClassName:@"Quest"];
    [query getObjectWithId:@"LuX5l9Yirp"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        PFObject *obj = [objects firstObject];
        NSLog(@"%@", obj);
    }];

    
}



@end
