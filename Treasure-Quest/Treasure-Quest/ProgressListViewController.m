//
//  ProgressListViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "ProgressListViewController.h"
#import "Quest.h"
#import "Player.h"
#import "Route.h"
#import "Objective.h"
@import Parse;
#import "MapViewController.h"

@interface ProgressListViewController () <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) Quest *currentQuest;

@end

@implementation ProgressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setup];
}

-(void) setup {

   self.objectivesDisplayed = [[NSMutableArray alloc]init];
    PFQuery *query= [PFQuery queryWithClassName:@"Quest"];
    __weak typeof (self) weakSelf = self;

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                for (Quest *quest in objects)
                {
                    if ([quest.name isEqualToString:@"yay"]) {
                        NSLog(@"%@", quest.name);
                        NSLog(@"%@", quest);



//                        quest.route = [Route demoRoute];
                        strongSelf.currentQuest = quest;
                        strongSelf.currentObjective = quest.objectives[0];
//                        NSLog(@"Initial objective = %@", quest.route.waypoints[0]);

                    // if ([quest.name isEqualToString:@"Rick's Pub Crawl"]) {
                        // quest.route = [Route demoRoute];
                        // strongSelf.currentQuest = quest;
                        // strongSelf.currentObjective = quest.route.waypoints[0];
                        // [strongSelf.objectivesDisplayed addObject:strongSelf.currentObjective];
                        [strongSelf.tableView reloadData];
                    }

//                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake( reminder.location.latitude, reminder.location.longitude);
//                    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 50.0, 50.0);
//                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//                    point.coordinate = coordinate;
//
//                    point.title = reminder.name ;
//                    [strongSelf.mapView addAnnotation:point];
//
//
//                    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
//                        CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:coordinate radius:reminder.radius.floatValue identifier:reminder.name];
//
//                        [[[LocationController sharedController]locationManager] startMonitoringForRegion:region];
//
//                        MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:reminder.radius.floatValue];
//
//                        [strongSelf.mapView addOverlay:circle];
//
//
//                    }

                }
//                strongSelf.mapView.showsUserLocation = YES;
//
//                [strongSelf.mapView showAnnotations:strongSelf.mapView.annotations animated:YES];

            }];
        } else {
            NSLog(@"ERROR: %@", error.localizedDescription);
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Objective *objective = self.currentQuest.route.waypoints[indexPath.row];
    NSLog(@"Objective name: %@", objective.name);
    cell.textLabel.text = objective.category;
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.objectivesDisplayed.count;
}

-(void)userDidCompleteCurrentObjective {

    if ([self.currentQuest.route.waypoints indexOfObject:self.currentObjective] < [self.currentQuest.route.waypoints count]) {

        NSInteger nextObjIndex = [self.currentQuest.route.waypoints indexOfObject:self.currentObjective] + 1;

        Objective *nextObjective = [self.currentQuest.route.waypoints objectAtIndex:nextObjIndex];
        [self.objectivesDisplayed addObject:nextObjective];
        NSLog(@"your next objective is %@", nextObjective.name);
    }
}



@end
