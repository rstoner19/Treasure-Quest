//
//  PlayerMapViewController.h
//  Treasure-Quest
//
//  Created by Derek Graham on 8/5/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface PlayerMapViewController : UIViewController

@property CLLocationDirection currentHeading;
@property (strong, nonatomic) CLLocation *currentUserLocation;

@end
