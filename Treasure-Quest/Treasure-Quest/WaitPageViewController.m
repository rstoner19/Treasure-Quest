//
//  WaitPageViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "WaitPageViewController.h"
#import "Route.h"

@interface WaitPageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTeam;
@property (weak, nonatomic) IBOutlet UILabel *waitingTeamOne;
@property (weak, nonatomic) IBOutlet UILabel *waitingTeamTwo;
@property (weak, nonatomic) IBOutlet UILabel *waitingTeamThree;
@property (weak, nonatomic) IBOutlet UILabel *waitingTeamFour;
@property (weak, nonatomic) IBOutlet UILabel *waitingTeamFive;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageOne;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageThree;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageFour;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageFive;

@end

@implementation WaitPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    NSLog(@"Distance: %f", [Route totalDistanceCrowFlies:[Route demoRoute]]);
    NSLog(@"Distance2: %f", [Route totalDistanceCrowFlies:[Route randomizeRoute:[Route demoRoute]]]);
    NSLog(@"Distance: %f", [Route totalDistanceCrowFlies:[Route demoRoute]]);
    [Route verifyDistanceRange:[Route demoRoute] players:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)setupViewController {
    self.questNameLabel.text = @"Quest Name Variable Here";
    self.gameCodeLabel.text = @"game Code var";
    self.gameDescriptionLabel.text = @"description here";
    
    int players = 5;
    
    for (int i = 0; i < players; i++) {
        switch (i) {
            case 0:
            case 1:
                self.waitingTeamOne.layer.hidden = NO;
                self.waitingImageOne.layer.hidden = NO;
//                if (team1joined) {
//                    self.waitingTeamOne.layer.opacity = 1.0;
//                    self.waitingImageOne.layer.opacity = 1.0;
//                }
                break;
            case 2:
                self.waitingTeamTwo.layer.hidden = NO;
                self.waitingImageTwo.layer.hidden = NO;
                break;
            case 3:
                self.waitingTeamThree.layer.hidden = NO;
                self.waitingImageThree.layer.hidden = NO;
                break;
            case 4:
                self.waitingTeamFour.layer.hidden = NO;
                self.waitingImageFour.layer.hidden = NO;
                break;
            case 5:
                self.waitingTeamFive.layer.hidden = NO;
                self.waitingImageFive.layer.hidden = NO;
                break;
            default:
                break;
        }
    }
    
}

@end
