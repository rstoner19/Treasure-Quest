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
@import Parse;

@interface ProgressListViewController () <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Quest *currentQuest;

@end

@implementation ProgressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setup];
    NSLog(@"%lu", (unsigned long)self.currentQuest.route.waypoints.count);
//    NSLog(@"NAME: %@", self.currentQuest.name);

}


-(void) setup {
    
    NSLog(@"Function called");
    PFQuery *query= [PFQuery queryWithClassName:@"Quest"];
    __weak typeof (self) weakSelf = self;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                for (Quest *quest in objects)
                {
                    if ([quest.name isEqualToString:@"Rick's Pub Crawl"]) {
                        NSLog(@"%@", quest.name);
                    
                        quest.route = [Route demoRoute];
                       
                        self.currentQuest = quest;
                        NSLog(@"%lu", (unsigned long)quest.route.waypoints.count);
                        NSLog(@"%@", quest.route);
                        [self.tableView reloadData];
                    }
//                    //                        NSLog(@"Reminder: %@", reminder.name );
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
        }
    }];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"test";
    return cell;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.currentQuest.route.waypoints.count;
}


@end
