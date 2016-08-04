//
//  Route.h
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Parse/Parse.h>
#import "Playfield.h"

@interface Route : PFObject <PFSubclassing>

@property (strong, nonatomic) PFGeoPoint *finalDestination;
@property (strong, nonatomic) Playfield *playfield;
@property (strong, nonatomic) NSMutableArray *waypoints;


@end
