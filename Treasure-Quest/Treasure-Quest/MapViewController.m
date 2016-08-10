//
//  MapViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "MapViewController.h"
@import MapKit;
#import "LocationController.h"
#import "Quest.h"
#import "Objective.h"
#import "ProgressListViewController.h"

@interface MapViewController () <MKMapViewDelegate, LocationControllerDelegate>
- (IBAction)completeButtonSelected:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Quest *currentQuest;
@property float angleToNextObjective;
@property (strong, nonatomic) Objective *currentObjective;
@property (strong, nonatomic) MKPinAnnotationView *userPin;

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.mapView.layer setCornerRadius:20.0];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setDelegate:self];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:NO];
    [self.mapView setRotateEnabled:NO];
    [self.mapView setShowsBuildings:YES];
    [self.mapView setPitchEnabled:YES];
    [self.mapView setShowsPointsOfInterest:YES];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    self.mapView.camera.pitch = 80;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
    [[[LocationController sharedController] locationManager]startUpdatingHeading];
    ProgressListViewController *progressListVC = (ProgressListViewController *)[self.tabBarController.viewControllers objectAtIndex:0];
    self.currentQuest = progressListVC.currentQuest;
    NSLog(@"%@", self.currentQuest);
    [self setupObjectiveAnnotations];
}

-(void)setupObjectiveAnnotations {


//    NSArray *objectives = self.currentQuest.route.waypoints;
//
//    Objective *firstCompleted = objectives[0];
//    firstCompleted.completed = YES;
//
//    for (Objective *objective in objectives) {
//
//        if(objective.completed == YES){
//  
//            CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(objective.latitude, objective.longitude);
//          MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
//          newPoint.coordinate = loc;
//          newPoint.title = objective.name;
//          [self.mapView addAnnotation:newPoint];
//
//=======
    Objective *current = self.currentQuest.objectives[0];
    [current fetchIfNeeded];
    long index = [self.currentQuest.objectives indexOfObject:current] + 1;
    
    //Traverse array for first non complete item
    while (current.completed == YES && index <= self.currentQuest.objectives.count) {
        
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(current.latitude, current.longitude);

//        CLLocationCoordinate2D loc = current.location.coordinate;
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = loc;
        newPoint.title = current.name;
        [self.mapView addAnnotation:newPoint];
        
        if (index == self.currentQuest.objectives.count) {
            NSLog(@"end of array...");
            break;
        }
        current = self.currentQuest.objectives[index];
        [current fetchIfNeeded];
        index += 1;

    }
}

-(void)setRegionForCoordinate:(MKCoordinateRegion)region {
    
    [self.mapView setRegion:region animated:YES];

}

-(void)locationControllerDidUpdateLocation:(CLLocation *)location{
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 50, 50) animated:YES];
    self.mapView.camera.altitude = 250;
    CLLocation *locationPointer = [[CLLocation alloc]initWithLatitude:self.currentObjective.latitude longitude:self.currentObjective.longitude];
    [self calculateAngleToNewObjective:location objectiveLocation:locationPointer];
    self.currentUserLocation = location;
    [self calculateAngleToNewObjective:self.currentUserLocation objectiveLocation:locationPointer];
    [self changeUserAnnotationColor:self.userPin];
    
}

-(void)locationControllerDidUpdateHeading:(CLHeading *)heading {

//    NSLog(@"%@", heading);
    self.mapView.camera.heading = heading.trueHeading;
    
    CLLocation *locationPointer = [[CLLocation alloc]initWithLatitude:self.currentObjective.latitude longitude:self.currentObjective.longitude];

    
    self.mapView.camera.pitch = 70;
    self.mapView.camera.altitude = 250;
    self.currentHeading = heading.trueHeading;
    [self calculateAngleToNewObjective:self.currentUserLocation objectiveLocation:locationPointer];
    
//    NSLog(@"User Heading: %f   Angle to next: %f", self.currentHeading, self.angleToNextObjective);
    [self changeUserAnnotationColor:self.userPin];
    
 }

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
       self.userPin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"userAnno"];
        self.userPin.pinTintColor = [UIColor purpleColor];
        
        return [self changeUserAnnotationColor:self.userPin];
    }

    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];

    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }

    annotationView.canShowCallout = YES;
    UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = calloutButton;
    return annotationView;
}

-(void) calculateAngleToNewObjective:(CLLocation *)userLocation objectiveLocation: (CLLocation *)objectiveLocation {
   
    float userLat = userLocation.coordinate.latitude;
    float userLong = userLocation.coordinate.longitude;
    
    float objectiveLat = objectiveLocation.coordinate.latitude;
    float objectiveLong = objectiveLocation.coordinate.longitude;
    
    float deltaLong = objectiveLong - userLong;
    float y = sin(deltaLong) * cos(objectiveLat);
    float x = cos(userLat) * sin(objectiveLat) - sin(userLat) * cos(objectiveLat) * cos(deltaLong);
    float bearingInRadians = atan2f(y, x);
    
    self.angleToNextObjective = bearingInRadians * 180 / M_PI;
    
}

-(MKPinAnnotationView*)changeUserAnnotationColor: (MKPinAnnotationView *)userPin {
   //TODO: adjust opacity based on accuracy percentage
    //float difference = fabs(self.currentHeading - self.angleToNextObjective);

    if (self.currentHeading <= self.angleToNextObjective + 10 && self.currentHeading >= self.angleToNextObjective - 10) {
    
       
       self.userPin.pinTintColor = [UIColor greenColor];
        return userPin;
        
    }
    
    else if(self.currentHeading <= self.angleToNextObjective + 50 && self.currentHeading >= self.angleToNextObjective - 50) {
        self.userPin.pinTintColor = [UIColor yellowColor];
        return userPin;

    }
    
    else {
        
        self.userPin.pinTintColor = [UIColor redColor];
        return userPin;
    }

}

-(void)completeCurrentObjective {
    NSUInteger index = 0;
    [self.currentObjective fetchIfNeeded];
    
    self.currentObjective.completed = YES;
    [self.currentObjective save];
    
    NSArray *objectives = [[NSArray alloc]init];
    objectives = self.currentQuest.objectives;
    
    while (index < self.currentQuest.objectives.count ) {
        Objective *objective = [objectives objectAtIndex: index];
        [objective fetchIfNeeded];
        if (objective.completed == NO){
            break;
        }
        index++;
    }
    
    if (index == self.currentQuest.objectives.count){
        NSLog(@"end of the line");
        return;
    }
//    while (((Objective *)[objectives objectAtIndex: index]).completed == YES) {
//        
//        if (index == self.currentQuest.objectives.count-1) {
//            NSLog(@"reached array limit, we out");
//            
//            //
//            
//            return;
//        }
//        
//        index += 1;
//    }

    self.currentObjective = self.currentQuest.objectives[index];
    NSLog(@"Objective complete! Next objective is objective %@", self.currentObjective.name);
    [self setupObjectiveAnnotations];
}

- (IBAction)completeButtonSelected:(UIButton *)sender {
    
    [self completeCurrentObjective];
    
}
@end
