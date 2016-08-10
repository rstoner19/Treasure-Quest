//
//  JSONParser.m
//  Treasure-Quest
//
//  Created by Sean Champagne on 8/6/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "JSONParser.h"
#import "FoursquareAPI.h"
#import "Objective.h"

@implementation JSONParser

+(NSArray *)foursquareJSONData:(NSDictionary *)jsonData
{
    NSMutableArray *foursquareData = [[NSMutableArray alloc]init];
    
    NSDictionary *dataPoints = jsonData[@"response"];
    
    NSArray *dataArray = dataPoints[@"venues"];
    
    for (NSDictionary *item in dataArray)
    {
     //   FoursquareAPI *data = [[FoursquareAPI alloc]init];
        
        NSString *venueName = item[@"name"];
        //NSLog(@"%@", venueName);
        NSArray *categories = item[@"categories"];
        NSArray *icon = [categories valueForKey:@"icon"];
        NSArray *prefix = [icon valueForKey:@"prefix"];
        NSDictionary *categoriesDictionary = item[@"icon"];
        NSString *imageURL = [NSString stringWithFormat:@"%@.png",prefix];
        //NSLog(@"%@", imageURL);
        NSString *infoCategory = [categories valueForKey:@"name"];
        //NSLog(@"%@", infoCategory);
        
        NSDictionary *location = item[@"location"];
        
        double lat = [[location objectForKey:@"lat"] doubleValue];
        double lng = [[location objectForKey:@"lng"] doubleValue];
        
        //NSLog(@"%f and %f", lat, lng);

        
        Objective *foursquareObjective = [Objective initWith:venueName imageURL:imageURL info:@"This is some information." category:infoCategory range:@15 latitude:lat longitude:lng];
      
        [foursquareData addObject:foursquareObjective];
        //NSLog(@"foursquaredata: %@", [foursquareData[0]name]);
        
    }
    return foursquareData;
}

+(FoursquareAPI *)dataFromJSON:(NSDictionary *)data
{
    NSArray *dataArray = data[@"items"];
    NSDictionary *userData = dataArray.firstObject;
    
    FoursquareAPI *foursquare = [[FoursquareAPI alloc]init];
    
    foursquare.name = userData[@"name"];
    foursquare.location = userData[@"location"];
    
    return foursquare;
}

@end
