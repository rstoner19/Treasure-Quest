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
                                                                   
                                                                   [Objective initWith:@"World Class Coffee" imageURL:@"picture.com" info:@"sweet objective" category:@"Bar" range:@10.0 location:CLLocationCoordinate2DMake(47.617212, -122.3536802)],
                                                                   [Objective initWith:@"Space Needle Park" imageURL:@"2ndPicture.com" info:@"kinda cool" category:@"Landmark" range:@10.0 location:(CLLocationCoordinate2DMake(47.6192848, -122.3503663))],
                                                                   [Objective initWith:@"Olympic Sculpture Park" imageURL:@"3rdPicture.com" info:@"worst" category:@"Local Shitty Art" range:@10.0 location:CLLocationCoordinate2DMake(47.6170897, -122.3533829)],
                                                                   [Objective initWith:@"Buckleys" imageURL:@"4thPicture.com" info:@"Best" category:@"Artwork" range:@10.0 location:CLLocationCoordinate2DMake(47.6145925, -122.3491382)
                                                                   ], nil];
    
    return ourRoute;
}


@end
