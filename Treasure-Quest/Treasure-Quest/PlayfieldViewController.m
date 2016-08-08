//
//  PlayfieldViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "PlayfieldViewController.h"
#import "SummaryViewController.h"

@interface PlayfieldViewController ()

@end

@implementation PlayfieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SummaryViewController"]) {
        
        SummaryViewController *summaryViewController = (SummaryViewController *)segue.destinationViewController;
        summaryViewController.players = self.players;
        summaryViewController.questName = self.questName;
        summaryViewController.gameDescription = self.gameDescription;
        summaryViewController.objectives = self.objectives;
    }
}

@end
