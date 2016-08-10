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
    [self.mapView setZoomEnabled:NO];
    [self.mapView setScrollEnabled:NO];
    [self.mapView setRotateEnabled:NO];
    [self.mapView setShowsBuildings:NO];
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

    Objective *current = self.currentQuest.route.waypoints[0];
    long index = [self.currentQuest.route.waypoints indexOfObject:current] + 1;
    
    //Traverse array for first non complete item
    while (current.completed == YES && index <= self.currentQuest.route.waypoints.count) {
        
        CLLocationCoordinate2D loc = current.location.coordinate;
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = loc;
        newPoint.title = current.name;
        [self.mapView addAnnotation:newPoint];
        
        if (index == self.currentQuest.route.waypoints.count) {
            NSLog(@"end of array...");
            break;
        }
        current = self.currentQuest.route.waypoints[index];
        index += 1;

    }
}

-(void)setRegionForCoordinate:(MKCoordinateRegion)region {
    
    [self.mapView setRegion:region animated:YES];

}

-(void)locationControllerDidUpdateLocation:(CLLocation *)location{
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 50, 50) animated:YES];
    self.mapView.camera.altitude = 250;
    [self calculateAngleToNewObjective:location objectiveLocation:self.currentObjective.location];
    self.currentUserLocation = location;
    [self calculateAngleToNewObjective:self.currentUserLocation objectiveLocation:self.currentObjective.location];
    [self changeUserAnnotationColor:self.userPin];
    
}

-(void)locationControllerDidUpdateHeading:(CLHeading *)heading {

//    NSLog(@"%@", heading);
    self.mapView.camera.heading = heading.trueHeading;
    
    self.mapView.camera.pitch = 70;
    self.mapView.camera.altitude = 250;
    self.currentHeading = heading.trueHeading;
//    NSLog(@"User Heading: %f   Angle to next: %f", self.currentHeading, self.angleToNextObjective);
    [self calculateAngleToNewObjective:self.currentUserLocation objectiveLocation:self.currentObjective.location];
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
    self.currentObjective.completed = YES;
    
    NSArray *objectives = [[NSArray alloc]init];
    objectives = self.currentQuest.route.waypoints;

    while (((Objective *)[objectives objectAtIndex: index]).completed == YES) {
        
        if (index == self.currentQuest.route.waypoints.count-1) {
            NSLog(@"reached array limit, we out");
            
            //
            
            return;
        }
        
        index += 1;
    }

    self.currentObjective = self.currentQuest.route.waypoints[index];
    NSLog(@"Objective complete! Next objective is objective %@", self.currentObjective.name);
    [self setupObjectiveAnnotations];
    [self setUpRegion:self.currentObjective];
}

-(void) setUpRegion: (Objective *)objective {
   
    objective.range = @50;
    NSLog(@"Dis mah range bruh: %@", objective.range);
    
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(objective.location.coordinate.latitude, objective.location.coordinate.longitude);
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        CLCircularRegion *eventRegion = [[CLCircularRegion alloc]initWithCenter: coord radius:objective.range.floatValue identifier:objective.name];
        [[[LocationController sharedController]locationManager]startMonitoringForRegion:eventRegion];
        
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:coord radius:objective.range.floatValue];
        
        [self.mapView addOverlay:circle];
    }
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKCircleRenderer *circleRender = [[MKCircleRenderer alloc]initWithOverlay:overlay];
    circleRender.strokeColor = [UIColor blueColor];
    circleRender.lineWidth = 1;
    
    circleRender.fillColor = [UIColor redColor];
    circleRender.alpha = 0.25;
    
    return circleRender;
    
}

- (IBAction)completeButtonSelected:(UIButton *)sender {
    
    [self completeCurrentObjective];
    
}
@end
