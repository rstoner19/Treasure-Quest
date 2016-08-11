//
//  MapViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "PlayerMapViewController.h"
@import MapKit;
#import "LocationController.h"
#import "Quest.h"
#import "Objective.h"
#import "ProgressListViewController.h"
#import "TabBarViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface PlayerMapViewController () <MKMapViewDelegate, LocationControllerDelegate>
- (IBAction)completeButtonSelected:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property float angleToNextObjective;
@property (strong, nonatomic) MKPinAnnotationView *userPin;

@end

@implementation PlayerMapViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    //    NSLog(@"mapview view did load %@",((TabBarViewController *)self.parentViewController).currentQuest.name);
    //    NSLog(@"string value? %@",((TabBarViewController *)self.parentViewController).mystring);
    [self.mapView.layer setCornerRadius:20.0];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setDelegate:self];
    [self.mapView setZoomEnabled:NO];
    [self.mapView setScrollEnabled:NO];
    [self.mapView setRotateEnabled:NO];
    [self.mapView setShowsBuildings:NO];
    [self.mapView setPitchEnabled:NO];
    [self.mapView setShowsPointsOfInterest:NO];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    [self.mapView setMapType:MKMapTypeStandard];
    

//    [self.mapView setUserTrackingMode:MKUserTrackingModeNone];

//    self.mapView.camera.pitch = 80;
//    self.mapView.camera.altitude = 250;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
    [[[LocationController sharedController] locationManager]startUpdatingHeading];
    //    ProgressListViewController *progressListVC = (ProgressListViewController *)[self.tabBarController.viewControllers objectAtIndex:0];
    //    self.tabbar.currentQuest = progressListVC.currentQuest;
    [self setupPlayerAnnotations];
    
}

-(void)setupPlayerAnnotations {
    [self.mapView removeAnnotations:self.mapView.annotations];

    NSUInteger index = 0;

    Objective *current = [[Objective alloc]init];
    current = ((TabBarViewController *)self.parentViewController).currentQuest.objectives[index];
    
//    NSArray *playersList = ((TabBarViewController *)self.parentViewController).currentQuest.objectives[index];
    
        for (NSString *user in ((TabBarViewController *)self.parentViewController).currentQuest.players) {
            NSLog(@"%@", user);
            
            PFQuery * query = [PFUser query];
            [query whereKey:@"objectId" equalTo:user];
            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                for (PFUser *user  in objects) {
                    NSLog(@"%@, %@", user.objectId, [PFUser currentUser].objectId);
                    if (![user.objectId isEqualToString: [PFUser currentUser].objectId]) {
                        
                        NSLog(@"Test: %@, Location: %@", user.username, [user objectForKey:@"userLocation"]);
                        PFGeoPoint *userLocation = [user objectForKey:@"userLocation"];
                        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(userLocation.latitude, userLocation.longitude);
                        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
                        newPoint.coordinate = loc;
                        newPoint.title = user.username;
                        [self.mapView addAnnotation:newPoint];
                        [self.mapView selectAnnotation:newPoint animated:NO];
                    }

                }
                    [self.mapView showAnnotations:self.mapView.annotations animated:YES];

            }];
            
        
        }


}

-(void)setRegionForCoordinate:(MKCoordinateRegion)region {

    [self.mapView setRegion:region animated:YES];
    NSLog(@"region is %@", region);

}

-(void)locationControllerDidUpdateLocation:(CLLocation *)location{

//    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 25, 25) animated:NO];
    
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
//    self.mapView.camera.altitude = 150;
//    self.mapView.camera.pitch = 80;
//    self.mapView.camera.centerCoordinate = location.coordinate;
    CLLocation *locationPointer = [[CLLocation alloc]initWithLatitude:((TabBarViewController *)self.parentViewController).currentObjective.latitude longitude:((TabBarViewController *)self.parentViewController).currentObjective.longitude];
    [self calculateAngleToNewObjective:location objectiveLocation:locationPointer];
    self.currentUserLocation = location;
    [self calculateAngleToNewObjective:self.currentUserLocation objectiveLocation:locationPointer];
    [self changeUserAnnotationColor:self.userPin];
    

}

