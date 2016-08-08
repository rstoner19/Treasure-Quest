//
//  SummaryViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "SummaryViewController.h"
#import "FoursquareAPI.h"
#import "WaitPageViewController.h"

@interface SummaryViewController ()  <LocationControllerDelegate>

@property (strong, nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet UILabel *questNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectivesLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)locationControllerDidUpdateHeading:(CLHeading *)heading
//{
//    //
//}
//
//-(void)locationControllerDidUpdateLocation:(CLLocation *)location
//{
//    self.finalLat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
//    self.finalLong = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    NSString *token = @"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY";
    
    if (token)
    {
        [FoursquareAPI getFoursquareData:@"query" finalLat:self.finalLat finalLong:self.finalLong completionHandler:^(NSArray *results, NSError *error) {
            if (error)
            {
                NSLog(@"%@", error.localizedDescription);
            }
            self.searchResults = results;
        }];
    }
}

- (void)setupView {
    self.questNameLabel.text = self.questName;
    self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"Players: %@", self.players];
    self.objectivesLabel.text = [NSString stringWithFormat:@"Total Objectives: %@", self.objectives];
    self.descriptionLabel.text = self.gameDescription;
}

/// Waiting will pull from the server, instead of this will need to populate Objective and push to server.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WaitStoryBoard"]) {
        
        WaitPageViewController *waitPageViewController = (WaitPageViewController *)segue.destinationViewController;
        waitPageViewController.players = self.players;
        waitPageViewController.questName = self.questName;
        waitPageViewController.gameDescription = self.gameDescription;
    }
}

@end
