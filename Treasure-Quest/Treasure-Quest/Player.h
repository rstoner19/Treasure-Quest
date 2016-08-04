//
//  Player.h
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Parse/Parse.h>

@interface Player : PFObject <PFSubclassing>

@property (strong, nonatomic) PFGeoPoint *currentLocation;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSNumber *speed;

@end
