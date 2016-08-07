//
//  Route.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Route.h"
#import "Objective.h"

@implementation Route

//
//
//+(void)load{
//    [self registerSubclass];
//
//}
//
//+(NSString *)parseClassName{
//    return @"Route";
//}



+(Route *)demoRoute{
    Route *ourRoute = [[Route alloc]init];
    ourRoute.finalDestination = CLLocationCoordinate2DMake(47.618217, -122.3540207);
    ourRoute.playfield.coordinate = CLLocationCoordinate2DMake(47.618217, -122.3540207);
    ourRoute.playfield.minRadius =  @100.0;
    ourRoute.playfield.maxRadius = @100.00;
    
    ourRoute.waypoints = [[NSMutableArray alloc]initWithObjects:
                                                                   [Objective initWith:@"World Class Coffee" imageURL:@"picture.com" info:@"sweet objective" category:@"Bar" range:@10.0 latitude:47.617212 longitude:-122.3536802],
                                                                   [Objective initWith:@"Space Needle Park" imageURL:@"2ndPicture.com" info:@"kinda cool" category:@"Landmark" range:@10.0 latitude:47.6192848 longitude:-122.3503663],
                                                                   [Objective initWith:@"Olympic Sculpture Park" imageURL:@"3rdPicture.com" info:@"worst" category:@"Local Shitty Art" range:@10.0 latitude:47.6170897 longitude:-122.3533829],
                                                                   [Objective initWith:@"Buckleys" imageURL:@"4thPicture.com" info:@"Best" category:@"Artwork" range:@10.0 latitude:47.6145925 longitude:-122.3491382
                                                                   ], nil];
    
    
    
    return ourRoute;
}

+ (double)totalDistanceCrowFlies:(Route *)route {
    double totalDistance = 0.00;
    for (int i = 1; i < route.waypoints.count; i++) {
        Objective *first = route.waypoints[i-1];
        Objective *second = route.waypoints[i];
        totalDistance += [first.location distanceFromLocation:second.location];
    }
    return totalDistance;
}

//+ (Route *)randomizeRoute:(Route *)originalRoute {
//    Route *copyRoute = [Route mutableCopy];
//    NSMutableArray *randomizedArray = [[NSMutableArray alloc]init];
//    while (copyArray.count > 1) {
//        int index = (int)(arc4random() * copyArray.count % ( copyArray.count - 1 ));
//        [randomizedArray addObject:[copyArray objectAtIndex:index]];
//        [copyArray removeObjectAtIndex:index];
//    }
//    [randomizedArray addObject:copyArray.lastObject];
//    return randomizedArray;
//}


@end
