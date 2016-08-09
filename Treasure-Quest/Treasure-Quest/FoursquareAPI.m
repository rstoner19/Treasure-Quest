//
//  FoursquareAPI.m
//  Treasure-Quest
//
//  Created by Sean Champagne on 8/6/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "FoursquareAPI.h"
#import "JSONParser.h"
@import UIKit;
@import AFNetworking;


static NSString * const BaseURLString = @"https://api.foursquare.com/v2/venues/";

@implementation FoursquareAPI


+(void)getFoursquareData:(NSString *)userData finalLat:(NSString *)finalLat finalLong:(NSString *)finalLong completionHandler:(foursquareFetchCompletion)completionHandler
{
    NSString *clientID = @"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY";
    NSString *clientSecret = @"HP0YY4ORAIF1Q1DKM4C24EUYHXG0SZBI5CYFZD030APKYIVL";
    //NSString *v = @"20160613";
   // NSString *venueID = "";
    NSString *searchURL = [NSString stringWithFormat:@"%@search?ll=%@,%@&client_id=%@&client_secret=%@&v=20160613&radius=1000", BaseURLString, finalLat, finalLong, clientID, clientSecret];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:searchURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GETTING JSON: %@", responseObject);
        NSArray *results = [JSONParser foursquareJSONData:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results, nil);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR GETTING JSON: %@", error);
    }];

    }


@end