-(void)locationControllerDidUpdateHeading:(CLHeading *)heading {

//    NSLog(@"current device heading: %@", heading);
//    self.mapView.camera.heading = heading.trueHeading;
//    self.mapView.camera.pitch = 80;
//    self.mapView.camera.altitude = 0;
    [self.mapView setCenterCoordinate:self.currentUserLocation.coordinate animated:YES];

    CLLocation *locationPointer = [[CLLocation alloc]initWithLatitude:((TabBarViewController *)self.parentViewController).currentObjective.latitude longitude:((TabBarViewController *)self.parentViewController).currentObjective.longitude];

//    NSLog(@"current objectives latitude from tabbar! = %f", ((TabBarViewController *)self.parentViewController).currentObjective.latitude);
    self.currentHeading = heading.trueHeading;
    [self calculateAngleToNewObjective:self.currentUserLocation objectiveLocation:locationPointer];

//   NSLog(@"User Heading: %f   Angle to next: %f", self.currentHeading, self.angleToNextObjective);
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

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * 180.0 / M_PI)

- (float)getHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc
{
    float fLat = degreesToRadians(fromLoc.latitude);
    float fLng = degreesToRadians(fromLoc.longitude);
    float tLat = degreesToRadians(toLoc.latitude);
    float tLng = degreesToRadians(toLoc.longitude);
    
    float degree = radiansToDegrees(atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng)));
    
    if (degree >= 0) {
        return degree;
    } else {
        return 360+degree;
    }
}

-(void) calculateAngleToNewObjective:(CLLocation *)userLocation objectiveLocation: (CLLocation *)objectiveLocation {

    float userLatRadians = degreesToRadians(userLocation.coordinate.latitude);
    float userLongRadians = degreesToRadians(userLocation.coordinate.longitude);
    
    float objectiveLatRadians = degreesToRadians(objectiveLocation.coordinate.latitude);
    float objectiveLongRadians = degreesToRadians(objectiveLocation.coordinate.longitude);


    float deltaLong = objectiveLongRadians - userLongRadians;
    float y = sin(deltaLong) * cos(objectiveLatRadians);
    float x = cos(userLatRadians) * sin(objectiveLatRadians) - sin(userLatRadians) * cos(objectiveLatRadians) * cos(deltaLong);
    float bearingInRadians = atan2f(y, x);
    self.angleToNextObjective = fmod(((bearingInRadians * 180 / M_PI) + 360), 360);



}

-(MKPinAnnotationView*)changeUserAnnotationColor: (MKPinAnnotationView *)userPin {
    //TODO: adjust opacity based on accuracy percentage
    //float difference = fabs(self.currentHeading - self.angleToNextObjective);

    if (self.currentHeading <= self.angleToNextObjective + 10 && self.currentHeading >= self.angleToNextObjective - 10) {

        self.userPin.pinTintColor = [UIColor greenColor];
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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
    ((TabBarViewController *)self.parentViewController).currentObjective.completed = YES;
    //    [self.currentObjective save];

    NSArray *objectives = [[NSArray alloc]init];
    objectives = ((TabBarViewController *)self.parentViewController).currentQuest.objectives;

    while (index < ((TabBarViewController *)self.parentViewController).currentQuest.objectives.count) {
        Objective *objective = [objectives objectAtIndex: index];
        if (objective.completed == NO){
            break;
        }
        index++;
    }

    if (index == ((TabBarViewController *)self.parentViewController).currentQuest.objectives.count){
        NSLog(@"end of the line");
        return;
    }

    ((TabBarViewController *)self.parentViewController).currentObjective = ((TabBarViewController *)self.parentViewController).currentQuest.objectives[index];

    //    NSLog(@"Objective complete! Next objective is objective %@", self.tabbar.currentObjective.name);
    [self setupPlayerAnnotations];
    [self setUpRegion:((TabBarViewController *)self.parentViewController).currentObjective];
    NSString *message = [NSString stringWithFormat:@"%@ has reached goal #%i!!", [PFUser currentUser].username, (int)index ];
    [self questPushNotification:message];
    
}

-(void) setUpRegion: (Objective *)objective {

    objective.range = @50;
    NSLog(@"Dis mah range bruh: %@", objective.range);

    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(objective.latitude, objective.longitude);

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

- (void)questPushNotification: (NSString *)message  {

    [PFCloud callFunctionInBackground:@"iosPushToChannel"
                       withParameters:@{@"text":message,
                                        @"channel": [[PFUser currentUser] objectForKey:@"currentQuestId"]}
                                block:^(NSString *response, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@",response );
                                    }
                                }];
}

-(void)userDidEnterObjectiveRegion:(CLRegion *)region{
    
    [self completeCurrentObjective];
    
}

@end
