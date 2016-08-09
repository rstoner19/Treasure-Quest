//
//  JSONParser.m
//  Treasure-Quest
//
//  Created by Sean Champagne on 8/6/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "JSONParser.h"
#import "FoursquareAPI.h"

@implementation JSONParser

+(NSArray *)foursquareJSONData:(NSDictionary *)jsonData
{
    NSMutableArray *foursquareData = [[NSMutableArray alloc]init];
    
    NSArray *dataPoints = jsonData[@"items"];
    
    for (NSDictionary *item in dataPoints)
    {
        FoursquareAPI *data = [[FoursquareAPI alloc]init];
        data.name = item[@""];
        
        NSDictionary *owner = item[@"name"];
        data.name = owner[@"name"];
        data.location = owner[@"location"];
        
        [foursquareData addObject:dataPoints];
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
