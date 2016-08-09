//
//  LocationController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "LocationController.h"
#import "MapViewController.h"

@interface LocationController () <CLLocationManagerDelegate>

@end

@implementation LocationController

+(LocationController *)sharedController {
    
    static LocationController *sharedController = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self alloc]init];
    });
    
    return sharedController;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        _locationManager.headingFilter = 3;
        
    }
    
    [_locationManager requestAlwaysAuthorization];
    return self;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [self.delegate locationControllerDidUpdateLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
    
//    MapViewController *mapvc = [[MapViewController alloc]init];
//    mapvc.currentUserLocation = locations.lastObject;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    NSLog(@"New Heading: %f", newHeading.trueHeading);
    [self.delegate locationControllerDidUpdateHeading:newHeading];
    
}




@end
