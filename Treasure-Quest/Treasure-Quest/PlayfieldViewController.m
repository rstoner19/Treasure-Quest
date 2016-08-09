//
//  PlayfieldViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "PlayfieldViewController.h"
#import "SummaryViewController.h"


@interface PlayfieldViewController () <MKMapViewDelegate, MKAnnotation, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation PlayfieldViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView.layer setCornerRadius:20.0];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];

    self.mapView.delegate = self;
    
    
}

-(void)locationControllerDidUpdateHeading:(CLHeading *)heading
{
    //
}

-(void)locationControllerDidUpdateLocation:(CLLocation *)location
{
     [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 50, 50) animated:YES];
    self.currentLat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.currentLong = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
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

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]]) { return nil; }
//
//    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
//
//    if (!annotationView)
//    {
//        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
//    }
//
//    annotationView.canShowCallout = YES;
//
//    UIButton *rightcalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//
//    annotationView.rightCalloutAccessoryView = rightcalloutButton;
//
//    return annotationView;
//}


- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = touchMapCoordinate;
        newPoint.title = @"Select Final Location!";
        newPoint.subtitle = @"End the quest here.";
        
        CLLocation *tempLocal = [[CLLocation alloc]initWithLatitude:newPoint.coordinate.latitude longitude:newPoint.coordinate.longitude];
        
        [LocationController sharedController].pinLocation = tempLocal;
        
        
        //newPoint.coordinate = CLLocationCoordinate2DMake(tempLocal.coordinate.latitude, tempLocal.coordinate.longitude);
        
        [self.mapView addAnnotation:newPoint];
        
    }
}

@end
