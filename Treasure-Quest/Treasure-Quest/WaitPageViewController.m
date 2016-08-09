//
//  WaitPageViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "WaitPageViewController.h"
#import "Route.h"
@import Parse;


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
@property (weak, nonatomic) IBOutlet UILabel *waitingTeamSix;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageOne;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageThree;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageFour;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageFive;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImageSix;

@end

@implementation WaitPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseQuery];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}

- (void)setupViewController {
    self.questNameLabel.text = self.questName;
    self.gameCodeLabel.text = [NSString stringWithFormat:@"Code: %@", self.gameCode];
    self.gameDescriptionLabel.text = self.gameDescription;

    int players = [self.maxPlayers intValue];
    
    [self setWaitingPlayers:players];
    NSLog(@"Player count: %d",(int)self.players.count);
    [self setUserItems:(int)self.players.count currentTeam:[self.teamNumber intValue]];

}

- (void)setWaitingPlayers:(int)players {
    for (int i = 0; i <= players; i++) {
        switch (i) {
            case 1:
                self.waitingTeamOne.layer.hidden = NO;
                self.waitingImageOne.layer.hidden = NO;
                self.waitingTeamOne.text = @"Blue Team";
                self.waitingImageOne.image = [UIImage imageNamed:@"blueTeam"];
                break;
            case 2:
                self.waitingTeamTwo.layer.hidden = NO;
                self.waitingImageTwo.layer.hidden = NO;
                self.waitingTeamTwo.text = @"Red Team";
                self.waitingImageTwo.image = [UIImage imageNamed:@"redTeam"];
                break;
            case 3:
                self.waitingTeamThree.layer.hidden = NO;
                self.waitingImageThree.layer.hidden = NO;
                self.waitingTeamThree.text = @"Green Team";
                self.waitingImageThree.image = [UIImage imageNamed:@"greenTeam"];
                break;
            case 4:
                self.waitingTeamFour.layer.hidden = NO;
                self.waitingImageFour.layer.hidden = NO;
                self.waitingTeamFour.text = @"Orange Team";
                self.waitingImageFour.image = [UIImage imageNamed:@"orangeTeam"];
                break;
            case 5:
                self.waitingTeamFive.layer.hidden = NO;
                self.waitingImageFive.layer.hidden = NO;
                self.waitingTeamFive.text = @"Purple Team";
                self.waitingImageFive.image = [UIImage imageNamed:@"purpleTeam"];
                break;
            case 6:
                self.waitingTeamSix.layer.hidden = NO;
                self.waitingImageSix.layer.hidden = NO;
                self.waitingTeamSix.text = @"Black Team";
                self.waitingImageSix.image = [UIImage imageNamed:@"blackTeam"];
                break;
            default:
                break;
                
        }
        
    }
}

- (void)setUserItems:(int)registeredTeams currentTeam:(int)currentTeam {
    for (int i = 0; i <= registeredTeams; i++) {
        NSLog(@"i: %d, regiesterTeams: %i, currentTeam: %i", i, registeredTeams, currentTeam);
        switch(i){
            case 1:
                if (currentTeam == i) {
                    self.userTeam.text = @"Blue Team";
                    self.userImage.image = [UIImage imageNamed:@"blueTeam"];
                }
                self.waitingTeamOne.layer.opacity = 1.0;
                self.waitingImageOne.layer.opacity = 1.0;
                break;
            case 2:
                if (currentTeam == i) {
                    self.userTeam.text = @"Red Team";
                    self.userImage.image = [UIImage imageNamed:@"redTeam"];
                }
                self.waitingTeamTwo.layer.opacity = 1.0;
                self.waitingImageTwo.layer.opacity = 1.0;
                break;
            case 3:
                if (currentTeam == i) {
                    self.userTeam.text = @"Green Team";
                    self.userImage.image = [UIImage imageNamed:@"greenTeam"];
                }
                self.waitingTeamThree.layer.opacity = 1.0;
                self.waitingImageThree.layer.opacity = 1.0;
                break;
            case 4:
                if (currentTeam == i) {
                    self.userTeam.text = @"Orange Team";
                    self.userImage.image = [UIImage imageNamed:@"orangeTeam"];
                }
                self.waitingTeamFour.layer.opacity = 1.0;
                self.waitingImageFour.layer.opacity = 1.0;
                break;
            case 5:
                if (currentTeam == i) {
                    self.userTeam.text = @"Purple Team";
                    self.userImage.image = [UIImage imageNamed:@"purpleTeam"];
                }
                self.waitingTeamFive.layer.opacity = 1.0;
                self.waitingImageFive.layer.opacity = 1.0;
                break;
            case 6:
                if (currentTeam == i) {
                    self.userTeam.text = @"Black Team";
                    self.userImage.image = [UIImage imageNamed:@"blackTeam"];
                }
                self.waitingTeamSix.layer.opacity = 1.0;
                self.waitingImageSix.layer.opacity = 1.0;
                break;
            default:
                break;
        }
    }
}


- (void)parseQuery {
    PFQuery *query= [PFQuery queryWithClassName:@"Quest"];
    __weak typeof (self) weakSelf = self;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                for (Quest *quest in objects)
                {
                    if ([quest.name isEqualToString:strongSelf.questName]) {
                        self.gameCode= quest.objectId;
                        self.maxPlayers = quest.maxplayers;
                        self.gameDescription= quest.info;
                        self.players = quest.players;
                        if ([self.players containsObject:[PFUser currentUser].objectId]) {
                            self.teamNumber = [NSNumber numberWithInt:(int)([self.players indexOfObject:[PFUser currentUser].objectId] + 1)];
                        }
                        
                        [self setupViewController];
                    }
                }
            }];
        }
    }];
}


@end
